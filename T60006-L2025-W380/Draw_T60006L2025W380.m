close all
clear all

meas_without  = load('Fixture_without_ferrite40_110mhz.dat');

freqs         = meas_without(:,1);
Mu_0          = 4*pi*1e-7;

meas_vac_W380 = load('W380_25X16X10_VAC_N1.dat');

Zm = meas_vac_W380(:,2)+1j*meas_vac_W380(:,3);
Zsm = meas_without(:,2)+1j*meas_without(:,3) ;
c   = 25e-3;
b   = 16e-3;
h   = 10e-3;
Mu  = (((Zm - Zsm)*2*pi) ./ (1i*2*pi*freqs*Mu_0*h*log(c/b))) + 1;
Mu_Data = [freqs real(Mu) -imag(Mu)];

% eps data

Eps_r   = ones(length(freqs),1);
Eps_i   = zeros(length(freqs),1);

% Mu calculation

Mu        = (((Zm - Zsm)*2*pi) ./ (j*2*pi*freqs*Mu_0*h*log(c/b))) + 1;
Mu_Data   = [freqs real(Mu) -imag(Mu)];

fig3 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(fig3,'position',[360   200   918   552])
plot(Mu_Data(:,1),Mu_Data(:,2),'r','LineWidth',2)
plot(Mu_Data(:,1),Mu_Data(:,3),'k','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([40 110e6])
title('VAC W380')
xlabel('Frequency')
ylabel('Permeability [ \mu ]')
legend('Real','Imag' )
grid on


save('VAC_T60006L2025W380_Mu_real_imag.dat','Mu_Data','-ascii')

% 
% % [x,y] = ginput % davitas mivce 
% 
% % save calculation files
% 
% chek_matrix_i     = 0;
% value_i           = 0;
% index_i           = 0;
% n                 = 0;
% k                 = 0;
% p                 = 0;
% cut_f             = [x];
% 
% for n=1:1:length(freqs(:,1))
%     
%     chek_matrix_i(n,1) = abs(freqs(n,1) - cut_f(1));
%     
% end
% 
% [value_i,index_i]   = min(chek_matrix_i);
% 
% for k=1:1:length(freqs(:,1))
%     
%     if k<index_i
%         
%         mu_imag(k) = y;
%         
%     else
%         
%         mu_imag(k) = -imag(Mu(k));
%         
%     end
% end
% 
% count = 0;
% 
% 
% for p=1:1:length(freqs(:,1))
%     
%     if p < 50 % tavidan tu uaryofitia realuri nawili (shearchiet sachiro indexi)
%         
%         if abs(real(Mu(p)))>0
%             count = count + 1;
%             mu_real(p) = real(Mu(p));
%             
%         else
%             
%             mu_real(p) = real(Mu(count));
%             
%         end
%         
%     else
%         
%         if real(Mu(p))>0
%             count = count + 1;
%             mu_real(p) = real(Mu(p));
%             
%         else
%             
%             mu_real(p) = real(Mu(count));
%             
%         end
%         
%         
%     end
% end
% 
% Mu_Data   = [freqs Eps_r Eps_i mu_real' mu_imag'];
% 
% fig3 = figure;
% hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig3,'position',[360   200   918   552])
% plot(Mu_Data(:,1),Mu_Data(:,4),'r','LineWidth',2)
% plot(Mu_Data(:,1),Mu_Data(:,5),'k','LineWidth',2)
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
% xlim([40 110e6])
% title('VAC W380')
% xlabel('Frequency')
% ylabel('Permeability [ \mu ]')
% legend('Real','Imag' )
% grid on
% 
% [x_R,y_R]     = ginput
% p             = 0;
% n             = 0;
% chek_matrix_r = 0;
% cut_f         = x_R;
% value_r       = 0;
% index_r       = 0;
% k             = 0;
% 
% for n=1:1:length(freqs(:,1))
%     
%     chek_matrix_r(n,1) = abs(freqs(n,1) - cut_f(1));
%     
% end
% 
% [value_r,index_r]   = min(chek_matrix_r);
% 
% 
% for k=1:1:length(freqs(:,1))
%     
%     if k<index_r
%         
%         mu_real_1(k) = y_R;
%         
%     else
%         
%         mu_real_1(k) = mu_real(k);
%         
%     end
% end
% 
% 
% Mu_Data   = [freqs Eps_r Eps_i mu_real_1' mu_imag'];
% 
% fig3 = figure;
% hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig3,'position',[360   200   918   552])
% plot(Mu_Data(:,1),Mu_Data(:,4),'r','LineWidth',2)
% plot(Mu_Data(:,1),Mu_Data(:,5),'k','LineWidth',2)
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
% xlim([40 110e6])
% title('VAC W380')
% xlabel('Frequency')
% ylabel('Permeability [ \mu ]')
% legend('Real','Imag' )
% grid on

% save('VAC_T60006L2025W380_Mu_real_imag_eps_1_0.dat','Mu_Data','-ascii')

%% ========================================================================
% fig1 = figure; 
% hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig1,'position',[360   514   921   408])
% plot(freqs,Mu_Data(:,2),'b','LineWidth',2)
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
% xlim([40 110e6])
% xlabel('Frequency [Hz]')
% ylabel('Measured permeability Real [ \mu ]')
% legend('VAC W380')
% grid on 
% 
% fig2 = figure; 
% hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig2,'position',[360   514   921   408])
% plot(freqs,(Mu_Data(:,3)),'b','LineWidth',2)
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
% xlim([40 110e6])
% xlabel('Frequency [Hz]')
% ylabel('Measured permeability Imag [ \mu ]')
% legend('VAC W380')
% grid on 
% 
% fig3 = figure; 
% hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig3,'position',[360   514   921   408])
% plot(freqs,Mu_Data(:,2),'r','LineWidth',2)
% plot(freqs,(Mu_Data(:,3)),'b','LineWidth',2)
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
% xlim([40 110e6])
% xlabel('Frequency [Hz]')
% legend('Measured permeability Real [ \mu ]','Measured permeability Imag [ \mu ]')
% ylabel('VAC W380')
% grid on 
% 
