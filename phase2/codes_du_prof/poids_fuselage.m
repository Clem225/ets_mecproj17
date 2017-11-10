function W=poids_fuselage(A, S, eff, fleche, n, L, Lt, Klg, Kdoor, ...
    Kdwf, Sf, Depth, Width, Vpr, Wdg, M, H)
%evaluation du poids du fuselage
%A = 10 %Allongement de l'aile
%S = 519 %Surface alaire de l'aile
%eff = 0 %Effilement de l'aile
%fleche=62 %Angle de fleche bord d'attaque degree
%n = 2.5 %Facteur de charge de design
%L=72 %Longueur du fuselage en ft
%Lt= 50 % longueur du bras de levier empennage arriere ft
%Klg = 1.12 % 1.12 pour un train d'atterrissage sur le fuselage, 1 autrement
%Kdoor = 1.06 
% 1 pas de porte cargo; 1.06 porte un cote; 1.12 deux portes ou porte
% "clamshell"; 1.125 deux portes et une porte "clamshell"
%Kdwf=1 % 0.774 pour une aile delta, 1.0 autrement
%Sf=2284 % Surface mouillee du fuselage ft^2
%Depth= 9 % Profondeur du fuselage ft
%Width= 9 % Largeur du fuselage ft
%Vpr=100 %Volume pressurise du fuselage ft^3
%Wdg=8800 % Poids de conception
%M=2.1  %Vitesse de croisiere de l'avion
%H=55000 %altitude de croisiere (debut) ft
%w poids en lbf

%corde racine et envergure
b= sqrt(S*A);
cr= 2*b /(A * (1+eff));

%evaluation de la fleche au quart de corde
fleche_m = atand(tand(fleche)-0.25*2*cr/b*(1-eff));

%vitesse en ft/s
vc= vitesse(M,H);

%densite debut croisiere
dc=density(H);

%pression dynamique
q=0.5*dc*vc^2;

%evaluation de facteur
Kws= 0.75*((1+2*eff)/(1+eff))*((b/L)*tand(fleche_m));
dP = 8; %difference de pression dans volume pressurise lb/ft^2
Wp=11.9+(Vpr*dP)^0.271;

%Coefficient pour avion de transport
c = [ 0.328 Kdoor Klg 0.50 0.50 0.35 0 -0.100 0.302 0 0.04 0 0 ];

%Poids
W = c(1)*c(2)*c(3)*Wdg^c(4)*n^c(5)*L^c(6)*Lt^c(7)*Depth^c(8)*Sf^c(9)...
    *Width^c(10)*(1+Kws)^c(11)*q^c(12)+c(13);

