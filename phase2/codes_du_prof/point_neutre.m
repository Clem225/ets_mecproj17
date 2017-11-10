function [xn] = point_neutre(M,S, A, eff, fleche, Sht, Aht, effht, ...
    flecheht, Lht,deda, Claw, Claht, tail_efficiency)
%Calcul du point neutre de l'avion, par rapport bord d'attaque de la corde
%moyenne.
M=0.9  %Vitesse de croisiere de l'avion
S = 831 %Surface alaire ft^2
A = 2 %Allongement de l'aile
eff = 0.0 %Effilement de l'aile
fleche=62 %Angle de fleche bord d'attaque degree
Sht = 74 %Surface alaire de l'empennage horizontal ft^2
Aht = 2 % Allongement de l'empennage
effht = 0.35 % Effilement de l'empennage
flecheht = 63 % Angle de fleche LE de l'empennage
Lht = 45.01 % Distance entre quart de la corde emp. hor. et aile
deda = 0. % Downwash effect
Claw = 0.1097 % Pente de la variation de la portance pour profil aile en 1/deg
Claht = 0.1097 % Pente de la variation de la portance pour profil empennage en 1/deg
tail_efficiency = 1.0 % Ratio de l'energie cinetique vue par l'emp. sur celle de l'aile
%xn point neutre divise par la corde moyenne de l'aile

%Les centres aerodynamiques du profil de l'aile et de l'empennage sont au quart
%de leur corde respective.
xac = 0.25;
xac_ht = xac + Lht;

%Pente de la portance de l'aile
CLa_w = CL_alpha_3d(M, S, A, eff, fleche, Claw)

%Pente de la portance de l'empennage horizontal arriere
CLa_ht = CL_alpha_3d(M, Sht, Aht, effht, flecheht, Claht)

%Corde moyenne
b= sqrt(S*A);
cr= 2*b /(A * (1+eff));
cm= (2*cr*(1+ eff + eff^2))/(3*(1+eff));

%Position point neutre divise par la corde moyenne.  Logiquement, devrait
%etre derriere xac
num = xac + xac_ht*Sht/(S*cm)*CLa_ht/CLa_w*(1-deda)*tail_efficiency;
den = 1 + Sht/S*CLa_ht/CLa_w*(1-deda)*tail_efficiency;
xn = num / den;




