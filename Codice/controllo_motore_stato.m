%% pulisci workspace
clc; clear all; close all;

%% misc
simulation_time = 5;      % tempo di esecuzione della simulazione
step_time_input = 1;      % step time dell'ingresso a gradino

%% specifiche progetto
ts = 0.15;                % ts < 0.15
S = 10 / 100;             % S < 10%
r = 50;                   % [gradi] - ampiezza gradino
d = 0;                  % [Volt] - disturbo additivo  

%% parametri motore (presi dalla tabella)
% L = 0 per ipotesi
Kg2v = 5 / 176;
Kr2v = 180 * Kg2v / pi;

Kphi = 7.67 * 10^-3;
R = 2.6;
Jm = 3.87 * 10^-7;
Jl = 3.42 * 10^-5;
N = 14;
bm = 0;
bl = 0;

% calcolo parametri ecquivalenti
KphiEq = N * Kphi;
bEq = 0;
Jeq = (Jm * N^2) + Jl;

%% creo il modello del motore e lo retroaziono

a = -(bEq*R + KphiEq^2) / (Jeq*R);
b = KphiEq / (Jeq*R);
c = Kr2v;
A = [ 0 ,1 ;
      0 ,a];
B = [0 ;  
     b];
C = [ c , 0];

sigma = 3 / ts;
xi = 0.6;                % dalla tabella
wn = sigma / xi; 
theta = acos(0.6);       % poiche' xi=cos(theta)
h = wn * sin(theta);     % parte immaginaria del polo

w1 = - sigma + i * h;    % polo desiderato 1
w2 = - sigma - i * h;    % polo desiderato 2
W = [w1 , w2];           % poli desiderati 

K = place ( A , B , W ); % matrice di retroazione

%% calcolo termine feed-forward
N = 1 / (- C * inv(A - B * K) * B);

%% ritaratura N
if r==10 && d==0.2
    N = N * 10/16.314;
elseif r==50 && d==0.2
    N = N * 50 / 54.195;
elseif r==120 && d==0.2
    N = N * 120/123.9993;
elseif r==10 && d==-0.2
    N = N * 10/7.20965;
elseif r==50 && d==-0.2
    N = N * 50/46.4077;
elseif r==120 && d==-0.2
    N = N * 120/116.2506;
end

%% SIMULA
A = [0, 1;
     0, 1.2*a];
sim('modello_motore_stato.slx');
figure()
plot(angolo_motore)

%% calcolo tempo di salita
numero_campioni = simulation_time * (1 / 0.001);

%% massima sovraelongazione
S = 100 * ((max(angolo_motore(:)) - r) / r);
if ( S < 0 )
    fprintf('non esiste S\n');
else
    S
end

%% tempo di assestamento
ts = -1;
for i = 1 : 1 : numero_campioni
   
    if (angolo_motore(i) >= r + (0.05 * r)) || (angolo_motore(i) <= r - (0.05 * r))  
        ts = i-1;
    end
end

ts = ts * 0.001 - step_time_input;
if (ts ==  (simulation_time - step_time_input) )
    fprintf ('non si assesta\n');
else
    ts
end