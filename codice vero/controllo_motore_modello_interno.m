clc;
clear all;
close all;

%% misc
Simulation_Time = 5 ;    % tempo di esecuzione della simulazione
step_time_input = 1 ;    % step time dell'ingresso a gradino
%vel_CI = 0 ;             % condizioni iniziali integratore velocit�
%pos_CI = 0 ;             % condizioni iniziali integratore posizione

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
% bEq = (bm * N^2) + bl;
Jeq = (Jm * N^2) + Jl;

%% creo il modello del motore e lo retroaziono

a = -(bEq*R + KphiEq^2) / (Jeq*R) ;
b = KphiEq / (Jeq*R);
c = Kt ;



A = [ 0 ,1 ;
      0 ,a];

B = [0 ;  
     b];
  
C = [ c , 0];

Az = [ 0 , 1 , 0 , 0 ;
       -omegazero^2 , 0 , C ;
       0 , 0 , 0 , 1 ; 
       0 , 0 , 0 , a ] ;
       
Bz = [ 0 ;
       0 ;
       B ]; 
       
   
   
%scelto la configurazione (D) dei poli
wn = 20 ;

w1 = -  wn * cos(pi/4) + i * wn*sin(pi/4);
w2 = - wn * cos(pi/6) + i * wn*sin(pi/6) ;
w3 = - wn * cos(pi/6) - i * wn*sin(pi/6);
w4 = -  wn * cos(pi/4) - i * wn*sin(pi/4) ;
W = [w1 , w2 , w3 , w4]; %poli desiderati per garantire sovraelongazione,t.assestamento5%

%retroazione
K = acker ( Az , Bz , W ); %matrice di retroazione affinche' Az-BzK abbia quei poli
K3 = [K(3) , K(4)];



% %% SIMULA
% sim('controllore_stato_inseguimentosen.slx');
% 
% 
% plot(angolo_motore)
% 
% 
% %% calcolo errore di fase e di guadagno
% 
% guadagno_desiderato = amplitude ;
% fase_desiderata = 0 ;
% 
% massimo_relativo = 0 ;
% guadagno_reale = 0 ;
% fase_reale = 0 ;
% indice_massimo_relativo = 0 ;
% 
% for i = 2: ( length(angolo_motore) - 1 )
%   
%     if  angolo_motore(i) == massimo_relativo
%        guadagno_reale = massimo_relativo ; 
%        periodo = i-indice_massimo_relativo ;
%     end
%     
%     if ( ( angolo_motore(i) > angolo_motore(i-1) ) &&  ( angolo_motore(i) > angolo_motore(i+1) ) ) ;
%       
%         massimo_relativo = angolo_motore(i) ;
%         indice_massimo_relativo = i ;
%         
%     end
%     
% end
% 
%     
% errore_guadagno = guadagno_desiderato - guadagno_reale    
% indice_primo_picco = indice_massimo_relativo ; 
% 
% while ( indice_primo_picco > 0 )
%     indice_primo_picco = indice_primo_picco - periodo ;
% end
% 
% sfasamento = ( indice_primo_picco + periodo/4 ) / 1000 ; %dopo quanti secondi inizia la sinusoide dell'uscita 
% fase_reale = sfasamento / omegazero ; 
% errore_fase = fase_desiderata - fase_reale;
% guadagno_reale
% fase_reale
% errore_guadagno
% errore_fase
%     
