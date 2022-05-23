%% THIS COPY IS FOR MATLAB2013%%

%% This Project was Prepared By:
% Ahmed Aly Gamal El-Din El-Ghannam  19015292
% Ahmed Sherif Ahmed Mahmoud Ghanim  19015255
% Kerollos Saad Thomas Shokrallah    19016188
% Yahia Walid Mohamed El-Dakhakhny   19016891
% Yosry                                N/A

%% Prologue: Setup
clear;
clc;
fprintf('Welcome to the Transmission Line Wizard >> \n\n');

%% Task_1: Transmission Line Parameters

%% A) Reading Values from the User
% Storing Resistivity
ConResistivity = input('Enter a Value for the Conductor''s Resistivity in Ohm/m:  ');

% Storing Length
ConLength = input('Enter a Value for the Conductor''s Length in km:  ');

% Storing Diameter
ConDiameter = input('Enter a Value for the Conductor''s Diameter in m:  ');

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
       GMD = input('Enter a Value for the Distance Between Conductors in m:  '); 
       break;
    
    % Unsymmetric
    elseif (spacing == 1)
        D_12 = input('Enter a Value for the Distance Between Conductors One and Two in m:  ');
        D_23 = input('Enter a Value for the Distance Between Conductors Two and Three in m:  ');
        D_13 = input('Enter a Value for the Distance Between Conductors One and Three in m:  ');
        % Calculating GMD
        GMD = nthroot((D_12 * D_23 * D_13), 3);
        break;
    % Idiotproofing Spacing
    else
        disp('Invalid Input! Try Again');
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
          disp('Invalid Input! Try Again');
          model = line_model();
      end
            
    end    

else
    state = 251;
    fprintf('\nBased on the line length entered. The Trasmission line is Long.');
    fprintf('This Program is not able to calculate Long Transmission Parameters.\nTerminated ..');
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

%%Functions Used. Put at The End of Program

%%Function that Reads Spacing Between Conductors







