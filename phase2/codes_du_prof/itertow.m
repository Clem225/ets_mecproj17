function [ Wto, Wfuel, Wempty ] = itertow( Type, M_cruise, H_cruise, ...
    A, TSFC, T_loiter, Fuel_res, Fuel_trap, Wpayload, Range );
% Evaluation du poids initial d'un avion a l'aide de relations tirees, 
% en partie de Corke, Design  of aircraft, chapitre 2, 2003
%
% Copyright 2008: Francois Morency
%
% ---------------------------------------------------------------------
% Ces valeurs d'entree de la fonction sont definies par l'usager
% ---------------------------------------------------------------------
% M_cruise=0.82 % Vitesse de croisiere
% H_cruise=40000 % altitude en ft
% A=10.0 % allongement
% TSFC=0.45 % Specific fuel consumption lb / libre de poussee par heure 
% T_loiter=45 % Temps d'attente en minute 
% Fuel_res=0.05 % Fraction d'essence avant l'atterrisage
% Fuel_trap=0.01 % Fraction d'essence dans les conduites
% Wpayload= 30750 % Charge utile en lbf
% Range=3500 % Distance en mille nautique
% Type='jet-transport' % Type d'avion, dans structure_factor
% ---------------------------------------------------------------------
% Ces valeurs sont retournees par la fonction
% ---------------------------------------------------------------------
% Wto : poids total au décollage, lbf
% Wfuel : poids d'essence au décollage, lbf
% Wempty : poids a vide, sans charge payante, lbf

% ---------------------------------------------------------------------
% trouver la valeur de Wto dans un interval
% on cherche les zeros de la fonction residue
% ---------------------------------------------------------------------
options=optimset();
Wto=fzero(@(Wto)fpoids(Wto,Range),[Wpayload 1e4*Wpayload],options);

% ---------------------------------------------------------------------
% calculer le facteur de structure correspondant a Wto
% ---------------------------------------------------------------------
Sfactor=structure_factor(Type,Wto);

% ---------------------------------------------------------------------
% calculer Wfuel, Wempty
% ---------------------------------------------------------------------
Wempty=Sfactor*Wto;
Wfuel=Wto-Wempty-Wpayload;

% ---------------------------------------------------------------------
%sortie a l'ecran
% ---------------------------------------------------------------------
sprintf(' %s %.0f \r %s %.0f \r %s %.0f \r %s %.0f','Wto=',Wto, ...
    'Wempty=', Wempty,'Wfuel=',Wfuel)
sprintf('%s %0.3f', 'Facteur de structure',Sfactor)

% ---------------------------------------------------------------------
% fin de la fonction principale.  Les fonctions secondaires sont definies a
% l'interieur de celle-ci pour beneficier des variables globales
% ---------------------------------------------------------------------


    function resw = fpoids(Wto,Range)
% ---------------------------------------------------------------------
% fonction de calcul de poids decollage
% ---------------------------------------------------------------------

% ---------------------------------------------------------------------      
%fraction de poids au decollage
% ---------------------------------------------------------------------
    fdec = 0.975;
% ---------------------------------------------------------------------
%fraction de poids atterrissage
% ---------------------------------------------------------------------
    fland = 0.975;

% ---------------------------------------------------------------------
% fonction residue
% ---------------------------------------------------------------------
    resw = 1 - (Wpayload/Wto + structure_factor(Type,Wto) + ...
        (1-fdec*fclimb*fcruise*floiter*fland)*(1+Fuel_res+Fuel_trap));
% ---------------------------------------------------------------------
% fin de la fonction resw.  Les fonctions secondaires sont definies a
% l'interieur de celle-ci pour beneficier des variables globales
% ---------------------------------------------------------------------
    

        function fc = fclimb;
% ---------------------------------------------------------------------   
% fonction fraction de poids en montee
% ---------------------------------------------------------------------            
        if (M_cruise < 1); 
            fc = 1 -0.04*M_cruise;
        else
            fc = 0.96-0.03*(M_cruise-1);
        end
        end
% ---------------------------------------------------------------------
% fin de la fonction fclimb.
% ---------------------------------------------------------------------
        
        function fl = floiter;
% ---------------------------------------------------------------------        
% fonction fraction de poids en attente
% ---------------------------------------------------------------------  

% ---------------------------------------------------------------------            
%estimation de la finesse maximum
% ---------------------------------------------------------------------
        ldmax=finesse(M_cruise,A);

% ---------------------------------------------------------------------        
%le temps d'attente est en minutes
% ---------------------------------------------------------------------
        flinv = exp(T_loiter*TSFC/(ldmax*60));
        fl=1/flinv;
        
        end
% ---------------------------------------------------------------------
% fin de la fonction floiter
% ---------------------------------------------------------------------       


        function fc = fcruise
% ---------------------------------------------------------------------
%fraction de poids en croisiere
% ---------------------------------------------------------------------

% ---------------------------------------------------------------------
%estimation de la finesse maximum
% ---------------------------------------------------------------------
        ldmax=finesse(M_cruise,A);
        
% ---------------------------------------------------------------------
% pour un avion a reaction, distance franchissable max a 0.866ldmax
% ---------------------------------------------------------------------
        ld=0.866*ldmax;

% ---------------------------------------------------------------------
% vitesse de croisiere
% ---------------------------------------------------------------------
        vc = vitesse(M_cruise,H_cruise);

% ---------------------------------------------------------------------
% la distance franchissable est en mille nautique
% ---------------------------------------------------------------------
        fcinv = exp(Range*TSFC*6080/(vc*ld*3600));
        fc = 1 / fcinv;
        end
% ---------------------------------------------------------------------
% fin de la fonction fcruise
% ---------------------------------------------------------------------        

    end
end
