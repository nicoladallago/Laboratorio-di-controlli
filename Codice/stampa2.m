%% pulisci workspace
clc; clear; close all;


%% stamapare grafici?
stampa_grafici = true;


%% apri tutti gli ingressi
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=10_T=1.mat');
ingresso_a10_T1 = ingresso_motore;
uscita_a10_T1 = angolo_motore;
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=10_T=0,5.mat');
ingresso_a10_T05 = ingresso_motore;
uscita_a10_T05 = angolo_motore;
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=10_T=0,25.mat');
ingresso_a10_T025 = ingresso_motore;
uscita_a10_T025 = angolo_motore;
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=10_T=0,15.mat');
ingresso_a10_T015 = ingresso_motore;
uscita_a10_T015 = angolo_motore;

load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=20_T=1.mat');
ingresso_a20_T1 = ingresso_motore;
uscita_a20_T1 = angolo_motore;
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=20_T=0,5.mat');
ingresso_a20_T05 = ingresso_motore;
uscita_a20_T05 = angolo_motore;
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=20_T=0,25.mat');
ingresso_a20_T025 = ingresso_motore;
uscita_a20_T025 = angolo_motore;
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=20_T=0,15.mat');
ingresso_a20_T015 = ingresso_motore;
uscita_a20_T015 = angolo_motore;

load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=50_T=1.mat');
ingresso_a50_T1 = ingresso_motore;
uscita_a50_T1 = angolo_motore;
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=50_T=0,5.mat');
ingresso_a50_T05 = ingresso_motore;
uscita_a50_T05 = angolo_motore;
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=50_T=0,25.mat');
ingresso_a50_T025 = ingresso_motore;
uscita_a50_T025 = angolo_motore;
load('7/simulazioni laboratorio modello interno/es_7_modellointerno_a=50_T=0,15.mat');
ingresso_a50_T015 = ingresso_motore;
uscita_a50_T015 = angolo_motore;


%% stampa grafici
if stampa_grafici
    % stampa tutti ingressi T1
    figure()
    plot(ingresso_a10_T1)
    hold on
    plot(ingresso_a20_T1)
    hold on
    plot(ingresso_a50_T1)
    xlim([0 5000])
    
    % stampa tutti ingressi T05
    figure()
    plot(ingresso_a10_T05)
    hold on
    plot(ingresso_a20_T05)
    hold on
    plot(ingresso_a50_T05)
    xlim([0 5000])
    
    % stampa tutti ingressi T025
    figure()
    plot(ingresso_a10_T025)
    hold on
    plot(ingresso_a20_T025)
    hold on
    plot(ingresso_a50_T025)
    xlim([0 5000])    
    
    % stampa tutti ingressi T015
    figure()
    plot(ingresso_a10_T015)
    hold on
    plot(ingresso_a20_T015)
    hold on
    plot(ingresso_a50_T015)
    xlim([0 5000])
    
    % stampa tutte uscite T1
    figure()
    plot(uscita_a10_T1)
    hold on
    plot(uscita_a20_T1)
    hold on
    plot(uscita_a50_T1)
    xlim([0 5000]) 
    
    % stampa tutte uscite T05
    figure()
    plot(uscita_a10_T05)
    hold on
    plot(uscita_a20_T05)
    hold on
    plot(uscita_a50_T05)
    xlim([0 5000])
    
    % stampa tutte uscite T025
    figure()
    plot(uscita_a10_T025)
    hold on
    plot(uscita_a20_T025)
    hold on
    plot(uscita_a50_T025)
    xlim([0 5000])
    
    % stampa tutte uscite T015
    figure()
    plot(uscita_a10_T015)
    hold on
    plot(uscita_a20_T015)
    hold on
    plot(uscita_a50_T015)
    xlim([0 5000])    

end


%% trasforma tutto per vettori in .dat
in_a10_T1 = zeros(5000, 2);
in_a10_T05 = zeros(5000, 2);
in_a10_T025 = zeros(5000, 2);
in_a10_T015 = zeros(5000, 2);
out_a10_T1 = zeros(5000, 2);
out_a10_T05 = zeros(5000, 2);
out_a10_T025 = zeros(5000, 2);
out_a10_T015 = zeros(5000, 2);

in_a20_T1 = zeros(5000, 2);
in_a20_T05 = zeros(5000, 2);
in_a20_T025 = zeros(5000, 2);
in_a20_T015 = zeros(5000, 2);
out_a20_T1 = zeros(5000, 2);
out_a20_T05 = zeros(5000, 2);
out_a20_T025 = zeros(5000, 2);
out_a20_T015 = zeros(5000, 2);

in_a50_T1 = zeros(5000, 2);
in_a50_T05 = zeros(5000, 2);
in_a50_T025 = zeros(5000, 2);
in_a50_T015 = zeros(5000, 2);
out_a50_T1 = zeros(5000, 2);
out_a50_T05 = zeros(5000, 2);
out_a50_T025 = zeros(5000, 2);
out_a50_T015 = zeros(5000, 2);

for i=1 : 5000
    
    in_a10_T1(i, 1) = i;
    in_a10_T1(i, 2) = ingresso_a10_T1(i);
    in_a10_T05(i, 1) = i;
    in_a10_T05(i, 2) = ingresso_a10_T05(i);
    in_a10_T025(i, 1) = i;
    in_a10_T025(i, 2) = ingresso_a10_T025(i);
    in_a10_T015(i, 1) = i;
    in_a10_T015(i, 2) = ingresso_a10_T015(i);    
    out_a10_T1(i, 1) = i;
    out_a10_T1(i, 2) = uscita_a10_T1(i);
    out_a10_T05(i, 1) = i;
    out_a10_T05(i, 2) = uscita_a10_T05(i);
    out_a10_T025(i, 1) = i;
    out_a10_T025(i, 2) = uscita_a10_T025(i);
    out_a10_T015(i, 1) = i;
    out_a10_T015(i, 2) = uscita_a10_T015(i);        

    in_a20_T1(i, 1) = i;
    in_a20_T1(i, 2) = ingresso_a20_T1(i);
    in_a20_T05(i, 1) = i;
    in_a20_T05(i, 2) = ingresso_a20_T05(i);
    in_a20_T025(i, 1) = i;
    in_a20_T025(i, 2) = ingresso_a20_T025(i);
    in_a20_T015(i, 1) = i;
    in_a20_T015(i, 2) = ingresso_a20_T015(i);
    out_a20_T1(i, 1) = i;
    out_a20_T1(i, 2) = uscita_a20_T1(i);
    out_a20_T05(i, 1) = i;
    out_a20_T05(i, 2) = uscita_a20_T05(i);
    out_a20_T025(i, 1) = i;
    out_a20_T025(i, 2) = uscita_a20_T025(i);
    out_a20_T015(i, 1) = i;
    out_a20_T015(i, 2) = uscita_a20_T015(i);    
    
    in_a50_T1(i, 1) = i;
    in_a50_T1(i, 2) = ingresso_a50_T1(i);
    in_a50_T05(i, 1) = i;
    in_a50_T05(i, 2) = ingresso_a50_T05(i);
    in_a50_T025(i, 1) = i;
    in_a50_T025(i, 2) = ingresso_a50_T025(i);
    in_a50_T015(i, 1) = i;
    in_a50_T015(i, 2) = ingresso_a50_T015(i);
    out_a50_T1(i, 1) = i;
    out_a50_T1(i, 2) = uscita_a50_T1(i);
    out_a50_T05(i, 1) = i;
    out_a50_T05(i, 2) = uscita_a50_T05(i);
    out_a50_T025(i, 1) = i;
    out_a50_T025(i, 2) = uscita_a50_T025(i);
    out_a50_T015(i, 1) = i;
    out_a50_T015(i, 2) = uscita_a50_T015(i);    
end


%% salva i dati in .dat
save('in_a10_T1.dat', 'in_a10_T1', '-ascii');
save('in_a10_T05.dat', 'in_a10_T05', '-ascii');
save('in_a10_T025.dat', 'in_a10_T025', '-ascii');
save('in_a10_T015.dat', 'in_a10_T015', '-ascii');
save('out_a10_T1.dat', 'out_a10_T1', '-ascii');
save('out_a10_T05.dat', 'out_a10_T05', '-ascii');
save('out_a10_T025.dat', 'out_a10_T025', '-ascii');
save('out_a10_T015.dat', 'out_a10_T015', '-ascii');

save('in_a20_T1.dat', 'in_a20_T1', '-ascii');
save('in_a20_T05.dat', 'in_a20_T05', '-ascii');
save('in_a20_T025.dat', 'in_a20_T025', '-ascii');
save('in_a20_T015.dat', 'in_a20_T015', '-ascii');
save('out_a20_T1.dat', 'out_a20_T1', '-ascii');
save('out_a20_T05.dat', 'out_a20_T05', '-ascii');
save('out_a20_T025.dat', 'out_a20_T025', '-ascii');
save('out_a20_T015.dat', 'out_a20_T015', '-ascii');

save('in_a50_T1.dat', 'in_a50_T1', '-ascii');
save('in_a50_T05.dat', 'in_a50_T05', '-ascii');
save('in_a50_T025.dat', 'in_a50_T025', '-ascii');
save('in_a50_T015.dat', 'in_a50_T015', '-ascii');
save('out_a50_T1.dat', 'out_a50_T1', '-ascii');
save('out_a50_T05.dat', 'out_a50_T05', '-ascii');
save('out_a50_T025.dat', 'out_a50_T025', '-ascii');
save('out_a50_T015.dat', 'out_a50_T015', '-ascii');
