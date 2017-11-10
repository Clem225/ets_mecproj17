function ws = ws_landing(H_landing, CL, Sl);
% evaluation de la charge alaire necessaire a l'atterrissage
% d'apres Corke, Design  of aircraft, chapitre 3, 2003
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
H_landing=0; %altitude d'atterrissage en ft
CL=5.56; % coefficient de portance de l'aile atterrissage
Sl=1350; % distance d'atterrissage en ft
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% ws charge alaire atterissage: lbf / ft^2

% ---------------------------------------------------------------------
%sigma=densite atterrissage/densite SL
% ---------------------------------------------------------------------
sigma = density(H_landing)/density(0);

% ---------------------------------------------------------------------
% evaluation de LP en lbf/ft^2
% ---------------------------------------------------------------------
f = @(x) Sl - 118*x - 400 ;
LP=fzero(f,[ 0 1e6 ]);

% ---------------------------------------------------------------------
% evaluation de la charge alaire lbf/ft^2
% ---------------------------------------------------------------------
f = @(x) LP - x*1/(CL*sigma);
ws = fzero(f, [ 0 1e3 ]);

sprintf('%s %0.1f', 'Charge alaire n�cessaire atterrissage',ws)
