%% Function that Prints the Calculated Transmission Line Data
function variables_disp(R_AC, C_phase, L_phase, XL, XC, Y, Z, A, B, C, D)
    fprintf('Transmission Line Parameters of the Whole Line: \n');
    % Printing AC Resistance
    fprintf('\tAC Phase Resistance = %0.3f ohm\n', R_AC);
    % Printing Phase Capacitance
    fprintf('\tPhase Capacitance = %0.3f uF\n', C_phase*10^6);
    % Printing Phase Inductance
    fprintf('\tPhase Inductance = %0.3f mH\n', L_phase*1000);
    % Printing Reactances
    % TODO: reactance is pure imaginary remove real part
    fprintf('\tPhase Inductive Reactance = %0.3f + j%0.3f ohm\n', real(XL), imag(XL));
    fprintf('\tPhase Capacitive Reactance = %0.3f + j%0.3f ohm\n', real(XC), imag(XC));
    % Printing Admittance
    fprintf('\tPhase Admittance = %0.3f + j%0.3f seimens\n', real(Y), imag(Y));
    % Printing Impedence
    fprintf('\tPhase Impedence = %0.3f + j%0.3f ohm\n', real(Z), imag(Z));
    % Printing ABCD
    fprintf('ABCD Parameters: \n');
    fprintf('\tA = %0.3f + j%0.3f\n', real(A), imag(A));
    fprintf('\tB = %0.3f + j%0.3f\n', real(B), imag(B));
    fprintf('\tC = %0.3f + j%0.3f\n', real(C), imag(C));
    fprintf('\tD = %0.3f + j%0.3f\n\n\n', real(D), imag(D)); 
end
