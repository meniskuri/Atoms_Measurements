clc
clear all
close all

%% load data
% datasheet SM impedance
CM_181           = load('CM_181U_15A_REV_IMP.dat'); % magn; f - kHz; Z - kohm

% circuit
MnZn_Core_SM     = load('SM_74482210002_MNZN_Circuit_SM.dat');

% CMC
MnZn_Core_SM_CMC = load('SM_74482210002_MNZN_CMC_SM.dat'); % material from file; Turnes = 5




%% plots
% real
fig1 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig1,'position',[360   514   921   408])
plot(MnZn_Core_SM(:,1),MnZn_Core_SM(:,2),'r','LineWidth',2)
plot(MnZn_Core_SM_CMC(:,1),MnZn_Core_SM_CMC(:,2),'b','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([10e3 110e6])
xlabel('Frequency [Hz]')
ylabel('real [\Omega]')
legend('SM Z real (circuit)','SM Z real (CMC)')
grid on

% imag
fig2 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig1,'position',[360   514   921   408])
plot(MnZn_Core_SM(:,1),abs(MnZn_Core_SM(:,3)),'r','LineWidth',2)
plot(MnZn_Core_SM_CMC(:,1),abs(MnZn_Core_SM_CMC(:,3)),'b','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([10e3 110e6])
xlabel('Frequency [Hz]')
ylabel('abs imag [\Omega]')
legend('SM sbs Z imag (circuit)','SM abs Z imag (CMC)')
grid on

% magn
fig3 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig1,'position',[360   514   921   408])
plot(MnZn_Core_SM(:,1),sqrt((MnZn_Core_SM(:,2)).^2 + (MnZn_Core_SM(:,3)).^2),'r','LineWidth',2)
plot(MnZn_Core_SM_CMC(:,1),sqrt((MnZn_Core_SM_CMC(:,2)).^2 + (MnZn_Core_SM_CMC(:,3)).^2),'b','LineWidth',2)
plot(1e3.*CM_181(:,1),1e3.*CM_181(:,2),'g--','LineWidth',2)

set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
% xlim([10e3 110e6])
xlabel('Frequency [Hz]')
ylabel('magn [\Omega]')
legend('SM Z magn (circuit)','SM Z magn (CMC)','CM 181U 15A REV.B')
grid on

% L calculation

n = 0;
L_freq   = 10e3;
sazebari = 0;

for n = 1:1:length(MnZn_Core_SM)
    
    sazebari(n,1) = MnZn_Core_SM(n,1)-L_freq;
    
end


[M,I] = min(abs(sazebari));

disp('min index')
I

disp('L value 10 KHz in mH (circuit simulation; PN:74482210002)')
L = ((MnZn_Core_SM(I,3))/(2*pi*MnZn_Core_SM(I,1)))*1e3


% L plot 


fig3 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(fig1,'position',[360   514   921   408])
plot(MnZn_Core_SM(:,1),((MnZn_Core_SM(:,3))./(2*pi*MnZn_Core_SM(:,1))).*1e3,'r','LineWidth',2)
plot(MnZn_Core_SM_CMC(:,1),((MnZn_Core_SM_CMC(:,3))./(2*pi*MnZn_Core_SM_CMC(:,1))).*1e3,'b--','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([10e3 110e6])
xlabel('Frequency [Hz]')
ylabel('inductance [mH]')
legend('inductance (circuit model)','inductance (CMC model)')
grid on


