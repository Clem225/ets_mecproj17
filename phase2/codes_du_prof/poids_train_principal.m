function W=poids_train_principal(Lm, n, Nmw, Nmss, CLmax, S, Wl, H)
%evaluation du poids du train d'atterrissage principal
%Lm=12 %longueur du train d'atterrissage en in
%n= 2.5 %Facteur de charge de design
%Nmw = 8 % Nombre de roues du train principal
%Nmss = 2 % Nombre d'amortisseurs
%CLmax = 1.6 % Coefficient de portance maximum
%S=519 % Surface alaire en ft^2
%Wl = 5000 % Poids a l'atterrisage en lb

%densite a l'altitude d'atterrissage de design
dc=density(H);

%vitesse de decrochage a l'atterrissage
Vs = sqrt(Wl/(0.5*dc*CLmax*S));

%Divers facteurs pas trop critiques, donc fixe par defaut
Kcb = 1.0 ;%Kcb=2.25 pour cross-beam gear, 1 autrement
Kmp = 1.0 ;%Kmp=1.126 pour kneeling gear (qui s'abaisse), 1 autrement
Ktpg= 1.0 ;%Ktpg=0.826 pour tripod gear

%coefficients
c = [ 0.0106 1 Kmp 0.888 0.25 0.400 0.321 -0.5 0.1 ];

%Poids
W=c(1)*c(2)*c(3)*Wl^c(4)*n^c(5)*Lm^c(6)*Nmw^c(7)*Nmss^c(8)*Vs^c(9);




