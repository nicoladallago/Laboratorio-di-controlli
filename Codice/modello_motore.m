%% specifiche progetto
t_s_max = 0.3;                 % [s] rispetto a +-1%r
S = 5;                         % gradi
r = 120;                        % ampiezza segnale di riferimento 
d = -0.5;                       % ampiezza disturbo in ingresso

%% funzione di trasferimento del motoriduttore
% L = 0 per ipotesi
Kg2v = 5 / 176;
Kr2v = (180 / pi) * Kg2v;
Kphi = 7.67 * 10^-3;
R = 2.6;
Jm = 3.87 * 10^-7;
Jl = 3.42 * 10^-5;
N = 14;
bm = 0;
bl = 0;

% calcolo parametri ecquivalenti
KphiEq = N * Kphi;
bEq = (bm * N^2) + bl;
Jeq = (Jm * N^2) + Jl;

numP = KphiEq;
denP = [R*Jeq (R*bEq + KphiEq^2) 0];
P = tf(numP, denP);

%% calcolo parametri PID con desaturatore
xi = 0.7;                  % da figura 9 S=4.17% 
m_phi_G = 65;              % da figura 9 S=4.17%
alpha = 0.3;                   % alpha appartiene a [1/3 , 1/10]
b = 4;                         % b appartiene a [4, inf)
w_a_min = 3 / (xi * t_s_max);  % pulsazione di attraversamento minima
%tau_L = alpha / w_a_min;      % termine non idealita' parte derivativa
tau_L = 0.001;
[mag_w_a, angle_w_a] = bode(P, w_a_min); % modulo e fase del processo alla
                                         % minima pulsazione di
                                         % attraversamento
a = 1 / mag_w_a;
theta = m_phi_G  - 180 - angle_w_a;

K_p = a * cosd(theta);         % guadagno proporzionale 
K_i = ((a * w_a_min) / 2) * (sqrt((sind(theta))^2 + ...
    (4/b)*(cosd(theta))^2) - sind(theta)); % guadagno integrale
K_d = K_p^2 / (b * K_i);       % guadagno derivativo  

%% ritaratura parametri PID
K_p = K_p * 9;
K_i = K_i * 10;
K_d = K_d * 4.5;

t_r = 1.8 / abs(w_a_min);
K_a = 3 / (t_r * K_i);         % guadagno desaturatore  

%% simulazione
step_time_input = 1;           % [s] step time dell'ingresso a gradino
simulation_time = 5;           % [s] tempo di simulazione 
                               % all'uscita del motore

sim('modello_motore_PID_desaturatore'); % simulazione SIMULINK