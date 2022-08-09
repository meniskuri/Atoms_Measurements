clc
clear all
close all

%% LTsipice simulacia Vs Measurements (problema)
z_kapana2_testing4_sruli          = load('kapana2_TESTINGN4_sruli_gazomva.txt');

%% Sim data
z_kapana2_LTSpicesimTest1 = load('kapana2_sim_testing1.txt'); % gamotvili parametrebi
z_kapana2_LTSpicesimTest2 = load('kapana2_sim_testing2.txt'); % L2 shevcvale
z_kapana2_LTSpicesimTest3 = load('kapana2_sim_testing3.txt'); % C1 shevcvale
z_kapana2_LTSpicesimTest4 = load('kapana2_sim_testing4.txt'); % C1 shevcvale
z_kapana2_LTSpicesimTest5 = load('kapana2_sim_testing5.txt'); % R2 shevcvale

% L1 is cvlilebebi
z_kapana2_LTSpicesimTest6 = load('kapana2_sim_testing6.txt'); % L1 iyo 0.17m gaxda 0.2m
z_kapana2_LTSpicesimTest7 = load('kapana2_sim_testing7.txt'); % L1 iyo 0.17m gaxda 0.4m
z_kapana2_LTSpicesimTest8 = load('kapana2_sim_testing8.txt'); % L1 iyo 0.17m gaxda 0.3m
z_kapana2_LTSpicesimTest9 = load('kapana2_sim_testing9.txt'); % L1 iyo 0.17m gaxda 0.3m R1 = 3.6 R1 = 4 gaxda
z_kapana2_LTSpicesimTest10 = load('kapana2_sim_testing10.txt'); % L1 aris 0.17m R1 = 4 gaxda


L_xvia_test1 = load('xviis_z_test1.txt');
%% Meas data


%% Plots
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
plot(z_kapana2_testing4_sruli(:,1),z_kapana2_testing4_sruli(:,2),'g','LineWidth',2)
% plot(z_kapana2_LTSpicesimTest1(:,1),abs(z_kapana2_LTSpicesimTest1(:,3)),'k--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest1(:,1),(sqrt((z_kapana2_LTSpicesimTest1(:,3)).^2 + (z_kapana2_LTSpicesimTest1(:,2)).^2)),'m--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest2(:,1),(sqrt((z_kapana2_LTSpicesimTest2(:,3)).^2 + (z_kapana2_LTSpicesimTest2(:,2)).^2)),'y--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest3(:,1),(sqrt((z_kapana2_LTSpicesimTest3(:,3)).^2 + (z_kapana2_LTSpicesimTest3(:,2)).^2)),'g--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest4(:,1),(sqrt((z_kapana2_LTSpicesimTest4(:,3)).^2 + (z_kapana2_LTSpicesimTest4(:,2)).^2)),'r--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest5(:,1),(sqrt((z_kapana2_LTSpicesimTest5(:,3)).^2 + (z_kapana2_LTSpicesimTest5(:,2)).^2)),'b--','LineWidth',2)

% plot(z_kapana2_LTSpicesimTest1(:,1),sqrt((z_kapana2_LTSpicesimTest1(:,2).*sind(z_kapana2_LTSpicesimTest1(:,3))).^2 + (z_kapana2_LTSpicesimTest1(:,2).*cosd(z_kapana2_LTSpicesimTest1(:,3))).^2),'k--','LineWidth',2)

% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([1 30e3])
ylim([0 100])
t = xlabel('Frequency [Hz]');
p = ylabel('Meas Z magnitue ohm');
t.Color = 'red';
p.Color = 'red';
legend('loudspeaker kapana2 - sruli gazomva (kargi)',...
    'simulation test1 (gamotvili parametrebi L2 = 6.9596m) (C1 = 4.87e-4)','simulation test2 (L2 shecvlilia - Cms*BL^2 = 10m)',...
    'simulation test1 (gamotvili parametrebi L2 = 6.9596m) (C1 = 1e-4; Mmd/BL^2)','simulation test1 (gamotvili parametrebi L2 = 6.9596m) (C1 = 8e-4; Mmd/BL^2)',...
    'simulation test1 (gamotvili parametrebi L2 = 6.9596m) (C1 = 4.87e-4; Mmd/BL^2) (R2 iyo 14.5 gaxda 5)')
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
plot(z_kapana2_testing4_sruli(:,1),z_kapana2_testing4_sruli(:,2),'g','LineWidth',2)
% plot(z_kapana2_LTSpicesimTest1(:,1),abs(z_kapana2_LTSpicesimTest1(:,3)),'k--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest1(:,1),(sqrt((z_kapana2_LTSpicesimTest1(:,3)).^2 + (z_kapana2_LTSpicesimTest1(:,2)).^2)),'m--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest6(:,1),(sqrt((z_kapana2_LTSpicesimTest6(:,3)).^2 + (z_kapana2_LTSpicesimTest6(:,2)).^2)),'r--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest7(:,1),(sqrt((z_kapana2_LTSpicesimTest7(:,3)).^2 + (z_kapana2_LTSpicesimTest7(:,2)).^2)),'b--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest8(:,1),(sqrt((z_kapana2_LTSpicesimTest8(:,3)).^2 + (z_kapana2_LTSpicesimTest8(:,2)).^2)),'k--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest9(:,1),(sqrt((z_kapana2_LTSpicesimTest9(:,3)).^2 + (z_kapana2_LTSpicesimTest9(:,2)).^2)),'y--','LineWidth',2)
plot(z_kapana2_LTSpicesimTest10(:,1),(sqrt((z_kapana2_LTSpicesimTest10(:,3)).^2 + (z_kapana2_LTSpicesimTest10(:,2)).^2)),'g--','LineWidth',2)
plot(L_xvia_test1(:,1),L_xvia_test1(:,2),'k','LineWidth',2)


% plot(z_kapana2_LTSpicesimTest1(:,1),sqrt((z_kapana2_LTSpicesimTest1(:,2).*sind(z_kapana2_LTSpicesimTest1(:,3))).^2 + (z_kapana2_LTSpicesimTest1(:,2).*cosd(z_kapana2_LTSpicesimTest1(:,3))).^2),'k--','LineWidth',2)
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
% set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([1 30e3])
ylim([0 100])
t = xlabel('Frequency [Hz]');
p = ylabel('Meas Z magnitue ohm');
t.Color = 'red';
p.Color = 'red';
legend('loudspeaker kapana2 - sruli gazomva (kargi)',...
    'simulation test1 (gamotvili parametrebi L2 = 6.9596m) (C1 = 4.87e-4)','simulation test1 (gamotvili parametrebi L1 = 0.17m iyo) (L1 = 0.2m gaxda)',...
    'simulation test1 (gamotvili parametrebi L1 = 0.17m iyo) (L1 = 0.4m gaxda)','simulation test1 (gamotvili parametrebi L1 = 0.17m iyo) (L1 = 0.3m gaxda)',...
    'simulation test1 (gamotvili parametrebi L1 = 0.17m iyo R1 =3.6 iyo) (L1 = 0.3m gaxda R1 =4 gaxda)',...
    'simulation test1 (gamotvili parametrebi L1 = 0.17m iyo R1 =3.6 iyo) (L1 = 0.17m gaxda R1 =4 gaxda)')
grid on

%% Parameters calculation