%% REU 02/10
% D�finition des param�tres de notre avion

clear all
close all
clc 

%% ON DEFINIT LA GEOMETRIE
% On moyenne sur les valeurs des trois avions semblables

S_emp = [1492 1452 1345];
b_emp = [117.8 117.5 112.6];
A_emp = [9.300 9.500 9.423];
longueur_totale_emp = [138.5 123.3 110.2];
D_emp = [13.32 12.14 11.61];

S = mean(S_emp);
b = mean(b_emp);
A = (b*b)/S;
longueur_totale = mean(longueur_totale_emp);
D = mean(D_emp);

%% ON DEFINIT LE PAYLOAD
Wpayload = 70*(180+40)+3*180; %pour l'�quipage on ne compte que les bagages cabine

%% ON DEFINIT LE RANGE
range = 5000;

%% ON DEFINIT LES MOTEURS
% Nombre de moteurs : 2 (�tude historique)
TSFC = 0.5; 

%% ON DEFINIT LES PARAMETRES PAR DEFAUT
M_cruise = 0.85;
H_cruise = 40000; %Altitude de croisi�re usuelle
T_loiter=30; %30min d'attente
Wres=0.05; % Fraction d'essence avant l'atterrisage
Wtrap=0.01; % Fraction d'essence dans les conduites


%% ON DETERMINE LE POIDS
[ Wto, Wfuel, Wempty ] = itertow( 'jet-transport', M_cruise, H_cruise, ...
    A, TSFC, T_loiter, Wres, Wtrap, Wpayload, range );

Wlanding = Wto-Wfuel;
%% ON DETERMINE LA POUSSEE
T = Wto*0.35;% Cours 3, valeurs typiques longues distances

%% RATIO POUSSEE POIDS
T_Wto = T/Wto;




