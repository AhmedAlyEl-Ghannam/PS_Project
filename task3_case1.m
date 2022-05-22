% Task 3 Case 1
function eff = task3_case1(A, B, C, D)
    % Full Load conditions
    Vr_fl = 20000;% arbitrary value for testing
    Pr_fl = 100e3;
    Ir_fl = (Pr_fl/(2.4*Vr_fl))*exp(i*acos(0.8));
    Vs = A*Vr_fl + B*Ir_fl;

    %{
    Ir = (Pr/2.4*Vr)*exp(i*acos(0.8))   (1)
    Vs = A*Vr + B*Ir                    (2)
    sub from 1 in 2
    Vs = A*Vr + B*(Pr*exp(i*acos(0.8)))/2.4*Vr
    A*Vr^2 - Vs*Vr + B*(Pr*exp(i*acos(0.8)))/2.4*Vr = 0)
    %}

    Pr = 0:0.5:100;
    Pr = Pr.*1000;
    Vr = zeros(1, length(Pr));
    for j = 1:1:length(Pr)
        r = roots([A -Vs B*(Pr(j)*exp(i*acos(0.8)))/2.4]);
        r_r = real(r);
        r_i = abs(imag(r));
        % we need to get the root that is closest to being real because matlab accuracy is not 100%
        if r_r(1) > 0 && r_i(1) < r_i(2)
            Vr(j) = r_r(1);
        elseif r_r(2) > 0 && r_i(2) < r_i(1)
            Vr(j) = r_r(2);
        endif
    endfor

    % Pr = 3*|Vr|*|Ir|*0.8 = 2.4*|Vr|*|Ir|
    Ir = (Pr./(2.4*Vr))*exp(i*acos(0.8));
    Vs = A.*Vr + B.*Ir;
    Is = C.*Vr + D.*Ir;
    Ps = 3.*abs(Vs).*abs(Is).*cos(angle(Vs)-angle(Is));

    eff = Pr./Ps;


    figure
    subplot(121)
    plot(Pr, eff); title('Efficeincy'); grid on;

    subplot(122)
    plot(Pr,VRegulation); title('Voltage Regulation'); grid on;

endfunction
