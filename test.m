clear all

% Constants
A = -5.25+12.5i;
B = 5+2.5i;
C = -31.25-10.625i;
D = A;

%A=0.9706+0.00269i;
%B=6.39+69.998i;
%C=-1.155e-6+1i*(8.277e-4);
%D=0.9706+0.00269i

Pr = 100e3/3;
pf = 0.3:0.01:1;
Ir = zeros(1, length(pf));
Vs = zeros(1, length(pf));
Is = zeros(1, length(pf));

% Get Vr from user
Vr = 1000/3; %input("Enter Vr: ");

% Calculate Ir
Ir = (Pr./(Vr.*pf)) .* exp(i.*acos(pf));

% Calculate sending end values
Vs = A*Vr + B.*Ir;
Is = C*Vr + D.*Ir;
Ss = Vs.*conj(Is);
Ps = real(Ss);

% Calculating Output
eff = Pr./Ps;

% VR =((vnl-vfl)/vfl)*100
Vrnl=Vs./A;
Vrfl = Vr;
VR = (Vrnl - Vrfl)./Vrfl;

% Test values
figure
subplot(121)
plot(pf, eff)
grid on
title("Efficiency vs pf")

subplot(122)
plot(pf, VR)
grid on
title("Voltage Regulation vs pf")


