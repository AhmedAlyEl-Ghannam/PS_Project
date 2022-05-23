%%
function spacing = read_spacing()
    spacing = input('Enter 0 for Symmetric Spacing and 1 for Unsymmetric Spacing:  '); 
end

%%
function spac = read_spacing()
    spac = input('Enter 0 for Symmetric Spacing and 1 for Unsymmetric Spacing:  '); 
end

%% Function that Reads the User's Choice between T and π Models
function mod = line_model()
    mod = input('Enter 1 for π Model and 0 for T Model:  '); 
end

%% Function that Prints the Calculated Transmission Line Data
function variables_disp(R_AC, C_phase, L_phase, XL, XC, Y, Z, A, B, C, D)
    % Printing AC Resistance
    fprintf('AC Resistance = %0.3f\n', R_AC);
    % Printing Phase Capacitance
    fprintf('Capacitance = %0.3f\n', C_phase);
    % Printing Phase Inductance
    fprintf('Inductance = %0.3f\n', L_phase);
    % Printing Reactances
    fprintf('Inductive Reactance = %0.3f + j%0.3f\n', real(XL), imag(XL));
    fprintf('Capacitive Reactance = %0.3f + j%0.3f\n', real(XC), imag(XC));
    % Printing Admittance
    fprintf('Admittance = %0.3f + j%0.3f\n', real(Y), imag(Y));
    % Printing Impedence
    fprintf('Impedence = %0.3f + j%0.3f\n', real(Z), imag(Z));
    % Printing ABCD
    fprintf('A = %0.3f + j%0.3f\n', real(A), imag(A));
    fprintf('B = %0.3f + j%0.3f\n', real(B), imag(B));
    fprintf('C = %0.3f + j%0.3f\n', real(C), imag(C));
    fprintf('D = %0.3f + j%0.3f\n', real(D), imag(D)); 
end

%% Function Used to Plot the Graphs Required in Task 3 Case I
function task3_case1(A, B, C, D, Vr, j)
    % Initialize Power Factor (Constant, Given)
    pf = 0.8;
    
    % Active Power Varying Between 0 and 100kW at Receiving End
    Pr = 0:0.5:100;
    % Measuring Active Power in W and Dividing by 3 to get Power per Phase
    Pr = Pr.*1000/3;
   
    % Calculating the Value of Receiving-end Current
    Ir = (Pr ./ ( Vr * pf)) * exp(j * acos(pf));
    
    % Calculating Sending-end Values
    Vs = (A * Vr) + (B .* Ir);
    Is = (C * Vr) + (D .* Ir);
    Ss = Vs .* conj(Is);
    Ps = real(Ss);
    
    % Calculating Efficiency
    eff = Pr ./ Ps;
    
    % Calculating Receiving-end Voltage @ no load
    Vr_nl = Vs ./ A;
    
    % Calculating Voltage Regulation
    V_R = (abs(Vr_nl) - Vr) ./ Vr;
    
    % Measuring Active Power in kW and Reverting it to its Original Three-phase State 
    Pr = Pr.*3/1000;
    
    % Graphs
    % Plotting Efficiency in % vs Active Power in kW
    figure
    subplot(121)
    plot(Pr, eff.*100); 
    grid on
    title('Efficiency (%) vs Active Power (kW)')
    
    % Plotting Voltage Regulation (%) vs Active Power
    subplot(122)
    plot(Pr, V_R.*100); 
    grid on
    title('Plotting Voltage Regulation (%) vs Active Power')
    
end

%% Function Used to Plot the Graphs Required in Task 3 Case II
function task3_case2(A, B, C, D, Vr, j)
    % Defining Active Power @ Receiving End
    Pr = 100e3/3;
    
    % Defining Power Factor Ranging between 0.3 and 1
    pf = 0.3:0.01:1;

    % Calculating the Value of Receiving-end Current
    Ir_lag = (Pr ./ (Vr .* pf)) .* exp(j .* acos(pf));
    Ir_lead = (Pr ./ (Vr .* pf)) .* exp(-j .* acos(pf));
    
    % Calculations @ Lagging Power Factor
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
    
    % Calculations @ Leading Power Factor
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
    
    % Graphs @ Lagging Power Factor
    % Plotting Efficiency vs Power Factor 
    figure
    subplot(221)
    plot(pf, eff_lag)
    grid on
    title('Efficiency vs Lagging PF')

    % Plotting Voltage Regulation vs Power Factor
    subplot(222)
    plot(pf, V_R_lag)
    grid on
    title('Voltage Regulation vs Lagging')
    
    % Graphs @ Leading Power Factor
    % Plotting Efficiency vs Power Factor
    subplot(223)
    plot(pf, eff_lead)
    grid on
    title('Efficiency vs Leading PF')
    % Plotting Voltage Regulation vs Power Factor
    subplot(224)
    plot(pf, V_R_lead)
    grid on
    title('Voltage Regulation vs Leading PF')
    
end

