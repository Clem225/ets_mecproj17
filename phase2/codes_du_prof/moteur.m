function [ Wm Lm Dm T ] = moteur( H, M, Daile, Dfuse, Dvert, Dhor, ...
    Donde, Wref, Lref, Dref, Tref, nm )
% Evaluation de la taille du moteur necessaire pour performances de
% croisiere a l'aide de relations tirees, 
% en partie de Corke, Design  of aircraft, chapitre 7, 2003
%
% Turbo reacteur
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
H = 55000 % Altitude de croisiere, ft
M=2.1 % Vitesse de croisiere
Daile=2705 %Trainee de l'aile, lbf
Dfuse=7739 %Trainee du fuselage, lbf
Dvert=140.8 %Trainee de l'empennage vertical, lbf
Dhor=163.8 % Trainee de l'empennage horizontal, lbf
Donde=0 % Trainee d'onde (transsonique), lbf
Wref=2240 % Poids du moteur de reference, lbf
Lref=158.8 % Longueur du moteur de reference, pouces
Dref=34.8 % Diametre du moteur de reference, pouces
Tref=11000 % Poussee du moteur de reference, lbf
nm = 4 % Nombre de moteur
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% Wm : poids du moteur installe en lbf
% Lm : longueur du moteur installe en pouces
% Dm : diametre du moteur installe en pouces
% T : poussee du moteur installe en lbf au niveau de la mer

% ---------------------------------------------------------------------
% Evaluation de la poussee requise par moteur a l'altitude de croisiere
% En subsonique et transsonique, il n'y a pas de correction de la poussee 
% causee par l'installation (Mach correction factor ou Ram factor)
% ---------------------------------------------------------------------
Treq = (Daile + Dfuse + Dvert + Dhor + Donde) / nm ;

% ---------------------------------------------------------------------
% Poussee du moteur de reference a altitude de croisiere et 80% puissance
% On n'eglige la variation de la poussee avec la vitesse.
% On assume une variation lineaire de la poussee avec la densitee.
% ---------------------------------------------------------------------
Tref_H = Tref * ( density(H) / density(0) ) * 0.8 ;

% ---------------------------------------------------------------------
% Impression du facteur d'echelle qui devrait etre en 0.5 et 1.5.  Si ce
% n'est pas le cas, choisir un autre moteur de reference
% ---------------------------------------------------------------------
sprintf('%s %0.3f', 'Facteur d echelle',Treq / Tref_H);

% ---------------------------------------------------------------------
%  Mise a l'echelle du moteur de reference avec relations de Corke: 7.8,
%  7.9 et 7.10
% ---------------------------------------------------------------------
Dm = Dref * ( Treq / Tref_H )^.5;
Wm = Wref * ( Treq / Tref_H );
Lm = Lref * ( Treq / Tref_H )^.5;

% ---------------------------------------------------------------------
%  Pour prendre en compte l'effet du retrait de l'air pour climatiser la
%  cabine, il faut connaitre le debit d'air dans le moteur de reference et
%  appliquer equation 7.7. Puisque le debit d'air est rarement connu, les 
%  pertes  calculees par l'equation 7.19 sont negligees.  Elles pourraient
%  facilement etre ajoutees
% ---------------------------------------------------------------------

% ---------------------------------------------------------------------
% Poussee au niveau de la mer
% ---------------------------------------------------------------------
T = Tref * (Treq / Tref_H);


