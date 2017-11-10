function pente = cl_alpha_3d(M, S, A, eff, fleche, cla)
%Evaluation de la variation de la portance avec l'angle d'attaque en 3D
% a l'aide de relations 
% d'apres Anderson, Aircraft performance and design, 1999
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
% M : Vitesse de l'avion Mach
% S : Surface alaire ft^2
% A : Allongement de l'aile
% eff : effilement de l'aile
% fleche : fleche de l'aile bord d'attaque de l'aile
% cla : pente du profil en 1/deg
% ---------------------------------------------------------------------
% Cette valeur est retournee par la fonction
% ---------------------------------------------------------------------
% pente de la portance de l'aile en 1/deg

% ---------------------------------------------------------------------
% envergure et corde racine de l'aile
% ---------------------------------------------------------------------
b= sqrt(S*A);
cr= 2*b /(A * (1+eff));

% ---------------------------------------------------------------------
% fleche au milieu de la corde
% ---------------------------------------------------------------------
f = atand(tand(fleche)-1/2*2*cr/b*(1-eff));

% ---------------------------------------------------------------------
% evaluation de la pente de la portande en 3d relation d'Anderson pour une
% aile en fleche equivalente a celle de Raymer, Cla doit-etre en 1/rad
% ---------------------------------------------------------------------
claf = cla*180/pi*cosd(f);
pente =  claf / (sqrt(1-(M*cosd(f))^2+(claf/(pi*A))^2) + (claf)/(pi*A));
pente = pente * pi / 180;
