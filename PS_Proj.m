%% This Project was Prepared By:
% Ahmed Aly Gamal El-Din El-Ghannam  19015292
% Ahmed Sherif Ahmed Mahmoud Ghanim  19015255
% Kerollos Saad Thomas Shokrallah    19016188
% Yahia Walid Mohamed El-Dakhakhny   19016891
% Ahmed Yosri Ahmed Arafa            17010296

%% Prologue: Setup
clear;
clc;
fprintf('Welcome to the Transmission Line Wizard >> \n\n');

%% Task_1: Transmission Line Parameters

%% A) Reading Values from the User
% Storing Resistivity
ConResistivity = input("Please Enter a Value for the Conductor's Resistivity in ohm.m:  ");

% Storing Length
ConLength = input("Please Enter a Value for the Conductor's Length in km:  ");

% Storing Diameter
ConDiameter = input("Please Enter a Value for the Conductor's Diameter in m:  ");

% Calculating Radius
ConRadius = (ConDiameter / 2);

% Calculating Conductor Length in m
ConLength_m = (ConLength) * 1e3;

%% B) Inductance and Capacitance Parameters
% Spacing Between Conductors
spacing = read_spacing();

while (1)
    
    % Symmetric
    if (spacing == 1)
       % Calculating GMD
       GMD = input("Please Enter a Value for the Distance Between Conductors in m:  "); 
       break;
    
    % Asymmetric
    elseif (spacing == 2)
        D_12 = input("Please Enter a Value for the Distance Between Conductors One and Two in m:  ");
        D_23 = input("Please Enter a Value for the Distance Between Conductors Two and Three in m:  ");
        D_13 = input("Please Enter a Value for the Distance Between Conductors One and Three in m:  ");
        % Calculating GMD
        GMD = nthroot((D_12 * D_23 * D_13), 3);
        break;
    % Idiotproofing Spacing
    else
        fprintf('Invalid Input! \nChoose Either 1 or 2 ONLY.\n');
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
    fprintf('\nBased on the Line Length Entered\n The Transmission line is Short.\n');
    
    % Short Line Parameters are Used
    A = 1;
    B = Z;
    C = 0;
    D = 1; 
    variables_disp(R_AC, 0, L_phase, XL, 0,0 , Z, A, B, C, D)
elseif (ConLength <= 250)  
    
    % Identifying Transmission Line Model Used as Medium
    state = 81;
    fprintf('\nBased on the Line Length Entered\n The Transmission line is Medium.\n');
        
    % Medium Line Parameters are Used Based on the Circuit Model
    model = line_model();
        
    % Idiotproofing Model
    while (1)
    
      if (model == 1)
          % Medium Line Parameters for PI Model
          A = 1 + (Y * Z / 2);
          B = Z;
          C = Y * (1 + (Y * Z / 4));
          D = 1 + ((Y * Z) / 2);
          %Printing the Calculated Variables 
          variables_disp(R_AC, C_phase, L_phase, XL, XC, Y, Z, A, B, C, D);
          break;
                
      elseif (model == 2)
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
    fprintf('\nBased on the Line Length Entered\n The Transmission line is Long.\n');
    fprintf('This Program is not Designed to Calculate Long Transmission Line Parameters.\nTerminated ..\n\n');
    
end

%%%%%%%%%%%%%%%%% ABCD Parameters %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 3: Transmission Line Performance

if (state ~= 251)
    % Choosing Which case to Output Based on the User's Choice
    decider = case_decider();
    
    % Prologue : Prompting the User to Enter the Receiving-end Voltage
    Vr = input('Please Enter a Value for The Receiving-End Phase Voltage in v:  ');
    while (1)
        if (decider == 1)
            % Case I
            task3_case1(A, B, C, D, Vr, j);
            break;
                
        elseif (decider == 2)
            % Case II
            task3_case2(A, B, C, D, Vr, j);
            break;
        else
            fprintf('Invalid Input! \nChoose either 1 or 2 ONLY.\n');
            decider = case_decider();
        end
    end
    goodbye_message();
end

%%%%%%%%%%% Transmission Line Performance %%%%%%%%%%%