function [d S_ht] = trainee_emp_horiz(M, H, S, A, eff, c_ht, l_ht,...
    fleche_ht, epais_rel, x_epais_max, eff_ht, A_ht, Q)
% evaluation de la trainee de l'empennage horizontal de l'avion
% Relation tirees en partie de Corke, Design  of aircraft, chapitre 5, 2003
%
% Copyright 2008: Francois Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
M=0.498  % Vitesse de croisiere de l'avion
H=25000 % altitude de croisiere ft
S = 1094.4 % Surface alaire ft^2
A = 7.401 % allongemnt de l'aile
eff = 1 % effilement de l'aile
c_ht=0.855 % coefficient de l'empennage horizontal
l_ht=45.17 % longueur du bras de levier empennage horizontal arriere
fleche_ht=22 %Angle de fleche bord d'attaque de l'empennage horizontal
epais_rel=0.119 % Epaisseur maximum du profil de l'empennage horizontal
% divisee par la corde
x_epais_max=1.086 % Ratio x/c de la position de l'epaisseur relative maximum 
% du profil de l'empennage horizontal
eff_ht = 0.6 %Effilement de l'empennage horizontal
A_ht =3 %Allongement de l'empennage horizontal
Q = 1.0 %Facteur d'interference de l'empennage horizontal
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% d: trainee totale de l'empennage horizontal, lbf
% S_horiz : surface de l'empennage horizontal, ft^2

% ---------------------------------------------------------------------
% evaluation de l'envergure, de la corde a la racine et de la corde 
% moyenne de l'aile principale
% ---------------------------------------------------------------------
b= sqrt(S*A);
cr= 2*b /(A * (1+eff));
cm= (2*cr*(1+ eff + eff^2))/(3*(1+eff));

% ---------------------------------------------------------------------
% evaluation de la taille de la surface de l'empennage horizontal
% a partir du coefficient de volume c_ht defini par les valeurs historiques
% ---------------------------------------------------------------------
S_ht=c_ht*cm*S/l_ht;

% ---------------------------------------------------------------------
%evaluation de la trainee : meme que pour l'aile sauf que portance nulle
%(W=0 donc CL=0), en lb force
% ---------------------------------------------------------------------
d = trainee_aile(M, H, fleche_ht, S_ht, A_ht, epais_rel, x_epais_max, ...
    eff_ht, Q, 0);

% ---------------------------------------------------------------------
% coefficient de trainee de l'empannage horizontale pour comparaison avec
% l'aile
% ---------------------------------------------------------------------
cd = d / (0.5*density(H)*vitesse(M,H)^2*S)


