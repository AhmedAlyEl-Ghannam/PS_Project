% Constants
A = -5.25+12.5i;
B = 5+2.5i;
C = -31.25-10.625i;
D = A;
Pr = 100e3/3;

% at UPF
Vr_upf = 1000/3;
Ir_upf = 100;

% calculate Vs which is constant regardless of pf
Vs = A*Vr_upf + B*Ir_upf;

% Start general calculations
pf = 0.3:0.001:1;
Vr = zeros(1, length(pf));
Ir = Vr;
Vr1 = Vr;
Vr2 = Vr;
Ir1 = Vr;
Ir2 = Vr;

% Vs = A*Vr + B*Pr/(3*Vr*pf)*exp(i*acos(pf))
% Vs*Vr = A*Vr^2 + B*Pr/(3*pf)*exp(i*acos(pf))
for j = 1:length(pf)
    x = B*((Pr/(pf(j)))*exp(i*acos(pf(j))));
    Vr(j) = real(roots([A -Vs x])(1));
    Ir(j) = (Pr/(Vr(j)*pf(j)))* exp(i*acos(pf(j)));


endfor

% Calculate Is
Is = C*Vr + D*Ir;
Ps = real(Vs.*conj(Is));
eff = Pr./Ps;

figure
plot(pf, eff)

