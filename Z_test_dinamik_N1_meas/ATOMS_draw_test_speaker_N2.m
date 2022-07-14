clc
clear all
close all

% ???????? ??????? ???? ???????? 
atoms_impedance          = load('Z_meas_speaker_Magn_Phase_Z_free_air.dat'); % magn phase 
atoms_impedance_N2       = load('Z_meas_speaker_Magn_Phase_Z_free_air_N2.dat'); % magn phase

atoms_impedance_added = load('Z_meas_speaker_Magn_Phase_Z_free_air_with_added_mass.dat');  

%% plots
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
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Xscale','log')
set(fig2,'position',[200   370   900   300])
% plot(atoms_impedance(:,1),atoms_impedance(:,2),'r','LineWidth',2)
plot(atoms_impedance(:,1),atoms_impedance(:,3),'b','LineWidth',2)
plot(atoms_impedance_added(:,1),atoms_impedance_added(:,3),'m--','LineWidth',2)
plot(atoms_impedance_N2(:,1),atoms_impedance_N2(:,3),'r--','LineWidth',2)

% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlabel('Frequency')
ylabel('deg')
legend('Meas phase','Meas phase - added testing','Meas phase N2')
grid on 


fig3 = figure; 
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
set(fig3,'position',[200   370   900   300])
plot(atoms_impedance(:,1),atoms_impedance(:,2),'b','LineWidth',2)
plot(atoms_impedance_added(:,1),atoms_impedance_added(:,2),'m--','LineWidth',2)
plot(atoms_impedance_N2(:,1),atoms_impedance_N2(:,2),'r--','LineWidth',2)
% plot(atoms_impedance(:,1),atoms_impedance(:,3),'b','LineWidth',2)
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
t = xlabel('Frequency [Hz]');
p = ylabel('ohm');
t.Color = 'red';
p.Color = 'red';

legend('Meas magnitue','Meas magnitude - added testing','Meas magnitue N2')
grid on 

%% Vas = 0.0962