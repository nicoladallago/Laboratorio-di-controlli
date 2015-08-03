%% pulisci workspace
clc; clear all; close all;

%% specifiche progetto
t_s_max = 0.3;                 % [s] rispetto a +-1%r
S = 5;                         % gradi
r = 120;                        % ampiezza segnale di riferimento 
d = 0.5;                       % ampiezza disturbo in ingresso

%% funzione di trasferimento del motoriduttore
P = tf(375, [1 40 0]);         % processo P 
[numP, denP] = tfdata(P, 'v'); % estrae numeratore e denominatore

%% calcolo parametri PID con desaturatore
if r == 10   
    xi = 0.22;                 % da figura 9 S=50% 
    m_phi_G = 24;              % da figura 9 S=50%
elseif r == 50
    xi = 0.59;                 % da figura 9 S=10%
    m_phi_G = 58.5;            % da figura 9 S=10%
elseif r == 120
    xi = 0.7;                  % da figura 9 S=4.17% 
    m_phi_G = 66;              % da figura 9 S=4.17%
end

alpha = 0.1;                   % alpha appartiene a [1/3 , 1/10]
b = 4;                         % b appartiene a [4, inf)

w_a_min = 3 / (xi * t_s_max);  % pulsazione di attraversamento minima
tau_L = alpha / w_a_min;       % termine non idealita' parte derivativa
[mag_w_a, angle_w_a] = bode(P, w_a_min); % modulo e fase del processo alla
                                         % minima pulsazione di
                                         % attraversamento
a = 1 / mag_w_a;
theta = m_phi_G  - 180 - angle_w_a;

K_p = a * cos(theta);          % guadagno proporzionale 
K_i = ((a * w_a_min) / 2) * (sqrt((sin(theta))^2 + ...
    (4/b)*(cos(theta))^2) - sin(theta)); % guadagno integrale
K_d = K_p^2 / (b * K_i);       % guadagno derivativo 

t_r = 1.8 / w_a_min;
K_a = (1 / 3) * (t_r / K_i);   % guadagno desaturatore   

%% ritaratura parametri PID
%K_p = K_p * 9;
%K_i = K_i * 10;
%K_d = K_d * 4.5;

%% simulazione
step_time_input = 1;           % [s] step time dell'ingresso a gradino
simulation_time = 5;           % [s] tempo di simulazione
K_g2v = 0.0284;                % costante di conversione da gradi a volt
K_r2v = 1.63;                  % costante di conversione da gradi a volt 
                               % all'uscita del motore

sim('modello_motore_PID_desaturatore'); % simulazione SIMULINK

%% verifica prestazioni
% calcolo tempo di salita
numero_campioni = simulation_time * (1 / 0.001);
for i = 1 : 1 : numero_campioni   
    if angolo_motore_PID(i) >= 0.1 * r
        t10 = i;
        break;
    end
end
for i = 1 : 1 : numero_campioni
    if angolo_motore_PID(i) >= 0.9 * r
        t90 = i;
        break;
    end
end
tr = (t90 - t10) * 0.001;

% massima sovraelongazione
S = 100 * ((max(angolo_motore_PID(:)) - r) / r);
S = r * (S / 100)

% tempo di assestamento
ts = -1;
for i = 1 : 1 : numero_campioni
    if ((angolo_motore_PID(i) >= r * (101 / 100)) || ...
            (angolo_motore_PID(i) <= r * (99 / 100)))  
        ts = i - 1;
    end
end
ts = ts * 0.001 - step_time_input