function W=poids_emp_hor(A, F, Lt, n, S, epais, Wdg, fleche, eff, M, H)
%evaluation du poids de l'empennage horizontale par la methode detaillee
%A = 10 %Allongement de l'empennage
%F = 4 %Largeur du fuselage en ft au niveau de l'empennage
%Lt = 50 % longueur du bras de levier empennage horizontal arriere ft
%n = 2.5 %Facteur de charge de design
%S = 519 %Surface alaire de l'empennage ft^2
%epais=0.04 % Epaisseur maximum du profil divisee par la corde
%Wdg= 88817 % Poids de design del'avion lbf
%fleche=62 %Angle de fleche bord d'attaque degree empennage
%eff = 0 %Effilement empennage
%M=2.1  %Vitesse de croisiere de l'avion
%H=55000 %altitude de croisiere (debut) ft
%w poids en lbf

%corde racine et envergure
b= sqrt(S*A);
cr= 2*b /(A * (1+eff));

%evaluation de la fleche au maximum d'epaisseur
fleche_m = atand(tand(fleche)-0.25*2*cr/b*(1-eff));

%vitesse en ft/s
vc= vitesse(M,H);

%densite debut croisiere
dc=density(H);

%pression dynamique
q=0.5*dc*vc^2;

%rayon de giration
Ky=0.3*Lt;

%Coefficient pour avion de transport
c = [ 0.0379 -0.25 0.639 0.10 0.750 -1 0.704 -1 0.116 0 0 0 ];

%Poids
W = c(1)*(1+F/b)^c(2)*Wdg^c(3)*n^c(4)*S^c(5)*Lt^c(6)*Ky^c(7)*...
    (cosd(fleche_m))^c(8)*A^c(9)*epais^c(10)*eff^c(11)*q^c(12);
