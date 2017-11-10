
function W = poids_aile(A, Kdw, Kvs, n, M, H, Sw, Sf, epais, Wdg, Wfw, fleche_le, eff, type)
%evaluation du poids de l'aile par la methode detaillee
%A = 10 %Allongement de l'aile
%Kdw = 1 %Coefficient 0.768 aile delta, 1 autre
%Kvs = 1. %Coefficient 1.19 fleche variable 1 autre
%n = 2.5 %Facteur de charge de design
%M=2.1  %Vitesse de croisiere de l'avion
%H=55000 %altitude de croisiere (debut) ft
%Sw = 519 %Surface alaire ft^2
%Sf = 200 %Surface de la partie avec volet de l'aile ft^2
%epais=0.04 % Epaisseur maximum du profil divis�e par la corde
%Wdg= 88817 % Poids de design del'avion lbf
%Wfw=10000 %Poids d'essence dans l'aile lbf
%fleche_le=62 %Angle de fleche bord d'attaque degree
%eff = 0 %Effilement de l'aile
%type = 'transport' % Sorte d'avion : chasse, transport, generale

%corde moyenne et envergure
b= sqrt(Sw*A);
cr= 2*b /(A * (1+eff));

%evaluation de la fleche au maximum d'epaisseur
fleche_m = atand(tand(fleche_le)-0.25*2*cr/b*(1-eff));

%vitesse en ft/s
vc= vitesse(M,H);

%densit� debut croisiere
dc=density(H);

%pression dynamique
q=0.5*dc*vc^2;

switch lower(type)
    case('chasse')
        %Coefficient pour avion de chasse
        c = [ 0.0103 Kdw Kvs 0.50 0.50 0.622 0.785 -0.4 1.0 0.050 -1.0 0.04 0 0 ];
    case('transport')
        %Coefficient pour avion de transport
        c=[ 0.0051 1 1 0.557 0.577 0.649 0.5 -0.4 1.0 0.100 -1.0 0.10 0 0 ];
    case('generale')
        %Coefficient pour aviation générale
        c= [ 0.0090 1 1 0.490 0.490 0.758 0.6 -0.3 0 0.004 -0.9 0 0.006 0.0035 ];
end

W = c(1)*c(2)*c(3)*Wdg^c(4)*n^c(5)*Sw^c(6)*A^c(7)*epais^c(8)*...
    (c(9)+eff)^c(10)*(cosd(fleche_m))^c(11)*Sf^c(12)*Wfw^c(13);




