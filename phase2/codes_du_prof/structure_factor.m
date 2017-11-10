function sf = structure_factor(type,wto)
% Evaluation du facteur de structure initial d'un avion a l'aide d'une 
% relation tiree de Corke, Design  of aircraft, chapitre 1, 2003
%
% Copyright 2008: François Morency
%
% ---------------------------------------------------------------------
% Valeurs d'entree de la fonction
% ---------------------------------------------------------------------
% type : type d'avion selon Corke
% wto : poids total au decollage, lbf

% ---------------------------------------------------------------------
% Valeur retournee par la fonction
% ---------------------------------------------------------------------
% sf : facteur de structure 

switch lower(type)
    case { 'planeur' }
        a=0.86;
        c=-0.05;
    case { 'planeur-motorise' }
        a=0.91;
        c=-0.05;
    case { 'const-individuelle' }
        a=1.19;
        c=-0.09;
    case { 'const-individuelle(comp)' }
        a=1.15;
        c=-0.09;
    case { 'aviation-gen(1mot)' }
        a=2.36;
        c=-0.18;
    case { 'aviation-gen(2mot)' }
        a=1.51;
        c=-0.10;
    case { 'avion-agricole' }
        a=0.74;
        c=-0.03;
    case { 'turboprop(2mot)' }
        a=0.96;
        c=-0.05;
    case { 'hydravion' }
        a=1.09;
        c=-0.05;
    case { 'jet-entrainement' }
        a=1.59;
        c=-0.10;
    case { 'jet-combat' }
        a=2.34;
        c=-0.13;
    case { 'jet-transport' }
        a=1.02;
        c=-0.06;
    case { 'bombardier' }
        a=0.93;
        c=-0.07;
    otherwise
        error('Type avion inconnu')
        return
end

%sf=a*wto^c;
sf=0.5;
end