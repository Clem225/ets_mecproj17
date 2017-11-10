function W=poids_train_avant(Ln, n, Nnw, Wl)
%evaluation du poids du train d'atterrissage avant
%Ln=12 %longueur du train d'atterrissage en in
%n= 2.5 %Facteur de charge de design
%Nnw = 8 % Nombre de roues du train avant
%CLmax = 1.6 % Coefficient de portance maximum
%S=519 % Surface alaire en ft^2
%Wl = 5000 % Poids a l'atterrisage en lbf
%W poids du train d'atterrissage avant

%Divers facteurs pas trop critiques
Knp = 1.0; %Kmp=1.15 pour kneeling gear (qui s'abaisse), 1 autrement

%coefficients
c = [ 0.032 Knp 0.646 0.200 0.500 0.450 ];

%Poids
W=c(1)*c(2)*Wl^c(3)*n^c(4)*Ln^c(5)*Nnw^c(6);