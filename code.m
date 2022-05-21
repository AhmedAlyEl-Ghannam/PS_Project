%% Task 1: Transmission Line Parameters
%Write a MATLAB script file (M file) to calculate first the Resistance, Inductance and
%Capacitance per phase of a 3 phase Transmission Line system.
%The user must be first asked to input the conductor resistivity, conductor length, and
%conductor diameter. Next, the user will be asked to choose whether the transmission
%system is symmetrical or unsymmetrical. For symmetrical spacing, only one distance will
%be given, but for unsymmetrical spacing, the distance between phases will be given. Next
%% Task 2: ABCD Parameters
%After calculating R, L and C parameters, the user will calculate the ABCD constants based on the
%line length entered in Task 1. For a medium line length, the user will be asked whether the model
%is ? or T. Finally,

%% Task 1: Transmission Line Parameters
% setup
clear;
clc;

% variables
% Initial value of variables
Resistance=0; Inductance=0; Capacitance=0;
rho=0; conductor_length=0; conductor_diameter=0;

Symmetrical=0; Unsymmetrical=0;
spacing_between_conductors=0; A=0;B=0;C=0;D=0;

e=exp(1); %model=0; %phase=0; 


%Unified Electrical Grid Properties
freq=50; %Frequency = 50 Hz


%start

fprintf('Welcome to the Transmission Line Wizard >> \n\n');

rho = input('Enter the <Conductor Resistivity (Rho)> (in ohm/m) = ');
conductor_length = input('Enter the <Conductor Length> (in Kilometers) = ');
conductor_diameter = input('Enter the <Conductor Cross-sectional Area> (in m^2) = ');

choice=0;
while choice~=1 && choice~=2
    
    fprintf('\nPlease Choose the Type of the Transmission System >>\n  1)Symmetrical \n  2)Unsymmetrical \n\n');
    choice = input('Your Choice: ');
    
    switch choice
            case 1 %Symmetrical
                choice=1;
                Symmetrical=1;
                spacing_between_conductors = input('\nPlease Enter the value of the spacing between conductors (in meter): ');
                D1= spacing_between_conductors;
                D2= spacing_between_conductors;
                D3= spacing_between_conductors;
                
            case 2 %Unsymmetrical
                choice=2;
                Unsymmetrical=1;
                D1 = input('\nPlease Enter the value of the spacing between Phase A and B: ');
                D2 = input('\nPlease Enter the value of the spacing between Phase B and C: ');
                D3 = input('\nPlease Enter the value of the spacing between Phase C and A: ');
                
                if D1+D2<D3 || D2+D3<D1 || D1+D3<D2
                    fprintf('\n\nError: Values of the distances between conductors must follow the Triangle Inequality Theorem.\n');
                    continue;
                end

        otherwise %Error Catching
            if choice~=1 || choice~=2
                fprintf('Error: Choose either 1 or 2 ONLY.\n');
                continue;
            else
                break;
            end
            
    end

end

conductor_radius = conductor_diameter/2;
cross_sectional_area = pi*(conductor_radius^2);

%ALL calculations are PER PHASE
%Resistance Calculations
Rdc = (rho*conductor_length)/(cross_sectional_area);
factor=1.1; %Skin-Effect Factor
Rac = factor*Rdc;
Resistance=Rac; 

%fprintf('\n');
fprintf('\nSkin-Effect Factor = %d \n', factor);
fprintf('DC Resistance Per Phase = %d Ohm/m \n\n', Rdc);
fprintf('AC Resistance Per Phase = %d Ohm/m \n', Rac);


%Inductance Calculations
mu = 4*pi*10^(-7); %Permeability of free space
GMR = conductor_radius*exp(-0.25);

if Symmetrical == 1
    D1= spacing_between_conductors;
    D2= spacing_between_conductors;
    D3= spacing_between_conductors;
end
GMD = nthroot((D1*D2*D3),3);

L_phase= (mu/2*pi)* log(GMD/GMR);
XL=2*pi*freq*L_phase;
Inductance=L_phase; 

fprintf('\nInductance Per Phase = %d Henry/m \n', L_phase);
fprintf('Inductive Reactance Per Phase = %d Ohm/m \n\n', XL);



%Capacitance Calculations
epsilon= 8.85*10^(-12);

%GMD = nthroot((D1*D2*D3),3); %Same GMD

C_phase= (2*pi*epsilon)/(log(GMD/conductor_radius));
XC=1/(2*pi*freq*C_phase);
Capacitance=C_phase;

fprintf('\nCapacitance Per Phase = %d Farad/m \n', C_phase);
fprintf('Capacitive Reactance Per Phase = %d Ohm/m \n\n', XC);

fprintf('Calculating A,B,C,D Parameters .. \n');


%% Task 2: ABCD Parameters

model=0;
if conductor_length < 80
    state='Short';
    fprintf('Based on the line length entered. The Trasmission line is %s. \n',state);
    
elseif (80 <= conductor_length) && (conductor_length <= 250)
    state='Medium';
    fprintf('Based on the line length entered. The Trasmission line is %s. \n',state);
    
    
    while model~=1 && model~=2
    fprintf('Please select the model type >>\n  1)Y \n  2)Pi \n\n');
    model = input('Your Choice: ');
        switch model
                case 1 %Y
                    model=1;
                case 2 %Pi
                    model=2;
        end
    end
    
else
    state='Long';
    fprintf('\nBased on the line length entered. The Trasmission line is %s. \n',state);
    fprintf('This Program is not able to calculate Long Transmission Parameters.\nTerminated ..\n');
    
end


Z = Rac+(XL)*1i; %Total Impedance for short
    
A_short = 1;
B_short = Z;
C_short = 0;
D_short = 1;

Parameters_short = [A_short B_short;C_short D_short];


%fprintf('The ABCD Parameters are: %d',Parameters_short);

%A_medium = ;
%B_medium = ;
%C_medium = ;
%D_medium = ;

%Parameters_medium = [A_medium B_medium; C_medium D_medium];








