%% This Project was Prepared By:
% Ahmed Aly Gamal El-Din El-Ghannam  19015292
% Ahmed Sherif Ahmed Mahmoud Ghanim  19015255
% Kerollos Saad Thomas Shokrallah    19016188
% Yahia Walid Mohamed El-Dakhakhny   19016891
% Ahmed Yosri Ahmed Arafa    17010296

%% Prologue: Setup
clear;
clc;
fprintf('Welcome to the Transmission Line Wizard >> \n\n');

%% Task_1: Transmission Line Parameters

%% A) Reading Values from the User
% Storing Resistivity
ConResistivity = input("Enter a Value for the Conductor's Resistivity in Ohm/m:  ");

% Storing Length
ConLength = input("Enter a Value for the Conductor's Length in km:  ");

% Storing Diameter
ConDiameter = input("Enter a Value for the Conductor's Diameter in m:  ");

% Calculating Radius
ConRadius = (ConDiameter / 2);

% Calculating Conductor Length in m
ConLength_m = (ConLength) * 1e3;

%% B) Inductance and Capacitance Parameters
% Spacing Between Conductors
spacing = read_spacing();

while (1)
    
    % Symmetric
    if (spacing == 0)
       % Calculating GMD
       GMD = input("Enter a Value for the Distance Between Conductors in m:  "); 
       break;
    
    % Unsymmetric
    elseif (spacing == 1)
        D_12 = input("Enter a Value for the Distance Between Conductors One and Two in m:  ");
        D_23 = input("Enter a Value for the Distance Between Conductors Two and Three in m:  ");
        D_13 = input("Enter a Value for the Distance Between Conductors One and Three in m:  ");
        % Calculating GMD
        GMD = nthroot((D_12 * D_23 * D_13), 3);
        break;
    % Idiotproofing Spacing
    else
        disp("Invalid Input! Try Again");
        spacing = read_spacing();
    end
    
end

%% Calculating Resistance

%Calculating Area
area = (pi / 4) * (ConDiameter * ConDiameter);

% DC Resistance
R_DC = (ConResistivity * ConLength_m ) / area;

% AC Resistance
R_AC = 1.1 * R_DC;

%% Calculating Inductance

% Magnetic Permeability
meu = (4 * pi) * 1e-7;


% Geometric Mean Radius
GMR = ConRadius * exp(-0.25);

% Inductance Per Phase
L_per_m = (meu / (2 * pi)) * log(GMD / GMR);

% Inductance
L_phase = L_per_m * ConLength_m;

%% Calculating Capacitance

% Electric Permitivity
epsilon = 8.85e-12;

% Capacitance Per Phase
C_per_m = (2 * pi * epsilon) / log(GMD / ConRadius);

% Capacitance
C_phase = C_per_m * ConLength_m;
%%%%%%%% End of Transmission Line Parameters %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 2: ABCD Parameters

% Defining sqrt(-1) as j
j = 1i;

% Calculating OMEGA (Assuming f = 50Hz)
f = 50;
omega = 2 * pi * f;

% Calculating Inductive Reactance
XL = (j * omega * L_phase);

% Calculating Capacitive Reactance
XC = 1 / (j * omega * C_phase);

% Calculating Impedence
Z = R_AC + XL;

% Calculating Admittance
Y = (j * omega  * C_phase);

% Determining The Transmission Line Model Based on its Length
if (ConLength <= 80)
    % Identifying Transmission Line Model Used as Short
    state = 0;
    disp('Based on the Line Length Entered, The Trasmission line is Short.');
    
    % Short Line Parameters are Used
    A = 1;
    B = Z;
    C = 0;
    D = 1; 
    
elseif (ConLength <= 250)  
    
    % Identifying Transmission Line Model Used as Medium
    state = 81;
    disp('Based on the Line Length Entered, The Trasmission line is Medium.');
        
    % Medium Line Parameters are Used Based on the Circuit Model
    model = line_model();
        
    % Idiotproofing Model
    while (1)
    
      if (model == 0)
          % Medium Line Parameters for PI Model
          A = 1 + (Y * Z / 2);
          B = Z;
          C = Y * (1 + (Y * Z / 4));
          D = 1 + ((Y * Z) / 2);
          %Printing the Calculated Variables 
          variables_disp(R_AC, C_phase, L_phase, XL, XC, Y, Z, A, B, C, D);
          break;
                
      elseif (model == 1)
          % Medium Line Parameters for T Model
          A = 1 + (Y * Z / 2);
          B = Z * (1 + (Y * Z / 4));
          C = Y;
          D = 1 + (Y * Z / 2);
          %Printing the Calculated Variables 
          variables_disp(R_AC, C_phase, L_phase, XL, XC, Y, Z, A, B, C, D);
          break;
      else
          disp("Invalid Input! Try Again");
          model = line_model();
      end
            
    end    

else
    state = 251;
    disp('\nBased on the line length entered. The Trasmission line is Long.');
    disp('This Program is not able to calculate Long Transmission Parameters.\nTerminated ..');
    A = 0;
    B = 0;
    C = 0;
    D = 0;
    
end

%%%%%%%%%%%%%%%%% ABCD Parameters %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 3: Transmission Line Performance

if (state ~= 251)
    % Prologue : Prompting the User to Enter the Receiving-end Voltage
    Vr = input('Enter a Value for The Receiving-End Phase Voltage in v:  ');

    % Case I
    task3_case1(A, B, C, D, Vr, j);

    % Case II
    task3_case2(A, B, C, D, Vr, j);
end

%%%%%%%%%%% Transmission Line Performance %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Functions Used. Put at The End of Program

%% Function that Reads Spacing Between Conductors
function spac = read_spacing()
    spac = input("Enter 0 for Symmetric Spacing and 1 for Unsymmetric Spacing:  "); 
end

%%Function that Reads the User's Choice between T and π Models
function mod = line_model()
    mod = input("Enter 1 for π Model and 0 for T Model:  "); 
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
    %% Initialize Power Factor (Constant, Given)
    pf = 0.8;
    
    %% Active Power Varying Between 0 and 100kW at Receiving End
    Pr = 0:0.5:100;
    % Measuring Active Power in W and Dividing by 3 to get Power per Phase
    Pr = Pr.*1000/3;
   
    %% Calculating the Value of Receiving-end Current
    Ir = (Pr ./ ( Vr * pf)) * exp(j * acos(pf));
    
    %% Calculating Sending-end Values
    Vs = (A * Vr) + (B .* Ir);
    Is = (C * Vr) + (D .* Ir);
    Ss = Vs .* conj(Is);
    Ps = real(Ss);
    
    %% Calculating Efficiency
    eff = Pr ./ Ps;
    
    %% Calculating Receiving-end Voltage @ no load
    Vr_nl = Vs ./ A;
    
    %% Calculating Voltage Regulation
    V_R = (abs(Vr_nl) - Vr) ./ Vr;
    
    %% Measuring Active Power in kW and Reverting it to its Original Three-phase State 
    Pr = Pr.*3/1000;
    
    %% Graphs
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
    %% Defining Active Power @ Receiving End
    Pr = 100e3/3;
    
    %% Defining Power Factor Ranging between 0.3 and 1
    pf = 0.3:0.01:1;

    %% Calculating the Value of Receiving-end Current
    Ir_lag = (Pr ./ (Vr .* pf)) .* exp(j .* acos(pf));
    Ir_lead = (Pr ./ (Vr .* pf)) .* exp(-j .* acos(pf));
    
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









