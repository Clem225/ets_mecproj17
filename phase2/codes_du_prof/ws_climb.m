function [ws, twmin] = ws_climb(TW, CD0, A, H, dHdt, M)
% charge alaire pour un angle de montee donnee relations tirees
% en partie de Corke, Design  of aircraft, chapitre 3, 2003
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
TW=0.54 %ratio poussee poids
CD0=0.035 %coefficient de trainee a portance nulle de l'avion 
A=2 %allongement
M=0.32 % Mach de montee
H=0 % altitude au debut de la montee, ft
dHdt=900 % taux de montee (ft/min) 
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% ws charge alaire : lbf / ft^2
% twmin ratio poussee poids minimum

% ---------------------------------------------------------------------
% evaluation de l'angle de montee
% ---------------------------------------------------------------------
vcl=vitesse(M,H);
alpha=asin(dHdt/60/vcl);

% ---------------------------------------------------------------------
% densite debut de montee
% ---------------------------------------------------------------------
dc=density(H);

% ---------------------------------------------------------------------
% coefficient k
% ---------------------------------------------------------------------
k= 1/(pi*A*e_oswald(A));

% ---------------------------------------------------------------------
% evaluation du ratio poussee poids minimum pour l'angle de montee
% ---------------------------------------------------------------------
twmin=sin(alpha)+2*cos(alpha)*sqrt(CD0*k);

if (TW < twmin)
    % ---------------------------------------------------------------------
    % poussee insuffisante
    % ---------------------------------------------------------------------
    ws=0;
    sprintf('Poussee insuffisante')
else
    a=TW-sin(alpha);
    denom=2*(cos(alpha))^2*k/(0.5*dc*vcl^2);
    % ---------------------------------------------------------------------
    %on calcul la plus grande charge alaire positive (moins restrictif) 
    % ---------------------------------------------------------------------
    ws=(a+sqrt(a^2-(4*CD0*(cos(alpha))^2*k)))/denom;
end

sprintf('%s %0.1f', 'Charge alaire necessaire montee',ws)
sprintf('%s %0.2f', 'Ratio pouss�e poids necessaire montee',twmin)
