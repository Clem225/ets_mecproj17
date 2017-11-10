function W=poids_moteur(Wun, type)
%Poids du moteur
%Wun =  8000 %Poids du moteur non installe
%type = 'transport' % Sorte d'avion : chasse, transport, generale

%Coefficient
switch lower(type)
    case('chasse')
        %Coefficient pour avion de chasse
        c = 1.3;
    case('transport')
        %Coefficient pour avion de transport
        c = 1.3;
    case('generale')
        %Coefficient pour aviation générale
        c = 1.4;
end

W = c*Wun;