function [d S_wet] = trainee_fuselage(M, H, S, Dmax, L_tot, ...
    Lsection_const, k)
% evaluation de la surface mouillee et de la trainee du fuselage, 
% methode de Raymer,  dans Aircraft Design: A 
% Conceptual Approach, 1999. 
%
% Copyright 2008: Francois Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
M=2.1  % Vitesse de croisiere de l'avion
H=55000 % Altitude de croisiere, ft
S=519 % Surface alaire, ft^2
Dmax=9 % Diametre maximum du fuselage, ft
L_tot=121 % Longueur totale du fuselage, ft
Lsection_const=43 % Longueur du fuselage a section constante (Dmax), ft
k=2.08e-5 % Rugosité de finition du fuselage, ft
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% S_wet : surface du fuselage ft^2
% d : trainee de friction du fuselage

% ---------------------------------------------------------------------
% calcul de la vitesse en ft/s
% ---------------------------------------------------------------------
vc= vitesse(M,H);

% ---------------------------------------------------------------------
% densite atmosphere debut croisiere
% ---------------------------------------------------------------------
dc=density(H);

% ---------------------------------------------------------------------
% viscosite debut croisiere
% ---------------------------------------------------------------------
mu = viscosity(H);

% ---------------------------------------------------------------------
% Caracteristique geometrique du fuselage: 
% Forme de Sears-Haack pour la section non-constante (cockpit et queue).
% Ce choix peut-etre change en modifiant la fonction fperim.
% La forme de la section circulaire est cylindrique.
% ---------------------------------------------------------------------

% ---------------------------------------------------------------------
% Longueur de la section non-constante
% ---------------------------------------------------------------------
l=L_tot-Lsection_const;
% ---------------------------------------------------------------------
% Determination de la surface avant (cockpit) par integration du perimetre
% ---------------------------------------------------------------------
Savant=quad(@fperim,0,l/2);

% ---------------------------------------------------------------------
% Par symmetrie, arriere (queue) identique
% ---------------------------------------------------------------------
Sarriere=Savant;
% ---------------------------------------------------------------------
% Surface de la section constante : aire d'un cylindre de diametre Dmax
% ---------------------------------------------------------------------
Scentre=pi*Dmax*Lsection_const;

% ---------------------------------------------------------------------
% Surface totale du fuselage
% ---------------------------------------------------------------------
S_wet=Savant+Scentre+Sarriere;


% ---------------------------------------------------------------------
%Evaluation du Reynolds surface lisse
% ---------------------------------------------------------------------
Re = dc * vc * L_tot / mu;

% ---------------------------------------------------------------------
%Evaluation du Reynolds surface rugueuse, equations 12.28 et 12.29 Raymer
% ---------------------------------------------------------------------
if ( M < 0.7 )
    % subsonique
    Re_cutoff = 38.21*(L_tot/k)^1.053;
else
    % transonique
    Re_cutoff = 44.62*(L_tot/k)^1.053*M^1.16;
end

% ---------------------------------------------------------------------
% Garder le plus petit des deux Reynolds
% ---------------------------------------------------------------------
rex = min(Re, Re_cutoff);

% ---------------------------------------------------------------------
% evaluation du coefficient de trainee de friction plaque plane
% ---------------------------------------------------------------------
if (rex <= (5e5)) 
    % laminaire
    cf = 1.328 / sqrt(rex);
else
    % turbulent
    cf = 0.455 / ( (log10(rex))^2.58 * ( 1 + 0.144*M^2)^0.65);
end

% ---------------------------------------------------------------------
% evaluation du facteur de forme du fuselage
% ---------------------------------------------------------------------
f=L_tot/Dmax;
FF=(1+60/f^3+f/400);

% ---------------------------------------------------------------------
% coefficient de trainee du fuselage, rapporte a la surface de l'aile. Le
% facteur d'interference Q est pratiquement toujours de 1 
% ---------------------------------------------------------------------
Q = 1;
cd = cf * FF * Q * S_wet / S; 

% ---------------------------------------------------------------------
% trainee du fuselage en lbf
% ---------------------------------------------------------------------
d = cd * ( 0.5 * dc * vc^2 * S );


function p=fperim(x)
    % ---------------------------------------------------------------------
    % Perimetre forme de Sears-Haack.  Cette fonction etant incluse dans
    % trainee_fuselage, elle peut utiliser les variables de
    % trainee_fuselage (variables globales)
    % ---------------------------------------------------------------------
    r = Dmax/2*(1-(x/(l/2)).^2).^0.75;
    p= 2* pi * r;
end

end