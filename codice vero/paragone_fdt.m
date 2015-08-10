close all; clc;
%% NOTA : dato che ci sono delle variabili con nome comune usare il programma solo meta' alla volta, 
%% far partire il file .m relativo al modello interno o al modello integrale e poi lanciare 
%% questo programma con solo la meta' corrispondente non commentata

s = tf('s');

%% calcolo la fdt del modello interno      <-- OK QUESTO FUNZIONA
num_P = [ K(2) , K(1)];
den_P = [1 , 0, omegazero^2];
W_P = tf(num_P, den_P); %blocco dopo l'errore

W_ABC_mod = C * inv(s*eye(2) - (A - B * K3) ) * B; %fdt del modello di stato(A,B,C,K)

W1 = W_P * W_ABC_mod;

W_modello_interno = minreal ( W1 / (1 + W1));
[N, D] = tfdata(W_modello_interno, 'v'); % numeratore e denominatore

%estrae aplitude, phase e frequency values 
[a,p,w] = bode(N,D);
%adesso salvali
a_modello_interno = 20*log10(a)';
p_modello_interno = p';
w_modello_interno = w';

%converti per salvare in .dat
amplitude = zeros(length(a_modello_interno), 2);
phase = zeros(length(a_modello_interno), 2);
for i=1 : 1 : length(a_modello_interno)
    amplitude(i, 1) = w_modello_interno(i);
    amplitude(i, 2) = a_modello_interno(i);
    
    phase(i, 1) = w_modello_interno(i);
    phase(i, 2) = p_modello_interno(i);
end
%salva in .dat
save('bode_amplitude.dat', 'amplitude', '-ascii');
save('bode_phase.dat', 'phase', '-ascii');

%stampa per curiosità :)
figure()
bode(W_modello_interno)



%% calcolo la fdt del modello interno 

% W_P = K(1) / s ;
% W_ABC_int = C * inv(s*eye(2) - (A - B * [K(2) , K(3)] ) ) * B ;
% W2 = W_P * W_ABC_int ;
% W_integrale = minreal ( W2 / (1 + W2) );
% [N, D] = tfdata(W_integrale, 'v'); % numeratore e denominatore
% 
% % estrae aplitude, phase e frequency values 
% [a,p,w] = bode(N,D);
% % adesso salvali
% a_modello_interno = 20*log10(a)';
% p_modello_interno = p';
% w_modello_interno = w';
% 
% % converti per salvare in .dat
% amplitude = zeros(length(a_modello_interno), 2);
% phase = zeros(length(a_modello_interno), 2);
% for i=1 : 1 : length(a_modello_interno)
%     amplitude(i, 1) = w_modello_interno(i);
%     amplitude(i, 2) = a_modello_interno(i);
%     
%     phase(i, 1) = w_modello_interno(i);
%     phase(i, 2) = p_modello_interno(i);
% end
% % salva in .dat
% save('bode_amplitude.dat', 'amplitude', '-ascii');
% save('bode_phase.dat', 'phase', '-ascii');
% 
% % stampa per curiosità :)
% figure()
% bode(W_integrale)