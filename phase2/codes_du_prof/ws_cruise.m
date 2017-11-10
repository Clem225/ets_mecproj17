function [ws] = ws_cruise(CD0, A, H, M, type)
% evaluation de la charge alaire optimale altitude H, 
% en partie de Corke, Design  of aircraft, chapitre 3, 2003
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
CD0=0.030 % coefficient de trainee a portance nulle de l'avion 
A=7.8 % allongement
M=0.8 % Mach de croisiere
H=41000 % altitude de croisiere ft
type='jet' % avion a helice (prop) ou a reaction (jet)
% ---------------------------------------------------------------------
% Cette valeur est retournee par la fonction
% ---------------------------------------------------------------------
% ws charge alaire : lbf / ft^2

% ---------------------------------------------------------------------
% conversion de la vitesse en ft/s
% ---------------------------------------------------------------------
vc= vitesse(M,H);

% ---------------------------------------------------------------------
% densite altitude H
% ---------------------------------------------------------------------
dc=density(H);

% ---------------------------------------------------------------------
% coefficient k
% ---------------------------------------------------------------------
k= 1/(pi*A*e_oswald(A));

% ---------------------------------------------------------------------
%la charge alaire optimale depend du type d'avion : soit a reaction, soit a
%helice, car un prop doit voler a L/D maximum pour maximiser la
%distance, et un jet doit maximiser L^0.5/D pour maximiser la distance
% ---------------------------------------------------------------------
switch lower(type)
    case {'prop'}
        ws = dc*vc^2*0.5*sqrt(CD0/k);
    case {'jet'}
        ws = dc*vc^2*0.5*sqrt(CD0/3/k);
end

sprintf('%s %0.1f', 'Charge alaire necessaire croisiere',ws)

