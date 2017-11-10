function W = poids_reste(Wdg, type)
%Poids de tout le reste sauf l'essence
%Wdg= 88817 % Poids de design de l'avion lbf
%type = 'transport' % Sorte d'avion : chasse, transport, generale

switch lower(type)
    case('chasse')
        %Coefficient pour avion de chasse
        c = 0.17;
    case('transport')
        %Coefficient pour avion de transport
        c = 0.17;
    case('generale')
        %Coefficient pour aviation générale
        c= 0.14;
end

W = c*Wdg;
