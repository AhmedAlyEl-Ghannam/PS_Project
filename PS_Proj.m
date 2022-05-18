%% Task_1: Transmission Line Parameters

%% A) Resistance Parameters
% Storing Resistivity
cond_res = input("Enter a Value for the Conductor's Resistivity in Ω.m:  ");

% Storing Length
con_len = input("Enter a Value for the Conductor's Length in m:  ");

% Storing Diameter
con_diam = input("Enter a Value for the Conductor's Diameter in m:  ");

% Calculating Radius
con_rad = (con_diam / 2);

%% B) Inductance and Capacitance Parameters
% Spacing Between Conductors
spacing = read_spacing();

% Idiotproofing Spacing
while (1)
    
    if (spacing == 0)
       break;
    end
    
    if (spacing == 1)
        break;
    end
    disp("Invalid Input! Try Again");
    spacing = read_spacing();
    
end
        
% Symmetric
if (spacing == 1)

    dist = input("Enter a Value for the Distance Between Conductors in m:  ");
    
% Unsymmetric
else
    
    dist_12 = input("Enter a Value for the Distance Between Conductors One and Two in m:  ");
    dist_23 = input("Enter a Value for the Distance Between Conductors Two and Three in m:  ");
    dist_13 = input("Enter a Value for the Distance Between Conductors One and Three in m:  ");
    dist_sys = dist_12 * dist_23 * dist_13;
    dist = nthroot(dist_sym, 3);
end

%% Calculating Resistance

%Calculating Area
area = (pi / 4) * (con_diam * con_diam);

% DC Resistance
R_DC = (cond_res * con_len ) / area;

% AC Resistance
R_AC = 1.1 * R_DC;

%% Calculating Inductance

% Magnetic Permiability
meu = (4 * pi) * 1e-7;

% Geometric Mean Distance
GMD = dist;

% Geometric Mean Radius
GMR = con_rad * exp(-0.25);

% Inductance Per Phase
L_phase = (meu / (2 * pi)) * log(GMD / GMR);

% Inductance
L = L_phase * con_len;

%% Calculating Capacitance

% Electric Permitivity
epsilon = 8.85e-12;

% Capacitance Per Phase
C_phase = (2 * pi * epsilon) / log(dist / con_rad);

% Capacitance
C = C_phase * con_len;
%%%%%%%% End of Transmission Line Parameters %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 2: ABCD Parameters

% Defining sqrt(-1) as j
j = 1i;

% Calculating ω (Assuming f = 50Hz)
f = 50;
omega = 2 * pi * f;

% Calculating Inductive Reactance
XL = (j * omega * L);

% Calculating Capacitive Reactance
XC = 1 / (j * omega * C);

% Calculating Impedence
Z = R_AC + XL;

% Calculating Admittance
Y = (j * omega  * C);

% Determining The Transmission Line Model Based on its Length
if (con_len <= 80)
    % Short Line Parameters are Used
    A_par = 1;
    B_par = Z;
    C_par = 0;
    D_par = 1;
    
else
   
    if (con_len <= 250)
        
        % Medium Line Parameters are Used Based on the Circuit Model
        model = line_model();
        
        % Idiotproofing Model
        while (1)

            if (model == 0)
                break;
            end
            if (model == 1)
                break;
            end
            disp("Invalid Input! Try Again");
            model = line_model();

        end
        
        % Switching Between Models Based on Input
        switch (model)
           
            % Medium Line Parameters for π Model
            case 1
                A_par = 1 + (Y * Z / 2);
                B_par = Z;
                C_par = Y * (1 + (Y * Z / 4));
                D_par = 1 + ((Y * Z) / 2);
                
            % Medium Line Parameters for T Model
            case 2
                A_par = 1 + (Y * Z / 2);
                B_par = Z * (1 + (Y * Z / 4));
                C_par = Y;
                D_par = 1 + (Y * Z / 2);

        end
    
    end
    
end

%%%%%%%%%%%%%%%%% ABCD Parameters %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 3: Transmission Line Performance



%%%%%%%%%%% Transmission Line Performance %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Functions Used. Put at The End of Program

% Function that Reads Spacing Between Conductors
function spac = read_spacing()
    spac = input("Enter 1 for Symmetric Spacing and 0 for Unsymmetric Spacing:  "); 
end

%Function that Reads the User's Choice between T and π Models
function mod = line_model()
    mod = input("Enter 1 for π Model and 0 for T Model:  "); 
end












