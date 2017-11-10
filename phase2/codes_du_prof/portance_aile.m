function [ CLa a_trim CL_max a_dec ] = portance_aile(M, H, fleche_le, ...
    S, A, epais_rel, x_epais_max, eff, Wc, Cla, a0, Clmax, dy)
% Evaluation de l'angle d'attaque de l'aile en croisiere, de la variation
% du coefficient de portance avec l'angle d'attaque, de la portance maximale
% et de l'angle de decrochage a l'aide de relations tirees, 
% en partie de Corke, Design  of aircraft, chapitre 1, 2003
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
M=0.8  % Vitesse de croisiere de l'avion
H=59000 % altitude de croisiere, ft
fleche_le=20 %Angle de fleche bord d'attaque degr�e
S = 519 % Surface alaire ft^2
A = 7 % Allongement de l'aile
epais_rel=0.04 % Epaisseur maximum du profil divisee par la corde
x_epais_max=0.4 % Ratio x/c de la position de l'epaisseur relative maximum
eff = 1.0 % Effilement de l'aile
Wc = 88817 % Poids de l'avion en croisiere, lbf
Cla = 0.1097 % Pente de la variation de la portance pour un profil en 1/deg
a0 =  -1.5 % Angle d'attaque 0 portance du profil (en deg)
Clmax = 1.5 % Portance maximale du profil
dy = 0.7 % Facteur d'angle du profil
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% CLa Pente de la variation de la portance pour une aile 1/deg
% a_trim Angle d'attaque necessaire pour generer la portance en degree
% CL_max Portance maximale de l'aile
% a_dec Angle de decrochage de l'aile en degree

% ---------------------------------------------------------------------
% vitesse en ft/s
% ---------------------------------------------------------------------
vc= vitesse(M,H);

% ---------------------------------------------------------------------
% densite debut croisiere
% ---------------------------------------------------------------------
dc=density(H);

% ---------------------------------------------------------------------
% envergure, corde a la racine et corde moyenne de l'aile
% ---------------------------------------------------------------------
b= sqrt(S*A);
cr= 2*b /(A * (1+eff));
cm= (2*cr*(1+ eff + eff^2))/(3*(1+eff));


% ---------------------------------------------------------------------
% fleche au quart de corde
% ---------------------------------------------------------------------
fleche_q = atand(tand(fleche_le)-1/4*2*cr/b*(1-eff));

% ---------------------------------------------------------------------
%evaluation de la pente de la portande en 3d 
% ---------------------------------------------------------------------
CLa = cl_alpha_3d(M, S, A, eff, fleche_le, Cla);


% ---------------------------------------------------------------------
% evalutaion de l'angle d'attaque en croisiere
% CLcruise = CLa * (a_trim - a0 )
% ---------------------------------------------------------------------
CLcruise = Wc / ( 0.5*dc*vc^2*S )
a_trim = (CLcruise + CLa*a0) / CLa

% ---------------------------------------------------------------------
% evaluation de la portance maximum
% en premiere approximation, d'apres 12.15 de Raymer dans Aircraft Design: A 
% Conceptual Approach, 1999. Noter ici que cette relation est definie pour
% le quart de la corde de l'aile!
% ---------------------------------------------------------------------
CL_max = 0.9 * Clmax * cosd(fleche_q)

% ---------------------------------------------------------------------
% evaluation de l'angle de decrochage avec fig12-10 Raymer, aile de grand
% allongement.  Augmentation de l'angle de de decrochage causee par la
% courbure de la courbe de CL.
% ---------------------------------------------------------------------
dalp = xlsread('data/fig12-10.xls');

% ---------------------------------------------------------------------
% l'angle du bord d'attaque doit-etre entre 1.2 et 4 pour utliser la figure
% ---------------------------------------------------------------------
dy = max(1.2, dy);
dy = min(4, dy);
dalp_dec = griddata(dalp(:,1), dalp(:,2), dalp(:,3), dy, fleche_le)

% ---------------------------------------------------------------------
% angle de decrochage de l'aile
% ---------------------------------------------------------------------
a_dec = CL_max / CLa + a0 + dalp_dec



