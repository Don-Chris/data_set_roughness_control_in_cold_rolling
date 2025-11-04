function Ra = imprintModel(F, t_rel, params)
% Ra = imprintModel(F, t_rel, params)
% Ra = imprintModel(F, [], params)
%
% Estimation of the resulting strip roughness after cold rolling based on
% the specific force (F devided by strip width) and specific tension offset
% (tension at the outlet - tension at the inlet divided by strip width)
% 
% "Simple Imprint Model" based on https://doi.org/10.1016/j.ifacol.2021.10.059
% params = [Ra_in,Ra_walze,F_90]
%
% "Asymmetric Tension Imprint Model (ATIM)" based on "Potential of
% asymmetric strip tension to control the surface roughness in cold rolling"
% params = [Ra_in,Ra_walze,F_90,dRa_in,dF_90,dRa_walze_up,dRa_walze_down]


% Berechnen von Ra_in, F_90 und Ra_walze in abhängigkeit von t_rel
if isfield(params,'dRa_in')
    Ra_in = params.Ra_in + params.dRa_in * t_rel;
else
    Ra_in = params.Ra_in;
end
if isfield(params,'dF_90')
    F_90 = params.F_90 - params.dF_90* t_rel;
else
    F_90 = params.F_90;
end
if isfield(params,'dRa_walze')
    Ra_walze = params.Ra_walze + params.dRa_walze * abs(t_rel);
else
    Ra_walze = params.Ra_walze;
end

Ra = abpraegeModell(F, Ra_in, params.C_roll * Ra_walze, F_90);


end

function Ra = abpraegeModell(F, Ra_in, Ra_Walze, F_90)
% Ra = abpraegeModell(F, Ra_in, Ra_Walze)
%
% Schätzung der arithmetischen Mittenrauheit durch die Sigmoid Function und
% der einlaufenden, sowie auslaufenden Rauheit
% 
% Basierend auf ersten Versuchen vom 05.11.2020 mit Sandgestrahlten Walzen
% der Rauheit Ra = 3.5um und initialer Rauheit Ra = 0.6um

% Fmin = 2;
% Fmax = 13;
% F_90 = 13;

% p = 0.9; % bei Fmin und Fmax soll die Sigmoid Funktion 10% bzw 90% haben
% x_max = -log(1/p-1); %Lösung für p = sigmoid(x)

%% Umrechung von F im Bereich [Fmin,Fmax] zu [-x_max,x_max]
% x = (F-Fmin)/(Fmax-Fmin)*2*x_max-x_max;
x = (9/4*F./F_90-5/4)*log(9);

%% Einsetzen in die sigmoid-Fcn
sigm = 1./(1+exp(-x));

%% Skalieren des Sigmoids [0,1] zu [Ra_min,Ra_Walze]
Ra = Ra_in + sigm.* (Ra_Walze-Ra_in);

end
