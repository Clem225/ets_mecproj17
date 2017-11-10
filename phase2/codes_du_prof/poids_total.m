function W = poids_total(gwing,ghortail,gvtail,gfuse,gtrain,gmotor,gvolets,performance,type)
%Calcul du poids total de l'avion
gwing.A = 2 %Allongement de l'aile
gwing.eff = 0 %Effilement de l'aile
gwing.fleche = 62 %Fleche du bord d'attaque de l'aile en deg
gwing.S = 519 % Surface alaire ft^2
gwing.epais = 0.04 % Epaisseur maximum du profil divisee par la corde
gwing.x_epais = 0.4 %Ratio x/c de la position de l'epaisseur relative maximum du profil
ghortail.A = 2 %Allongement de l'empennage
ghortail.eff = 0.35%Effilement empennage
ghortail.fleche = 62 %Angle de fleche bord d'attaque degree empennage
ghortail.S = 74 %Surface alaire de l'empennage ft^2
ghortail.epais = 0.04 % Epaisseur maximum du profil divisee par la corde
ghortail.x_epais = 0.4 % Ratio x/c de la position de l'�paisseur relative maximum du profil
ghortail.Lt = 33.6 %longueur du bras de levier empennage arriere ft
gvtail.A = 1.1
gvtail.eff = 0.3
gvtail.fleche = 63
gvtail.S = 100
gvtail.epais = 0.04
gvtail.x_epais = 0.4
gvtail.Lt = 40
gfuse.longueur = 121 %longueur du fuselage en ft
gfuse.long_const = 43 % Longueur du fuselage avec une section constante (Dmax) ft
gfuse.diam = 9 % diametre maximum du fuselage
gfuse.k = 2.08e-5 %Rugosité de finition du fuselage ft
gfuse.kdoor = 1.06 %Porte cargo
gfuse.kdwf = 1.0 %Pas d'aile delta
gfuse.Sf = 2284 % Surface mouillee du fuselage ft^2
gfuse.vpr = 3990 % Volume pressurise du fuselage ft^3
gtrain.main_lm = 40 %longueur du train d'atterrissage en in
gtrain.main_nmw = 4 % Nombre de roues du train principal
gtrain.main_mss = 2 %  Nombre d'amortisseurs
gtrain.avant_ln = 50 %longueur du train d'atterrissage en in
gtrain.avant_nnw = 2 % Nombre de roues du train avant
gmotor.n = 4 % Nombre de moteurs
gmotor.poids = 2494 % Poids de un moteur lbf
gmotor.longueur = 167.6 % Longueur du moteur en in
gmotor.diam = 36.7 % Diametre du moteur en in
gvolets.type = char('slotted','flap') %Type de volet TE et LE
gvolets.sflap = [ 311.4 311.4]  %Surface de l'aile qui a des volets TE et LE ft^2
gvolets.cvolet = [ 1.0 1.0 ] % Vecteur: fraction d'augmentation de la corde de l'aile pour volets Fowler TE et LE
gvolets.cf = 0.2 %Corde des volets de bord de fuite sur corde du profil
gvolet.fleche = [47 62] %angle de fleche de la ligne d'attache des volets deg
performance.wto = 90523 %Poids au decollage
performance.wla = 51597 %Poids atterrisage
performance.wfuel = 41261 % Poids d'essence
performance.Ma = 0.9 % Nombre de Mach de croisiere
performance.H = 55 000 % Altitude de croisiere ft
performance.range = 4 000 % Distance franchissable mn
performance.CLc = 0.5 % Coefficient de portance 
performance.CLla = 1.9 % Coefficient de portance atterrissage
performance.CLto = 1.6 % Coefficient de portance decollage
performance.CD0 = 0.015 % Coefficient de trainee portance nulle croisiere
performance.CDw = 0.002 % Coefficient de trainee d'onde
performance.CD0_TO = 0.019 % Coefficient de trainee portance nulle decollage
performance.CD0_LA = 0.024 % Coefficient de trainee portance nulle atterrissage
type = 'transport' % Type d'avion : chasse, transport, generale







