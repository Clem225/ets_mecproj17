%= Main file for the calculation 
Cd = 0.021;
cte = (2/0.85^2*W2/S).*(3*1/(pi*9.40*0.8)./Cd).^0.5;
H = [0:1e3:40e3];

for i=1:size(H,2)
    var(i) = 1.4*1716.5*9/5*tempatmstd(H(i))*density(H(i));
end

plot(H,var,'r-');
test = interp1(var,H,cte)/1E3
%plot(Cd,interp1(var,H,cte)/1E3);

%%
%== Mission Parameter
    
    PAX = 70;   % Passager number.
    Crew = 3;   % Crew number.
    Wpax = 200; % Weight for 1 passager (lb).
    Rref = 5000;   % Range in (nautic mille)
    M = 0.85;   % Max Speed
    A = 9.5 ;
    twaiting = 0.5; % Waiting Time in (h)
    hwaiting = 5e3; % Waiting Altitude (ft)
    %hcruse = 40e3; % Crusing Altitude (ft)
    TSFC = 0.5;
    
    Range = [5000 6000 7000];
    Wpayload = ([70 80]+3)*240;
    hcruse = [27 32 47]*1e3;
    DOE = fullfact([3 2 3]);
    W = zeros(size(DOE,1),3);
    for i=1:size(DOE,1)
        [ Wto, Wfuel, Wempty ] = itertow('jet-transport',M, hcruse(DOE(i,3)), A, TSFC, ...
            twaiting*60, 0.05, 0.01, Wpayload(DOE(i,2)), Range(DOE(i,1)));
        W(i,:) = [Wto Wfuel Wempty];
    end
    figure(1)
    interactionplot(W(:,1)/1E3,DOE,'varnames',{'Range','PAX','H Cruise'});
    title('Influence des Paramètres de mission sur le Poids au décollage W_{to} x1000')
    figure(2)
    interactionplot(W(:,2)/1E3,DOE,'varnames',{'Range','PAX','H Cruise'});
    title('Influence des Paramètres de mission sur le Poids de fuel W_{f} x1000')

