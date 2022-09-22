clc
clear all
% close all

%% measurements 
atoms_impedance_kapana2_old       = load('Z_meas_speaker_Magn_Phase_Z_free_air.dat'); 
atoms_impedance_kapana2_old_added = load('Z_meas_speaker_Magn_Phase_Z_free_air_with_added_mass.dat');

Z_kapana2_testing1                = load('kapana2_TESTINGN2_free.txt');
Z_kapana2_testing1_added          = load('kapana2_TESTINGN2_added.txt'); 
z_kapana2_testing3_ukalibracio    = load('kapana2_TESTINGN3_ukalibracio_free.txt');
z_kapana2_testing4_sruli          = load('kapana2_TESTINGN4_sruli_gazomva.txt');

%% measurement of chemi awyobili gushindeli anu (14 jul) iyo gushin 
z_atomebi_testing_Chemi_free      = load('Chveni_TEST1_free.txt');
z_atomebi_testing2_Chemi_free     = load('Chveni_TEST2_free.txt');
z_atomebi_testing3_Chemi_sruli    = load('Chveni_TEST3_fsruli.txt');

%% measurements of datos awyobili test1 (28 jul)
z_atomebi_testing1_Datos_free     = load('Chveni_datos_awyobili_TEST1_free.txt');

%% simulations firs try
z_kapana2_LTSpicesimTest1 = load('atoms_dinamiki_chven_vaaraxdebai.txt');
z_datos_awyobili_test1_sim1 = load('datos_awyobili1_test1_sim_testing1.txt');

%% plots
fig1 = figure; 
hold on
ax = gca;
ax.YColor = 'r';
ax.GridColor = 'b';
ax.FontWeight = 'bold';
ay = gca;
ay.XColor = 'r';
ay.GridColor = 'b';
ay.FontWeight = 'bold';
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Xscale','log')
set(fig1,'position',[200   370   900   500])
plot(atoms_impedance_kapana2_old(:,1),atoms_impedance_kapana2_old(:,3),'b','LineWidth',2)
plot(Z_kapana2_testing1(:,1),Z_kapana2_testing1(:,3),'r--','LineWidth',2)
plot(atoms_impedance_kapana2_old_added(:,1),atoms_impedance_kapana2_old_added(:,3),'m','LineWidth',2)
plot(Z_kapana2_testing1_added(:,1),Z_kapana2_testing1_added(:,3),'g','LineWidth',2)
plot(z_atomebi_testing_Chemi_free(:,1),z_atomebi_testing_Chemi_free(:,3),'y','LineWidth',2)
plot(z_atomebi_testing2_Chemi_free(:,1),z_atomebi_testing2_Chemi_free(:,3),'k--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest1(:,1),z_kapana2_LTSpicesimTest1(:,3),'m--','LineWidth',2)

% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([1 20e3])
ylim([-40 100])
xlabel('Frequency [Hz]')
ylabel('Meas Z phase deg')
legend('loudspeaker kapana2 - old (first meas)(free)','Meas phase - loudspeaker kapana2 - new testing1(free)',...
    'loudspeaker kapana2 - old (first meas)(added 16.2 g)','Meas phase - loudspeaker kapana2 - new testing (added 15.3 g)',...
    'loudspeaker atoms (chemi awyobili test1 - cudi (gadaertebuli) gazomva',...
    'loudspeaker atoms (chemi awyobili test1 - gaumjobesebuli (uketesi sheerteba) gazomva','simulation test1')
grid on 


fig2 = figure; 
hold on
ax = gca;
ax.YColor = 'r';
ax.GridColor = 'b';
ax.FontWeight = 'bold';
ay = gca;
ay.XColor = 'r';
ay.GridColor = 'b';
ay.FontWeight = 'bold';
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(gca,'fontsize',14,'Xscale','log')
set(fig2,'position',[200   370   900   500])
plot(atoms_impedance_kapana2_old(:,1),atoms_impedance_kapana2_old(:,2),'b','LineWidth',2)
plot(atoms_impedance_kapana2_old(:,1),Z_kapana2_testing1(:,2),'r--','LineWidth',2)
plot(atoms_impedance_kapana2_old_added(:,1),atoms_impedance_kapana2_old_added(:,2),'m','LineWidth',2)
plot(Z_kapana2_testing1_added(:,1),Z_kapana2_testing1_added(:,2),'g','LineWidth',2)
plot(z_atomebi_testing_Chemi_free(:,1),z_atomebi_testing_Chemi_free(:,2),'y','LineWidth',2)
plot(z_atomebi_testing2_Chemi_free(:,1),z_atomebi_testing2_Chemi_free(:,2),'k--','LineWidth',2)
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([1 20e3])
ylim([0 100])
t = xlabel('Frequency [Hz]');
p = ylabel('Meas Z magnitue ohm');
t.Color = 'red';
p.Color = 'red';
legend('loudspeaker kapana2 - old (first meas)(free)','Meas magnitue - loudspeaker kapana2 - new testing1 (free)',...
    'loudspeaker kapana2 - old (first meas)(added 16.2 g)','Meas magnitue - loudspeaker kapana2 - new testing (added 15.3 g)',...
    'loudspeaker atoms (chemi awyobili test1) - cudi (gadaertebuli) gazomva',...
    'loudspeaker atoms (chemi awyobili test1 - gaumjobesebuli (uketesi sheerteba) gazomva')
grid on 


fig2 = figure; 
hold on
ax = gca;
ax.YColor = 'r';
ax.GridColor = 'b';
ax.FontWeight = 'bold';
ay = gca;
ay.XColor = 'r';
ay.GridColor = 'b';
ay.FontWeight = 'bold';
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(gca,'fontsize',14,'Xscale','log')
set(fig2,'position',[200   370   900   500])
plot(atoms_impedance_kapana2_old(:,1),atoms_impedance_kapana2_old(:,2),'b','LineWidth',2)
plot(atoms_impedance_kapana2_old(:,1),Z_kapana2_testing1(:,2),'r--','LineWidth',2)
plot(z_kapana2_testing3_ukalibracio(:,1),z_kapana2_testing3_ukalibracio(:,2),'k','LineWidth',2)
plot(z_kapana2_testing4_sruli(:,1),z_kapana2_testing4_sruli(:,2),'g','LineWidth',2)
% plot(z_kapana2_LTSpicesimTest1(:,1),z_kapana2_LTSpicesimTest1(:,2),'k--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest1(:,1),sqrt((z_kapana2_LTSpicesimTest1(:,2).*sind(z_kapana2_LTSpicesimTest1(:,3))).^2 + (z_kapana2_LTSpicesimTest1(:,2).*cosd(z_kapana2_LTSpicesimTest1(:,3))).^2),'k--','LineWidth',2)

% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([1 20e3])
ylim([0 100])
t = xlabel('Frequency [Hz]');
p = ylabel('Meas Z magnitue ohm');
t.Color = 'red';
p.Color = 'red';
legend('loudspeaker kapana2 - old (first meas)(free)','Meas magnitue - loudspeaker kapana2 - new testing1 (free)',...
    'loudspeaker kapana2 - kalibraciis gareshe chawerili','loudspeaker kapana2 - sruli gazomva (kargi)',...
    'simulation test1')
grid on

fig2 = figure; 
hold on
ax = gca;
ax.YColor = 'r';
ax.GridColor = 'b';
ax.FontWeight = 'bold';
ay = gca;
ay.XColor = 'r';
ay.GridColor = 'b';
ay.FontWeight = 'bold';
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(gca,'fontsize',14,'Xscale','log')
set(fig2,'position',[200   370   900   500])
plot(z_atomebi_testing_Chemi_free(:,1),z_atomebi_testing_Chemi_free(:,2),'y','LineWidth',2)
plot(z_atomebi_testing2_Chemi_free(:,1),z_atomebi_testing2_Chemi_free(:,2),'k--','LineWidth',2)
plot(z_atomebi_testing3_Chemi_sruli(:,1),z_atomebi_testing3_Chemi_sruli(:,2),'g','LineWidth',2)
plot(z_atomebi_testing1_Datos_free(:,1),z_atomebi_testing1_Datos_free(:,2),'r--','LineWidth',2)
plot(z_datos_awyobili_test1_sim1(:,1),(sqrt((z_datos_awyobili_test1_sim1(:,3)).^2 + (z_datos_awyobili_test1_sim1(:,2)).^2)),'m--','LineWidth',2)



set(gca,'XTick',[1 100 1e3 2e4]);
set(gca,'XTickLabel',['1Hz   ';'100Hz ';'1kHz  ';'20kHz '])
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([1 20e3])
ylim([0 100])
t = xlabel('Frequency [Hz]');
p = ylabel('Meas Z magnitue ohm');
t.Color = 'red';
p.Color = 'red';
legend('loudspeaker atoms (chemi awyobili test1) - cudi (gadaertebuli) gazomva',...
    'loudspeaker atoms (chemi awyobili test1 - gaumjobesebuli (uketesi sheerteba) gazomva',...
    'loudspeaker atoms (chemi awyobili test3 - ar exeba coili arafers - sruli gazomva',...
    'loudspeaker atoms (datos awyobili test1 - free air')
grid on

fig2 = figure; 
hold on
ax = gca;
ax.YColor = 'r';
ax.GridColor = 'b';
ax.FontWeight = 'bold';
ay = gca;
ay.XColor = 'r';
ay.GridColor = 'b';
ay.FontWeight = 'bold';
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(gca,'fontsize',14,'Xscale','log')
set(fig2,'position',[200   370   900   500])
plot(z_atomebi_testing1_Datos_free(:,1),z_atomebi_testing1_Datos_free(:,2),'r--','LineWidth',2)
plot(z_datos_awyobili_test1_sim1(:,1),(sqrt((z_datos_awyobili_test1_sim1(:,3)).^2 + (z_datos_awyobili_test1_sim1(:,2)).^2)),'m--','LineWidth',2)



set(gca,'XTick',[1 100 1e3 2e4]);
set(gca,'XTickLabel',['1Hz   ';'100Hz ';'1kHz  ';'20kHz '])
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([1 20e3])
ylim([0 100])
t = xlabel('Frequency [Hz]');
p = ylabel('Meas Z magnitue ohm');
t.Color = 'red';
p.Color = 'red';
legend('loudspeaker atoms (datos awyobili test1) - gazomva',...
    'simulation')
grid on
%% Vas = 0.0962

%% ???????????? ?????????. ????? ???????????? 