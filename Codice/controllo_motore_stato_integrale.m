%% misc
simulation_time= 10;    % tempo di esecuzione della simulazione
step_time_input = 1;    % step time dell'ingresso a gradino

%% specifiche progetto
ts = 0.15;              % ts < 0.15
S = 10 / 100;           % S < 10%
r = 120;                 % [gradi] - ampiezza gradino
d = -0.2;                  % ampiezza disturbo sincronizzato al riferimento

%% parametri motore (presi dalla tabella)
% L = 0 per ipotesi
Kg2v = 5 / 176;
Kr2v = 180 * Kg2v / pi ;
Kt = Kr2v ;
Kphi = 7.67 * 10^-3;
R = 2.6;
Jm = 3.87 * 10^-7;
Jl = 3.42 * 10^-5;
N = 14;
bm = 0;
bl = 0;

% calcolo parametri ecquivalenti
KphiEq = N * Kphi;
bEq = 0 ;
Jeq = (Jm * N^2) + Jl;

%% creo il modello del motore e lo retroaziono
a = -(bEq*R + KphiEq^2) / (Jeq*R) ;
b = KphiEq / (Jeq*R);
c = Kt;
A = [0, 1;
     0, a];
B = [0;  
     b];
C = [c, 0];

Az = [0, c, 0;
      0, 0, 1;
      0, 0, a];
       
Bz = [0;
      0;
      b];
   
sigma = 3 / ts;
xi = 0.6;
wn = sigma / xi;
theta = acos(0.6);
h = wn * sin(theta);
% scelto la configurazione (D) dei poli
w1 = - sigma + i * h;
w2 = - sigma - i * h;
w3 = - sigma;
W = [w1 - sigma, w2 - sigma, w3 - 2*sigma]; % poli desiderati
K = acker (Az, Bz, W);                % matrice di retroazione K
Ki = K(1);                            % prima colonna -> guadagno Ki

%% SIMULA
sim('controllore_stato_integrale_new.slx');