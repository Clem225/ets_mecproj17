function iterParam(A,Wp,R,TSFC,M,H_cruse,T_loitier,Wr,Wt,WS_TO,T_Wto,Cd0,SL)
% ON DETERMINE LE POIDS
[ Wto, Wfuel, Wempty ] = itertow( 'jet-transport', M, H_cruise, ...
A, TSFC, T_loiter, Wr, Wtrap, Wp, R);

Wlanding = Wto-Wfuel;

% CALCUL surface � l'aire
S= Wto/WS_TO;

% CALCUL CHARGE ALAIRE LD
WS_L = Wlanding/S;

T = Wto*T_Wto;% Cours 3, valeurs typiques longues distances

% AERODYNAMIQUE/PERFORMANCE
F_max = sqrt(1/(4*Cd0*k_oswald(9.3,0.8))); %par methode d'oswald 

% Calcul du CLmax,L = CLmax
LP = (SL - 400) / 118;
CLmax = WS_L / LP;

% Calcul du CLmax,TO
CLmaxTO = 0.8 * CLmax;

% Calcul de la distance de d�collage
TOP = WS_TO * (1/CLmaxTO) * (1/T_Wto);
Sto = 20.9*TOP + 87*sqrt(TOP*T_Wto);

fprintf('--- Param�tres ---\n');
fprintf('Wto : %d\n',Wto);
fprintf('Wf : %d\n',Wfuel);
fprintf('We : %d\n',Wempty);
fprintf('Wl : %d\n\n',Wlanding);
fprintf('S : %d\n',S);
fprintf('b : %d\n',sqrt(A*S));
fprintf('T : %d\n\n',T);
fprintf('Finesse max : %d\n',F_max);
fprintf('Clmax, TO : %d\n',CLmaxTO);
fprintf('Clmax, LA : %d\n\n',CLmax);
fprintf('TOD : %d\n',Sto);
fprintf('Clmax, TO : %d\n',CLmaxTO);

end