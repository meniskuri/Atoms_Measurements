clc
clear all
close all

%% load data
% datasheet SM impedance
CM_181           = load('CM_181U_15A_REV_IMP.dat'); % magn; f - kHz; Z - kohm


% CMC
MnZn_Core_SM_CMC = load('SM_181U_15A_REV_IMP_Rea_Imag_V3.dat'); % V3




%% plots
% real
fig1 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig1,'position',[360   514   921   408])
plot(MnZn_Core_SM_CMC(:,1),MnZn_Core_SM_CMC(:,2),'r','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([10e3 110e6])
xlabel('Frequency [Hz]')
ylabel('real [\Omega]')
legend('SM Z real (CMC)')
title('SM Z (Magn)  CMC V3; (Turns = 4) mu=5700; f = 400kHz')
grid on

% imag
fig2 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig1,'position',[360   514   921   408])
plot(MnZn_Core_SM_CMC(:,1),abs(MnZn_Core_SM_CMC(:,3)),'r','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([10e3 110e6])
xlabel('Frequency [Hz]')
ylabel('abs imag [\Omega]')
legend('SM abs Z imag (CMC)')
title('SM Z (Magn)  CMC V3; (Turns = 4) mu=5700; f = 400kHz')
grid on

% magn
fig3 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig1,'position',[360   514   921   408])
plot(1e3.*CM_181(:,1),1e3.*CM_181(:,2),'g--','LineWidth',2)
plot(MnZn_Core_SM_CMC(:,1),sqrt((MnZn_Core_SM_CMC(:,2)).^2 + (MnZn_Core_SM_CMC(:,3)).^2),'r','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
% xlim([10e3 110e6])
xlabel('Frequency [Hz]')
ylabel('magn [\Omega]')
title('SM Z (Magn)  CMC V3; (Turns = 4) mu=5700; f = 400kHz')
grid on


% CM_181_for_Save = [1e3.*CM_181(:,1),1e3.*CM_181(:,2)];
% 
% save('CM_181U_15A_REV_IMP_Corrected.dat','CM_181_for_Save','-ascii')


%% L calculation

n        = 0;
L_freq   = 10e3;
sazebari = 0;

for n = 1:1:length(MnZn_Core_SM_CMC)
    
    sazebari(n,1) = MnZn_Core_SM_CMC(n,1)-L_freq;
    
end


[M,I] = min(abs(sazebari));

disp('min index')
I

disp('L value 10 KHz in mH (CMC simulation; CM?181U?15A REV.B Version1)')
L = ((MnZn_Core_SM_CMC(I,3))/(2*pi*MnZn_Core_SM_CMC(I,1)))*1e3

% L plot 

fig3 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig1,'position',[360   514   921   408])
plot(MnZn_Core_SM_CMC(:,1),((MnZn_Core_SM_CMC(:,3))./(2*pi*MnZn_Core_SM_CMC(:,1))).*1e6,'r','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([10e3 110e6])
xlabel('Frequency [Hz]')
ylabel('inductance [uH]')
legend('inductance (CMC model)')
title('SM Z (Magn)  CMC V3; (Turns = 4) mu=5700; f = 400kHz')
grid on

% L_model_V3 = [MnZn_Core_SM_CMC(:,1),((MnZn_Core_SM_CMC(:,3))./(2*pi*MnZn_Core_SM_CMC(:,1))).*1e6];
% 
% save('L_uH_Model_V3.dat','L_model_V3','-ascii')
