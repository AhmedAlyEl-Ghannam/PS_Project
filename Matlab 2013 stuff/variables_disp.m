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