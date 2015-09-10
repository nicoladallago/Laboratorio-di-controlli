%% misc
Simulation_Time = 5 ;     % tempo di esecuzione della simulazione
step_time_input = 1 ;     % step time dell'ingresso a gradino

%% specifiche progetto
T0 = 0.05;
amplitude = 50 ;
omegazero = 2 * pi / T0 ; % frequenza sinusoide da inseguire

%% parametri motore (presi dalla tabella)
% L = 0 per ipotesi
Kg2v = 5 / 176;
Kr2v = 180 * Kg2v / pi ;
Kt = Kr2v ;
Tl = 0.001;

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
c = Kt ;
A = [0, 1 ;
     0, a];
B = [0 ;  
     b];
C = [c, 0];
Az = [0,            1, 0, 0 ;
      -omegazero^2, 0, C    ;
      0,            0, 0, 1 ; 
      0,            0, 0, a];
Bz = [0 ;
      0 ;
      B]; 
       
%scelgo la configurazione (D) dei poli
wn = 20 ;
w1 = -wn*cos(pi/4) + 1i*wn*sin(pi/4);
w2 = -wn*cos(pi/6) + 1i*wn*sin(pi/6);
w3 = -wn*cos(pi/6) - 1i*wn*sin(pi/6);
w4 = -wn*cos(pi/4) - 1i*wn*sin(pi/4);
W = [w1 , w2 , w3 , w4]; %poli desiderati

%retroazione
K = acker (Az , Bz , W); %matrice di retroazione
K3 = [K(3) , K(4)];

%% SIMULA
sim('controllore_stato_inseguimentosen.slx');