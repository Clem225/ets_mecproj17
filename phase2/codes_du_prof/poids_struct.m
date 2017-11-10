function W = poids_struct(gwing,ghortail,gvtail,gfuse,gtrain,gmotor,...
    gvolets,performance,type)
%Calcul du poids total de l'avion
%gwing.A = 2 %Allongement de l'aile
%gwing.eff = 0 %Effilement de l'aile
%gwing.fleche = 62 %Fleche du bord d'attaque de l'aile en deg
%gwing.S = 519 % Surface alaire ft^2
%gwing.epais = 0.04 % Epaisseur maximum du profil divisee par la corde
%gwing.x_epais = 0.4 %Ratio x/c de la position de l'epaisseur relative maximum du profil
%gwing.kdw = 0.768 % Coefficient 0.768 aile delta, 1 autre
%gwing.kvs = 1.0 % Coefficient 1.19 fleche variable 1 autre
%ghortail.A = 2 %Allongement de l'empennage
%ghortail.eff = 0.35%Effilement empennage
%ghortail.fleche = 62 %Angle de fleche bord d'attaque degree empennage
%ghortail.S = 74 %Surface alaire de l'empennage ft^2
%ghortail.epais = 0.04 % Epaisseur maximum du profil divisee par la corde
%ghortail.x_epais = 0.4 % Ratio x/c de la position de l'�paisseur relative maximum du profil
%ghortail.Lt = 33.6 %longueur du bras de levier empennage arriere ft
%gvtail.A = 1.1
%gvtail.eff = 0.3
%gvtail.fleche = 63
%gvtail.S = 100
%gvtail.epais = 0.04
%gvtail.x_epais = 0.4
%gvtail.Lt = 40
%gvtail.Hht = 0 % hauteur stabilisateur horizontal par rapport median fuselage
%gvtail.sr = 30 % surface du rudder
%gfuse.longueur = 126 %longueur du fuselage en ft
%gfuse.long_const = 43 % Longueur du fuselage avec une section constante (Dmax) ft
%gfuse.diam = 9 % diametre maximum du fuselage
%gfuse.k = 2.08e-5 %Rugosité de finition du fuselage ft
%gfuse.kdoor = 1.06 %Porte cargo
%gfuse.kdwf = 0.774 %Pas d'aile delta
%gfuse.Sf = 2284 % Surface mouillee du fuselage ft^2
%gfuse.vpr = 3990 % Volume pressurise du fuselage ft^3
%gfuse.F = 6 %Largeur du fuselage en ft au niveau de l'empennage
%gtrain.main_l = 40 %longueur du train d'atterrissage en in
%gtrain.main_nw = 4 % Nombre de roues du train principal
%gtrain.main_nss = 2 %  Nombre d'amortisseurs
%gtrain.avant_l = 50 %longueur du train d'atterrissage en in
%gtrain.avant_nw = 2 % Nombre de roues du train avant
%gtrain.klg = 1.12 % 1.12 pour un train d'atterrissage sur le fuselage, 1 autrement
%gtrain.n = 4.5 % Facteur de charge pour train d'atterrissage
%gmotor.n = 4 % Nombre de moteurs
%gmotor.poids = 2495 % Poids de un moteur lbf
%gmotor.longueur = 167.6 % Longueur du moteur en in
%gmotor.diam = 36.7 % Diametre du moteur en in
%gvolets.type = char('slotted','flap') %Type de volet TE et LE
%gvolets.sflap = [ 311.4 311.4]  %Surface de l'aile qui a des volets TE et LE ft^2
%gvolets.cvolet = [ 1.0 1.0 ] % Vecteur: fraction d'augmentation de la corde de l'aile pour volets Fowler TE et LE
%gvolets.cf = 0.2 %Corde des volets de bord de fuite sur corde du profil
%gvolet.fleche = [47 62] %angle de fleche de la ligne d'attache des volets deg
%performance.wto = 90523 %Poids au decollage
%performance.wla = 51597 %Poids atterrisage
%performance.wfuel = 41261 % Poids d'essence
%performance.Ma = 2.1 % Nombre de Mach de croisiere
%performance.H = 57100 % Altitude de croisiere ft
%performance.hla = 0 % Altitude d'atterrissage et de decollage
%performance.range = 4000 % Distance franchissable mn
%performance.CLc = 0.5 % Coefficient de portance 
%performance.CL_la = 2.2 % Coefficient de portance atterrissage
%performance.CL_to = 1.6 % Coefficient de portance decollage
%performance.CD0 = 0.015 % Coefficient de trainee portance nulle croisiere
%performance.CDw = 0.002 % Coefficient de trainee d'onde
%performance.CD0_to = 0.019 % Coefficient de trainee portance nulle decollage
%performance.CD0_la = 0.024 % Coefficient de trainee portance nulle atterrissage
%performance.TSFC = 0.6 % Consommation speficique lbf d'essence / lbf de pousse par heure
%performance.n = 4.5 % Facteur de charge pour l'avion
%type = 'transport' % Type d'avion : chasse, transport, generale

%Poids de l'aile
Waile = poids_aile(gwing.A, gwing.kdw, gwing.kvs, performance.n, performance.Ma, ...
    performance.H, gwing.S, gvolets.sflap(1), gwing.epais, performance.wto, ...
    performance.wfuel, gwing.fleche, gwing.eff, type);

%Poids de l'empennage horizontal
Whtail = poids_emp_hor(ghortail.A, gfuse.F, ghortail.Lt, performance.n, ...
    ghortail.S, ghortail.epais,performance.wto, ghortail.fleche, ...
    ghortail.eff, performance.Ma, performance.H );

%Poids de l'empenage vertical
Wvtail = poids_emp_vert(gvtail.A, gvtail.Hht, gvtail.Lt, performance.n, ...
    gvtail.S, gvtail.sr, gvtail.epais, performance.wto, gvtail.fleche, ...
    gvtail.eff, performance.Ma, performance.H );

%Poids du fuselage
Wfuse = poids_fuselage(gwing.A, gwing.S, gwing.eff, gwing.fleche, ...
    performance.n, gfuse.longueur, ghortail.Lt, gtrain.klg, ...
    gfuse.kdoor, gfuse.kdwf, gfuse.Sf, gfuse.diam, gfuse.diam, ...
    gfuse.vpr, performance.wto, performance.Ma, performance.H);

%Poids du train d'atterrisage principal
Wtrainp = poids_train_principal(gtrain.main_l, gtrain.n, ... 
    gtrain.main_nw, gtrain.main_nss, performance.CL_la, gwing.S, ...
    performance.wla, performance.hla ) ;

%Poids du train d'atterrissage avant
Wtraina = poids_train_avant(gtrain.avant_l, gtrain.n, gtrain.avant_nw, ...
    performance.wla );

%Poids du moteur
Wmoteur = gmotor.n * poids_moteur(gmotor.poids, type);

%Poids de tout le reste
Wautre = poids_reste(performance.wto,type);

%Poids de la structure
W= Waile + Whtail + Wvtail + Wfuse + Wtrainp + Wtraina + Wmoteur + Wautre;



