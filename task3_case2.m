% Task 3 case 2
function task3_case2(A, B, C, D, Vr_curr, Ir_curr)
    Vs = A*Vr_curr + B*Ir_curr
    %Vs = 20e3; % Constant
    Pr = 100e3; % power recieved constant
    pfr = 0.3:0.01:1; % power factor recieving

    % Pr = 3*Vr*|Ir|*pf => Ir = 100e3*exp(i*acos(pf)/(3*Vr*pf)  (1)
    % Vs = A*Vr + B*Ir                                          (2)
    % Substitute from 1 in 2 and rearrange
    Vr = ones(1,length(pfr));
    Ir = ones(1,length(pfr));
    % Compute Vr and Ir
    for j = 1:1:length(pfr)
        x = B*(Pr/3*pfr(j))*exp(i*acos(pfr(j)));
        r = roots([A -Vs x]);
        r_r = real(r);
        r_i = abs(imag(r));
        % we need to get the root that is closest to being real because matlab accuracy is not 100%
        if abs(r(1)) > abs(r(2))%r_i(1) < r_i(2) %r_r(1) > 0 &&
            Vr(j) = real(r(1));
        elseif abs(r(2)) > abs(r(1)) %r_i(2) < r_i(1) %r_r(2) > 0 &&
            Vr(j) = real(r(2));
        endif
        Ir(j) = Pr*exp(i*acos(pfr(j)))/(3*Vr(j)*pfr(j));
    endfor

    % Compute Is
    Is = C.*Vr + D.*Ir;
    % Compute Power sending
    Ss = 3.*Vs.*conj(Is);
    Ps = real(Ss);
    % Compute efficiency
    eff = Pr./Ps;
    %Vr
figure
plot(pfr, Vr)
title("pfr vs Vr")

figure
plot(pfr, 3.*abs(Vr).*abs(Ir).*pfr)
title("pfr vs Pr")

figure
plot(pfr, eff)
title("pfr vs efficiency")
endfunction
