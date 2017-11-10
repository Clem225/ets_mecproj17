function W=poids_emp_vert(A, Hht, Lt, n, S, Sr, epais, Wdg, fleche, eff, M, H)
%evaluation du poids de l'empennage horizontale par la methode detaillee
%A = 10 %Allongement de l'empennage
%Hht = 0 %Hauteur du stabilisteur horizontal
%Lt = 50 % longueur du bras de levier empennage horizontal arriere ft
%n = 2.5 %Facteur de charge de design
%S = 519 %Surface alaire de l'empennage ft^2
%Sr = 20 % Surface du rudder ft^2
%epais=0.04 % Epaisseur maximum du profil divisee par la corde
%Wdg= 88817 % Poids de design del'avion lbf
%fleche=62 %Angle de fleche bord d'attaque degree empennage
%eff = 0 %Effilement empennage
%M=2.1  %Vitesse de croisiere de l'avion
%H=55000 %altitude de croisiere (debut) ft
%W poids en lbf

%corde racine et envergure
%Attention, l'empennage vertical n'est pas symmetrique, il faut donc
%multiplier S par deux avant d'utiliser les relations, ce qui va nous
%donner une envergure 2 fois trop grande que l'on divisera par 2 a la fin
b= sqrt(2*S*A);
cr= 2*b /(A * (1+eff));

%evaluation de la fleche au maximum d'epaisseur
fleche_m = atand(tand(fleche)-0.25*2*cr/b*(1-eff));
b = b / 2;


%vitesse en ft/s
vc= vitesse(M,H);

%densite debut croisiere
dc=density(H);

%pression dynamique
q=0.5*dc*vc^2;

%rayon de giration
Kz=Lt;

%facteur pour empennage entierement mobile Krht=1.047
Krht=1;

%Coefficient pour avion de transport
c = [ 0.0026 1 0.225 0.556 0.536 0.500 0 -0.5 0 0.350 0 0 -1 -0.5 0.875 0 ];

%Poids
W= c(1)*Krht*(1+c(2)*Hht/b)^c(3)*Wdg^c(4)*n^c(5)*S^c(6)*M^c(7)*Lt^c(8)*...
    (1+Sr/S)^c(9)*A^c(10)*(c(11)+eff)^c(12)*(cosd(fleche_m))^c(13)*...
    epais^c(14)*Kz^c(15)*q^c(16);
