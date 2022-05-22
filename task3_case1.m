% Task 3 Case 1
function task3_case1(A, B, C, D)
    % Initialize power factor which is a constant
    pf = 0.8;
    % Initialize recieved power
    Pr = 0:0.5:100;
    % multiply by 1000 to adjust scale and devide by 3 to get power per phase
    Pr = Pr.*1000/3;
   
    % Get Vr from user
    Vr = input('Enter Vr: ');
    
    % Calculate Ir
    Ir = (Pr./(Vr*pf)) * exp(1i*acos(pf));
    
    % Calculate sending end values
    Vs = A*Vr + B.*Ir;
    Is = C*Vr + D.*Ir;
    Ss = Vs.*conj(Is);
    Ps = real(Ss);
    
    % Calculating output values
    eff = Pr./Ps; % efficiency
    Vrnl = Vs./A; % recieved voltage at no load
    V_R = (abs(Vrnl) - Vr)./Vr;
    
    % Revert Pr to its original 3 phase state and measured in kW
    Pr = Pr.*3/1000;
    
    % Plotting the output
    figure
    subplot(121)
    plot(Pr, eff.*100); % graph efficiency in %
    grid on
    title('Percentage efficiency vs active power')
    
    subplot(122)
    plot(Pr, V_R.*100); % graph V_R in %
    grid on
    title('Percentage voltage regulation vs active power')
    
end
