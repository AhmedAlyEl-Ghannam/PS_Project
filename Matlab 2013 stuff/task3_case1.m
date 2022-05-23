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



