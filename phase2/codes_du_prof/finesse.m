function x = finesse(M,A)
% estimation de la finesse maximum a l'aide d'une relation tiree, 
% de Corke, Design  of aircraft, chapitre 1, 2003
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Valeurs d'entree de la fonction
% ---------------------------------------------------------------------
% M : nombre de Mach
% A : allongement
% ---------------------------------------------------------------------
% Valeur retournee par la fonction
% ---------------------------------------------------------------------
% x : finesse maximum (ratio L/D max)

if (M < 1 )
    x=A+10;
else
    x= 11*M^-0.5;
end
%x=19.9;
end