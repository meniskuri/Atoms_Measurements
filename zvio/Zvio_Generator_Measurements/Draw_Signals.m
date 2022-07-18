clear all
close all
clc
%% freq signal

Development_FFT = load('signal_1khz_50khz_FFT.dat');



% 
% fig3 = figure;
% % set(fig3,'position',[360   400   921   408])
% hold on
% set(gca,'fontsize',12,'Xscale','lin')
% plot(Development_FFT(:,1),40+Development_FFT(:,2),'r','LineWidth',2)
% % set(gca,'YTick',[-300 -280 -260 -240 -220 -200 -180]);
% % set(gca,'YTickLabel',['-300';'-280';'-260';'-240';'-220';'-200';'-180'])
% set(gca,'XTick',[1e3 10e3 20e3 30e3 40e3 50e3]);
% set(gca,'XTickLabel',['1kHz ';'10kHz';'20kHz';'30kHz';'40kHz';'50MHz'])
% % xlim([150e3 30e6])
% % ylim([-300 -170])
% xlabel('Frequency')
% ylabel('Power [dBm]')
% legend('')
% title('')
% grid on
% box on
% 
% fig4 = figure;
% hold on
% set(gca,'fontsize',12,'Xscale','log')
% plot(Development_FFT(:,1),10.^((40+Development_FFT(:,2)+107-120)/20),'b','LineWidth',2)
% 
% % set(gca,'YTick',[-300 -280 -260 -240 -220 -200 -180]);
% % set(gca,'YTickLabel',['-300';'-280';'-260';'-240';'-220';'-200';'-180'])
% set(gca,'XTick',[1e3 10e3 20e3 30e3 40e3 50e3]);
% set(gca,'XTickLabel',['1kHz ';'10kHz';'20kHz';'30kHz';'40kHz';'50MHz'])
% % xlim([150e3 30e6])
% % ylim([-300 -170])
% xlabel('Frequency')
% ylabel('Voltage [V]')
% legend('')
% title('')
% grid on
% box on



%% time si9gnal
Lecroy_1  = load('C1mix00000.dat');
Lecroy_2  = load('C1mix00001.dat');
Lecroy_3  = load('C1mix00002.dat');
Lecroy_4  = load('C1mix00003.dat');
Lecroy_5  = load('C1mix00004.dat');
Lecroy_6  = load('C1mix00005.dat');
Lecroy_7  = load('C1mix00006.dat');
Lecroy_8  = load('C1mix00007.dat');
Lecroy_9  = load('C1mix00008.dat');
Lecroy_10 = load('C1mix00009.dat');

N = 0;
Lecroy_avarage = 0;

for N = 1:1:length(Lecroy_1(:,1))
    
    Lecroy_avarage(N,1) = Lecroy_1(N,1);
    Lecroy_avarage(N,2) = (Lecroy_1(N,2) + Lecroy_2(N,2) + Lecroy_3(N,2) + Lecroy_4(N,2)+ Lecroy_5(N,2)+ Lecroy_6(N,2)+ Lecroy_7(N,2)+ Lecroy_8(N,2)+ Lecroy_9(N,2)+ Lecroy_10(N,2))/10;
    
end


save('Lecroy_avarage.dat','Lecroy_avarage','-ascii')

% fig4 = figure;
% hold on
% set(gca,'fontsize',12,'Xscale','lin')
% plot(Lecroy_1(:,1),Lecroy_1(:,2),'b','LineWidth',2)
% 
% % set(gca,'YTick',[-300 -280 -260 -240 -220 -200 -180]);
% % set(gca,'YTickLabel',['-300';'-280';'-260';'-240';'-220';'-200';'-180'])
% set(gca,'XTick',[1e3 10e3 20e3 30e3 40e3 50e3]);
% set(gca,'XTickLabel',['1kHz ';'10kHz';'20kHz';'30kHz';'40kHz';'50MHz'])
% % xlim([150e3 30e6])
% % ylim([-300 -170])
% xlabel('')
% ylabel('')
% legend('')
% title('')
% grid on
% box on


