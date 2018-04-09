function kiessig
%
% MATLAB function from:
% "Elements of Modern X-ray Physics" by Jens Als-Nielsen and Des McMorrow
%
% Calculates: Reflectivity from a thin film of tungsten

axes('position',[0.2 0.2 0.6 0.6]);

r0=2.82e-5;        % Thompson scattering length in Angs
rho=4.678;         % electron density in electrons/Angs^3
b=0.0409;          % parameter b_mu
Delta=10*2*pi;     % thickness of film in Angs
sigma=0.0;         % surface roughness in Angs

Qc=4*sqrt(pi*rho*r0);

Q=0:0.001:1;
q=Q/Qc;
Qp=Qc*sqrt(q.^2-1+2*sqrt(-1)*b); 

rQ=(Q-Qp)./(Q+Qp);
r_slab=rQ.*(1-exp(i*Qp*Delta))./(1-rQ.^2.*exp(i*Qp*Delta));
r_slab=r_slab.*exp(-Q.^2*sigma^2/2);
line(Q,r_slab.*conj(r_slab),'LineWidth',1.0,'Color','b');

axis([0.0 1.0 1e-10 1.5]); grid on
set(gca,'FontName','Times','FontSize',16,'box','on')
set(gca,'Ytick',[1e-10 1e-8 1e-6 1e-4 1e-2 1e0],'yscale','log')
xlabel('Wavevector transfer Q (Å^{-1})')
ylabel('|{\it r}_{slab}|^2','position',[-0.175 1e-5 0])