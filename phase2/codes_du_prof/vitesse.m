function vc = vitesse(M,H);
% Vitesse de croisiere
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Valeurs d'entree de la fonction
% ---------------------------------------------------------------------
% M : nombre de Mach
% H : altitude en ft
% ---------------------------------------------------------------------
% Valeur retournee par la fonction
% ---------------------------------------------------------------------
% vitesse de croisiere en ft/s

%temperature altitude
T=tempatmstd(H);

%vitesse du son
vson=sqrt(1.4*287*T);

%vitesse de vol en ft/s
vc = M*vson*3.2808;

end