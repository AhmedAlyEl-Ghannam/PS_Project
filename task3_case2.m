% Task 3 case 2
function task3_case2(A, B, C, D)
    % Define constants
    Pr = 100e3/3;
    pf = 0.3:0.01:1;

    % Get Vr from user
    Vr = input('Enter Vr: ');
    
    % Calculate Ir
    Ir_lag = (Pr./(Vr.*pf)) .* exp(1i.*acos(pf));
    Ir_lead = (Pr./(Vr.*pf)) .* exp(-1i.*acos(pf));
    
    % Calculate lag values
    Vs_lag = A*Vr + B.*Ir_lag;
    Is_lag = C*Vr + D.*Ir_lag;
    Ss_lag = Vs_lag.*conj(Is_lag);
    Ps_lag = real(Ss_lag);
    eff_lag = Pr./Ps_lag; % efficiency for lag
    Vrnl_lag = Vs_lag./A; % Vr at no load for lag
    V_R_lag = (abs(Vrnl_lag) - Vr)./Vr; % Voltage regulation for lag
    
    % Calculate lead values
    Vs_lead = A*Vr + B.*Ir_lead;
    Is_lead = C*Vr + D.*Ir_lead;
    Ss_lead = Vs_lead.*conj(Is_lead);
    Ps_lead = real(Ss_lead);
    eff_lead = Pr./Ps_lead;% efficiency for lead
    Vrnl_lead = Vs_lead./A; % Vr at no load for lead
    V_R_lead = (abs(Vrnl_lead) - Vr)./Vr; % Voltage regulation for lead
    
     % Plot graphs
    figure
    subplot(221)
    plot(pf, eff_lag)
    grid on
    title("Efficiency vs pf for Lag")

    subplot(222)
    plot(pf, V_R_lag)
    grid on
    title("Voltage Regulation vs pf for Lag")
    
    
    
    subplot(223)
    plot(pf, eff_lead)
    grid on
    title("Efficiency vs pf for Lead")

    subplot(224)
    plot(pf, V_R_lead)
    grid on
    title("Voltage Regulation vs pf for Lead")
    
end
