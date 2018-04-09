data1=load('87.txt');
samth1=data1(:,1);
Epoch1=data1(:,2);
sec1=data1(:,3);
CESR1=data1(:,4);
Imon1=data1(:,5);
Idet1=data1(:,6);
Y1=(Idet1./Imon1);

data2=load('85.txt');
samth2=data2(:,1);
Epoch2=data2(:,2);
sec2=data2(:,3);
CESR2=data2(:,4);
Imon2=data2(:,5);
Idet2=data2(:,6);
Y2=(Idet2./Imon2);

data3=load('86.txt');
samth3=data3(:,1);
Epoch3=data3(:,2);
sec3=data3(:,3);
CESR3=data3(:,4);
Imon3=data3(:,5);
Idet3=data3(:,6);
Y3=(Idet3./Imon3);

nmlambda=0.1164;

X1=samth1;
X2=samth2;
X3=samth3;

plot(X1,Y1,'r+:')
hold on
plot(X2,Y2,'b*-')
hold on
plot(X3,Y3,'g.--')

xlabel('theta(degree)')
ylabel('Reflectivity(I_R/I_0)')
title('thin ISM9-1 samples with PMMA arm length of 1:1:2.2')
legend('87(as-prepared)','85(TAed)','86(SVAed)')

hold off

%%
%select dat11,data22 and data33 by brush tool in the figure from the very
%linear section of the reflectivity curves

Y11=data11(:,2);
Y22=data22(:,2);
Y33=data33(:,2);
X11=data11(:,1);
X22=data22(:,1);
X33=data33(:,1);

p1=polyfit(X11,Y11,1);
m1=p1(:,1);
b1=p1(:,2);
p2=polyfit(X22,Y22,1);
m2=p2(:,1);
b2=p2(:,2);
p3=polyfit(X33,Y33,1);
m3=p3(:,1);
b3=p3(:,2);

Y111=polyval(p1,X11);
Y222=polyval(p2,X22);
Y333=polyval(p3,X33);

figure

plot(X1,Y1,'r+:')
hold on
plot(X2,Y2,'b*-')
hold on
plot(X3,Y3,'g.--')

hold on

plot(X11,Y111,'lineWidth',2,'Color','k')
hold on
plot(X22,Y222,'lineWidth',2,'Color','k')
hold on
plot(X33,Y333,'lineWidth',2,'Color','k')

xlabel('theta(degree)')
ylabel('Reflectivity(I_R/I_0)')
title('thin ISM9-1 samples with PMMA arm length of 1:1:2.2(before alignning)')
legend('87(as-prepared)','85(TAed)','86(SVAed)','corresponding linear fits')
hold off

%%

samth11=samth1+(b1/m1);
samth22=samth2+(b2/m2);
samth33=samth3+(b3/m3);

figure
plot(samth11,Y1,'r+:')
hold on
plot(samth22,Y2,'b*-')
hold on
plot(samth33,Y3,'g.--')

xlabel('theta(degree)')
ylabel('Reflectivity(I_R/I_0)')
title('thin ISM9-1 samples with PMMA arm length of 1:1:2.2(after aligning)')
legend('87(as-prepared)','85(TAed)','86(SVAed)')
hold off


%%

X1111=(4*pi*sind(samth11))./nmlambda;
X2222=(4*pi*sind(samth22))./nmlambda;
X3333=(4*pi*sind(samth33))./nmlambda;

figure
semilogy(X1111,Y1,'r+:')
hold on
semilogy(X2222,Y2,'b*-')
hold on
semilogy(X3333,Y3,'g.--')

xlabel('q_z(Å^{-1})')
ylabel('Reflectivity(I_R/I_0)')
title('Aligned reflectivity curves of thin ISM9-1 samples with PMMA arm length of 1:1:2.2')
legend('87(as-prepared)','85(TAed)','86(SVAed)')

% From Elements xray book
r0=2.82e-5;        % Thompson scattering length in Å
rho=4.678;         % electron density in electrons/Angs^3
b=0.0115;          % parameter b_mu
Delta=10.*2.*pi;         % thickness of film in Angs
sigma=0.0;         % surface roughness in Angs
 
Qc=4*sqrt(pi*rho*r0);
Q=0:0.001:1;
q=Q/Qc;
Qp=Qc*sqrt(q.^2-1+2*sqrt(-1)*b); 

rQ=(Q-Qp)./(Q+Qp);
r_slab=rQ.*(1-exp(i*Qp*Delta))./(1-rQ.^2.*exp(i*Qp*Delta));
r_slab=r_slab.*exp(-Q.^2*sigma^2/2);
line(Q,r_slab.*conj(r_slab),'LineWidth',1.0,'Color','b');

hold off












