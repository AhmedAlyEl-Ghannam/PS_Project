A = 1+i;
B = 3-i;
C = 7;
D = 9+2.5i;
Vr_fl = 220;
Pr_fl = 100e3;
Ir_fl = (Pr_fl/(2.4*Vr_fl))*exp(i*acos(0.8));
Vs = A*Vr_fl + B*Ir_fl;
Pr = linspace(0, 100e3, 100);


Vr = zeros(1, length(Pr));
for j = 1:1:length(Pr)
    r = roots([A -Vs B*(Pr(j)*exp(i*acos(0.8)))/2.4]);
    disp(r');
    r_r = real(r);
    r_i = abs(imag(r));
    if r_r(1) > 0 && r_i(1) < r_i(2)
        Vr(j) = r_r(1);
    elseif r_r(2) > 0 && r_i(2) < r_i(1)
        Vr(j) = r_r(2);
    endif
endfor
%disp(Vr);
%disp(roots([A -Vs B*(Pr(j)*exp(i*acos(0.8)))/2.4]))
