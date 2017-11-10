
%% REU 02/10
% D?finition des param?tres de notre avion

clear all
close all
clc 

%% ON DEFINIT LA GEOMETRIE
% 
A_emp = [9.300 9.500 9.423];
A = mean(A_emp);

longueur_totale_emp = [138.5 123.3 110.2];
D_emp = [13.32 12.14 11.61];
longueur_totale = mean(longueur_totale_emp);
D = mean(D_emp);

%% ON DEFINIT LE PAYLOAD
poids_passager = 180;
poids_bagage = 60;
Wpayload = 70*(poids_passager+poids_bagage)+3*poids_passager; %pour l'?quipage on ne compte que les bagages cabine

%% ON DEFINIT LE RANGE
range = 5000;

%% ON DEFINIT LES MOTEURS
% Nombre de moteurs : 2 (?tude historique)
TSFC = 0.5; 

%% ON DEFINIT LES PARAMETRES PAR DEFAUT
M_cruise = 0.85;
H_cruise = 32e3; %Altitude de croisi?re usuelle

T_loiter=30; %30min d'attente
Wres=0.05; % Fraction d'essence avant l'atterrisage
Wtrap=0.01; % Fraction d'essence dans les conduites


%% ON DETERMINE LE POIDS
    [ Wto, Wfuel, Wempty ] = itertow( 'jet-transport', M_cruise, H_cruise, ...
A, TSFC, T_loiter, Wres, Wtrap, Wpayload, range );
    Cd0 = 0.021;
    W2 = 0.975*(1-0.04*M_cruise)*Wto
    WS_TO = 125;
    S= Wto/WS_TO;
    cte = 2/M_cruise^2*W2/S*(3*1/(pi*A*0.8)*1/Cd0)^0.5;
    H = [0:1e3:40e3];

    for i=1:size(H,2)
        var(i) = 1.4*1716.5*9/5*tempatmstd(H(i))*density(H(i));
    end
    H_cruise = interp1(var,H,cte);

Wlanding = Wto-Wfuel;

%% CALCUL CHARGE ALAIRE TO
%WS_TO = Wto/S;
WS_TO = 125;
S= Wto/WS_TO;


%% ON DEFINIT b
b = sqrt(A*S);

%% CALCUL CHARGE ALAIRE LD
WS_L = Wlanding/S;

%% ON DETERMINE LA POUSSEE
T = Wto*0.35;% Cours 3, valeurs typiques longues distances

%% RATIO POUSSEE POIDS
T_Wto = T/Wto;



%% AERODYNAMIQUE/PERFORMANCE
% Finesse max
Cd0 = 0.021;
%F_max = finesse(M_cruise,A)
F_max = 1/sqrt(4*1/(pi*A*0.8)*Cd0)
% Distance d'atterissage fix?e 
SL = 4400; % Optimale : 4600 ft, R?aliste : 5900 ft


% Calcul du CLmax,L = CLmax
LP = (SL - 400) / 118;
CLmax = WS_L / LP

% Calcul du CLmax,TO
CLmaxTO = 0.8 * CLmax

% Calcul de la distance de decollage
TOP = WS_TO * (1/CLmaxTO) * (1/T_Wto);
Sto = 20.9*TOP + 87*sqrt(TOP*T_Wto)

% Calcul de la vitesse de decrochage
p = 0.0023769;
Vs = sqrt((2*Wto)/(p*S*CLmax))

% Calcul de la vitesse de decollage
Vto = 1.1*Vs
