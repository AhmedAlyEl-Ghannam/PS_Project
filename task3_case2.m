% Task 3 case 2
function task3_case2(A, B, C, D)
    % Defining sqrt(-1) as j
    j = 1i;
    
    %% Defining Active Power @ Receiving End
    Pr = 304800000/3;
    
    %% Defining Power Factor Ranging between 0.3 and 1
    pf = 0.3:0.01:1;

    %% Prompting the User to Enter the Receiving-end Voltage
    Vr = input('Enter a Value for The Receiving-End Phase Voltage in v:  ');
    
    %% Calculating the Value of Receiving-end Current
    Ir_lag = (Pr ./ (Vr .* pf)) .* exp(-j .* acos(pf));
    Ir_lead = (Pr ./ (Vr .* pf)) .* exp(j .* acos(pf));
    
    %% Calculations @ Lagging Power Factor
    % Calculating Sending-End Values
    Vs_lag = (A * Vr) + (B .* Ir_lag);
    Is_lag = (C * Vr) + (D .* Ir_lag);
    Ss_lag = Vs_lag .* conj(Is_lag);
    Ps_lag = real(Ss_lag);
    
    % Calculating Efficiency
    eff_lag = Pr./Ps_lag; 
    
    % Calculating Receiving-end Voltage @ no load
    Vrnl_lag = Vs_lag./A; 
    
    % Calculating Voltage Regulation
    V_R_lag = (abs(Vrnl_lag) - Vr)./Vr;
    
    %% Calculations @ Leading Power Factor
    % Calculating Sending-End Values
    Vs_lead = A*Vr + B.*Ir_lead;
    Is_lead = C*Vr + D.*Ir_lead;
    Ss_lead = Vs_lead.*conj(Is_lead);
    Ps_lead = real(Ss_lead);
    
    % Calculating Efficiency
    eff_lead = Pr./Ps_lead;
    
    % Calculating Receiving-end Voltage @ no load
    Vrnl_lead = Vs_lead./A; 
    
    % Calculating Voltage Regulation
    V_R_lead = (abs(Vrnl_lead) - Vr)./Vr;
    
    %% Graphs @ Lagging Power Factor
    % Plotting Efficiency vs Power Factor 
    figure
    subplot(221)
    plot(pf, eff_lag)
    grid on
    title("Efficiency vs Lagging PF")

    % Plotting Voltage Regulation vs Power Factor
    subplot(222)
    plot(pf, V_R_lag)
    grid on
    title("Voltage Regulation vs Lagging")
    
    %% Graphs @ Leading Power Factor
    % Plotting Efficiency vs Power Factor
    subplot(223)
    plot(pf, eff_lead)
    grid on
    title("Efficiency vs Leading PF")
    % Plotting Voltage Regulation vs Power Factor
    subplot(224)
    plot(pf, V_R_lead)
    grid on
    title("Voltage Regulation vs Leading PF")
    
end
