function [d S_vert] = trainee_emp_vert(M, H, S, A, eff, c_vt, l_vt, ...
    fleche_vt, epais_rel, x_epais_max, eff_vt, A_vt, Q)
% evaluation de la trainee de l'empennage vertical de l'avion
% a l'aide de relations tirees, 
% en partie de Corke, Design  of aircraft, chapitre 5, 2003
%
% Copyright 2008: Francois Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
M=2.1  % Vitesse de croisiere de l'avion
H=55000 % altitude de croisiere ft
S = 519 % Surface alaire ft^2
A = 2 % Allongemnt de l'aile
eff = 0 % effilement de l'aile
c_vt=0.07 % coefficient de l'empennage vertical
l_vt=40 % longueur du bras de levier empennage vertical arriere
fleche_vt=63 % Angle de fleche bord d'attaque de l'empennage vertical
epais_rel=0.04 % Epaisseur maximum du profil de l'empennage vertical 
% divisee par la corde
x_epais_max=0.35 % Ratio x/c de la position de l'epaisseur relative maximum 
% du profil de l'empennage vertical
eff_vt = 0.30 %Effilement de l'empennage vertical
A_vt = 1.1 %Allongement de l'empennage vertical
Q = 1.05 %Facteur d'interference de l'empennage vertical
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% d: trainee totale de l'empennage vertical, lbf
% S_vert : surface de l'empennage vertical, ft^2

% ---------------------------------------------------------------------
% evaluation de l'envergure de l'aile principale
% ---------------------------------------------------------------------
b= sqrt(S*A);

% ---------------------------------------------------------------------
% evaluation de la taille de la surface de l'empennage vertical a partir de
% valeurs historiques pour le coefficient de volume de l'empennage vertical
% ---------------------------------------------------------------------
S_vt=c_vt*b*S/l_vt;

% ---------------------------------------------------------------------
% Cette surface est pour la moitie d'une aile (empennage non symetrique)
% pour utiliser la relation de la trainee d'une aile il faut multiplier la
% surface par deux.  Par la suite la trainee calculee sera divisee par
% par deux pour garder une moitie de l'aile
% ---------------------------------------------------------------------
S_calcul=2*S_vt;

% ---------------------------------------------------------------------
% evaluation de la trainee : meme que pour l'aile sauf que portance nulle
%(W=0) : trainee lb force 
% !!!!!!!!!!!!!!!!!divisee par deux, évidemment!!!!!!!!!!!!!!!!!!!!!!!
% ---------------------------------------------------------------------
d = trainee_aile(M, H, fleche_vt, S_calcul, A_vt, epais_rel, ...
    x_epais_max, eff_vt, Q, 0)./2;

% ---------------------------------------------------------------------
% coefficient de trainee de l'empennage verticale pour comparaison avec
% celui de l'aile
% ---------------------------------------------------------------------
cd = d / (0.5*density(H)*vitesse(M,H)^2*S)


