function d = trainee_onde(M, H, S, Dmax, L_tot, Lsection_const, ...
    epais_rel, fleche, cl, scri)
% Evaluation de la trainee d'onde de l'avion, d'apres la methode
% approximative presentee par Raymer,  dans Aircraft Design: A 
% Conceptual Approach, 1999. 
%
% Copyright 2008: Francois Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
M=0.78  % Vitesse de croisiere de l'avion
H=35000 % altitude de croisiere, ft
S=860 % Surface alaire, ft^2
Dmax=12.0 % Diametre maximum du fuselage, ft
L_tot=100.0 % Longueur totale du fuselage, ft
Lsection_const=65.0 % Longueur du fuselage a section constante (Dmax), ft
epais_rel=0.12 % Epaisseur maximum du profil divisee par la corde
fleche=25 % Fleche de l'aile au quart de la corde
cl=0.45 % Coefficient de portance en vol de croisiere
scrit='oui' % Oui si le profil est un profil supercritique
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% d : trainee d'onde en lbf

% ---------------------------------------------------------------------
% evaluation du nombre de Mach de divergence a portance nulle pour profil
% Lecture des donnees de la fig12.28 de Raymer
% colonne 1: t/c, colonne 2: fleche quart de corde, colonne 3: Mdd
% ---------------------------------------------------------------------
mdd_cl0=xlsread('data/fig12-28.xls');

if strcmp(scrit,'oui')
    % facteur de correction d'epaisseur profil supercritique
    epais_rel_eff = 0.6*epais_rel;
else
    epais_rel_eff = epais_rel;
end

% ---------------------------------------------------------------------
% l'epaisseur relative doit etre entre 0.04 et 0.12 pour utliser la
% fig12.28
% ---------------------------------------------------------------------
epais_rel_eff=max(0.04,epais_rel_eff);
epais_rel_eff=min(0.12,epais_rel_eff);

% ---------------------------------------------------------------------
% interpolation dans les donnees de la figure 12.28
% ---------------------------------------------------------------------
mdd_eff_cl0=griddata(mdd_cl0(:,1),mdd_cl0(:,2),mdd_cl0(:,3), ...
    epais_rel_eff, fleche);

% ---------------------------------------------------------------------
% evaluation du facteur LF
% lecture des donnees de la fig12.19 de Raymer
% colonne 1: t/c, colonne 2: Cl, colonne 3: Mdd
% ---------------------------------------------------------------------
lfdd=xlsread('data/fig12-29.xls');

% ---------------------------------------------------------------------
% interpolation dans les donnees de la figure 12.29.  Faire attention aux
% valeurs maximum de Cl.  La fonction griddate ne peut pas extrapoler
% ---------------------------------------------------------------------
lfdd_eff=griddata(lfdd(:,1), lfdd(:,2), lfdd(:,3), epais_rel_eff, cl);

% ---------------------------------------------------------------------
% Nombre de Mach de divergence a portance non-nulle
% ---------------------------------------------------------------------
mdd = mdd_eff_cl0*lfdd_eff - 0.05*cl;

% ---------------------------------------------------------------------
% Estimation du coefficient de trainee d'onde corps de Sears-Haack
% ---------------------------------------------------------------------
Amax=pi*Dmax^2/4;
l=L_tot-Lsection_const;
cd_w_sh=9*pi/(2*S)*(Amax/l)^2;

% ---------------------------------------------------------------------
% Coefficient de trainee d'onde a Mach 1.2
% ---------------------------------------------------------------------
ewd=4;
mach(1)=1.2;
cd_w(1)=ewd*cd_w_sh;

% ---------------------------------------------------------------------
% Coefficient de trainee d'onde a Mach 1.05
% ---------------------------------------------------------------------
mach(2)=1.05;
cd_w(2)=cd_w(1);

% ---------------------------------------------------------------------
% Coefficient de trainee d'onde a Mach 1.0
% ---------------------------------------------------------------------
mach(3)=1.0;
cd_w(3)=cd_w(1)*0.5;

% ---------------------------------------------------------------------
% Coefficient de trainee d'onde a mdd
% ---------------------------------------------------------------------
mach(4)=mdd
cd_w(4)=0.002;

% ---------------------------------------------------------------------
% Coefficient de trainee d'onde au nombre de Mach critique
% ---------------------------------------------------------------------
mach(5)=mdd-0.08;
cd_w(5)=0.0;

% ---------------------------------------------------------------------
%  Interpolation de la valeur de la trainee d'onde.
%  C'est la partie delicate de la procedure.  Il faut s'assurer que le 
%  spline d'interpolation est acceptable en regardant le graphique.  Si il
%  n'est pas acceptable, il faut ajuster la pente de la courbe a M=1.2.
% ---------------------------------------------------------------------
% La pente de -10 a M=1.2 (fin) est fixee arbitrairement.  La valeur de cette
% pente devrait etre negative, mais plus ou moins grande pour garder un
% spline acceptable.
% L'usager pourrait devoir fixer cette valeur.
% ---------------------------------------------------------------------
debut=0;
fin=-40;
% ---------------------------------------------------------------------
% Sortie grpahique pour verification.  Il faut s'assurer que la fonction
% d'interpolation de cd ne baisse pas sous la valeur de 0
% ---------------------------------------------------------------------
xx=mach(5):0.01:1.2;
yy=spline(mach,[debut cd_w fin],xx);
plot(mach,cd_w,'o',xx,yy)

% ---------------------------------------------------------------------
% Coefficient de trainee d'onde au Mach de croisière.  Si le spline est
% acceptable, le coefficient de trainee d'onde est acceptable.
% ---------------------------------------------------------------------
cd_w_cruise=spline(mach,[debut cd_w fin],M)

% ---------------------------------------------------------------------
% vitesse en ft/s
% ---------------------------------------------------------------------
vc= vitesse(M,H);

% ---------------------------------------------------------------------
%densite debut croisiere
% ---------------------------------------------------------------------
dc=density(H);

% ---------------------------------------------------------------------
% trainee d'onde en croisiere
% ---------------------------------------------------------------------
d=cd_w_cruise*(0.5*dc*vc^2*S)








