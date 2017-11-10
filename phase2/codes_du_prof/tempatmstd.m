function T = tempatmstd(H)
% Temperature atmosphere standart
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Valeurs d'entree de la fonction
% ---------------------------------------------------------------------
% H : altitude en ft
% ---------------------------------------------------------------------
% Valeur retournee par la fonction
% ---------------------------------------------------------------------
% T : temperature en K 

% ---------------------------------------------------------------------
%evaluation de l'altitude en m
% ---------------------------------------------------------------------
hm = H*0.3048;

% ---------------------------------------------------------------------
% Variation lineaire de la temperature dans la troposphere, constante dans
% la stratosphere
% ---------------------------------------------------------------------

if ( hm < 11e3 )
    T = 288.16 - 6.5e-3*hm;
else
    T = 216.66;
end
