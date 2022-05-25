%task 3 case 2
Vr_line = input("Vr = ");
Vr = Vr_line/sqrt(3).*exp(i*0);

k=1;
while k
        model_kind=input('\nEnter (1) for case one. \nEnter (2) for case two. \n');
        if((model_kind == 1) || (model_kind == 2))
                k=0;
        else
        fprintf("\ninvalid input, please enter it again");
        end
    end
%case 1

if (model_kind==1)
    pf1=0.8;
    pr=[];
    Ir=[];Vs=[];Is=[];Ps=[];efficiency=[];Volt_Reg=[];
    for (n=1:101)
           pr(n) = -1e3+1e3*n; 
           Ir(n)=(pr(n)./(3*Vr*pf1)).*exp(i-acos(pf1));
           Vs(n)=A.*Vr+B.*Ir(n);
           Is(n)=C.*Vr+D.*Ir(n);
           Ps(n)=3*abs(Vs(n)).*abs(Is(n)).*cos(angle(Vs(n))-angle(Is(n)));
           efficiency(n) = (pr(n)./Ps(n))*100;
           Volt_Reg(n) = (((abs(Vs(n))./abs(A))-abs(Vr))./abs(Vr))*100;
    end

        figure;
        subplot(1,2,1);
        plot( pr,efficiency);
        xlabel('Active power');
        ylabel('Efficiency');
        grid on;
        subplot(1,2,2);
        plot( pr,Volt_Reg);
        xlabel('Active power');
        ylabel('Voltage regulation');
        grid on;

    %case 2
    elseif(model_kind ==2)
    Pr=100000;
    pf=[];
    Ir1=[];Vs1=[];Is1=[];Ps1=[];efficiency1=[];Volt_Reg1=[];
    Ir2=[];Vs2=[];Is2=[];Ps2=[];efficiency2=[];Volt_Reg2 =[];
    %lead Pf

        for (n=1:71)
           pf(n) = 0.29+0.01*n; 
           Ir1(n)=(Pr./(3*Vr.*pf(n))).*exp(i*acos(pf(n)));
           Vs1(n)=A.*Vr+B.*Ir1(n);
           Is1(n)=C.*Vr+D.*Ir1(n);
           Ps1(n)=3*abs(Vs1(n)).*abs(Is1(n)).*cos(angle(Vs1(n))-angle(Is1(n)));
           efficiency1(n) = (Pr./Ps1(n))*100;
           Volt_Reg1(n) = (((abs(Vs1(n))./abs(A))-abs(Vr))./abs(Vr))*100;
        end

    %lag Pf
    for (n=1:71)
           pf(n) = 0.29+0.01*n; 
           Ir2(n)=Pr./(3*Vr.pf(n)).*exp(i-acos(pf(n)));
           Vs2(n)=A.*Vr+B.*Ir2(n);
           Is2(n)=C.*Vr+D.*Ir2(n);
           Ps2(n)=3*abs(Vs2(n)).*abs(Is2(n)).*cos(angle(Vs2(n))-angle(Is2(n)));
           efficiency2(n) = (Pr./Ps2(n))*100;
           Volt_Reg2(n) = (((abs(Vs2(n))./abs(A))-abs(Vr))./abs(Vr))*100;
    end

        %figure;
        figure;
        subplot(2,2,1);
        plot(pf,Volt_Reg1);
        xlabel('Leading power factor');
        ylabel('Voltage regulation');
        grid on;
        subplot(2,2,2);
        plot(pf,Volt_Reg2);
        xlabel('Lagging power factor');
        ylabel('Voltage regulation');
        grid on;
        subplot(2,2,3);
        plot(pf,efficiency1);
        xlabel('Leading power factor');
        ylabel('Efficiency');
        grid on;
        subplot(2,2,4);
        plot(pf,efficiency2);
        xlabel('Lagging power factor');
        ylabel('Efficiency');
        grid on;
end