function [d d0] = trainee_aile(M, H, fleche_le, S, A, epais_rel, ...
    x_epais_max, eff, Q, Wc)
% evaluation de la trainee d'une aile d'avion a l'aide de relations tirees, 
% en partie de Corke, Design  of aircraft, chapitre 4, 2003
%
% Copyright 2008: Francois Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
M=0.8  % Vitesse de croisiere de l'avion
H=41000 % altitude de croisiere, ft
fleche_le=25 % Angle de fleche bord d'attaque, degree
S = 1200 % Surface alaire, ft^2
A = 9 % Allongement de l'aile
epais_rel=0.12 % Epaisseur maximum du profil divisee par la corde
x_epais_max=0.4 % Ratio x/c de la position de l'epaisseur relative maximum
eff = 1 % Effilement de l'aile
Q = 1 % Facteur d'interference de l'aile
Wc = 130000 % Poids en croisiere, lbf
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% dw: trainee totale de l'aile, lbf
% dw0 : trainee a portance nulle de l'aile, lbf

% ---------------------------------------------------------------------
% vitesse en ft/s
% ---------------------------------------------------------------------
vc= vitesse(M,H);

% ---------------------------------------------------------------------
%densite altitude de croisiere
% ---------------------------------------------------------------------
dc=density(H);

% ---------------------------------------------------------------------
%viscosite altitude de croisiere
% ---------------------------------------------------------------------
mu = viscosity(H);

% ---------------------------------------------------------------------
% envergure, corde a la racine et corde moyenne de l'aile
% ---------------------------------------------------------------------
b= sqrt(S*A);
cr= 2*b /(A * (1+eff));
cm= (2*cr*(1+ eff + eff^2))/(3*(1+eff));

% ---------------------------------------------------------------------
% fleche au milieu de la corde
% ---------------------------------------------------------------------
fleche = atand(tand(fleche_le)-1/2*2*cr/b*(1-eff));

% ---------------------------------------------------------------------
% fleche au maximum d'epaisseur
% ---------------------------------------------------------------------
fleche_m = atand(tand(fleche_le)-x_epais_max*2*cr/b*(1-eff));

% ---------------------------------------------------------------------
% Nombre de Reynolds
% Corke suggere,  rex = dc * vc * cosd(fleche_le)* cm / mu  
% contrairement a Raymer et Anderson!
% Nous choisissons Anderson, Aircraft performance and design, 1999
% ---------------------------------------------------------------------
rex = dc * vc * cm / mu;

% ---------------------------------------------------------------------
% Nombre de Mach effectif, 
% d'apres Anderson, Aircraft performance and design, 1999,
% fleche au milieu de la corde meilleur choix pour le calcul de Mach
% effectif
% ---------------------------------------------------------------------
M_eff = M * cosd(fleche);

% --------------------------------------------------------------------- 
% evaluation du coefficient de trainee de friction plaque plane
% ---------------------------------------------------------------------
if (rex <= (5e5)) 
    % laminaire
    cf = 1.328 / sqrt(rex);
else
    % turbulent, surface lisse
    cf = 0.455 / ( (log10(rex))^2.58 * ( 1 + 0.144*M_eff^2)^0.65);
end

% ---------------------------------------------------------------------
% evaluation du facteur de forme.  Ici, on utilise la fleche au maximum
% d'epaisseur telle que suggeree par Raymer dans Aircraft Design: A 
% Conceptual Approach, 1999. 
% ---------------------------------------------------------------------
FF=(1+0.6/x_epais_max*epais_rel+100*(epais_rel)^4)*...
    (1.34*M^0.18*(cosd(fleche_m))^0.28);
     
% ---------------------------------------------------------------------
% surface mouillee de l'aile
% ---------------------------------------------------------------------
if (epais_rel <= 0.05)
    S_wet = 2.003 * S;
else
    S_wet = S * (1.977 + 0.52*epais_rel);
end

% ---------------------------------------------------------------------
%coefficient de trainee de l'aile a portance nulle
% ---------------------------------------------------------------------
cd0 = cf * FF * Q * S_wet / S;

% ---------------------------------------------------------------------
% coefficient k
% ---------------------------------------------------------------------
k= 1/(pi*A*e_oswald(A));

% ---------------------------------------------------------------------
% coefficient de portance CL
% ---------------------------------------------------------------------
CL = Wc / (0.5 * dc * vc^2 * S );

% ---------------------------------------------------------------------
% coefficient de trainee de l'aile avec trainee induite
% ---------------------------------------------------------------------
cd = cd0 + k * CL^2;

% ---------------------------------------------------------------------
%trainee de l'aile a portance nulle et totale
% ---------------------------------------------------------------------
d0 = cd0 * (0.5 * dc * vc^2 * S)
d = cd * (0.5 * dc * vc^2 * S)
