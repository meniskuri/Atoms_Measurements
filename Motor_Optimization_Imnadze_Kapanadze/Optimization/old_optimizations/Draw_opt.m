clc 
clear all
close all

%% load files
dat_old_p     =load('optimization parameters_Motor_optimization_old.dat');
dat_old_abs_p =load('optimization parameters_Motor_optimization_old_ABS.dat');
dat_big_p     =load('optimization_parameters_big_program.dat');
dat_MO_p      =load('optimization parameters_Motor_optimization.dat');
dat_NEW_26iter_p =load('output_parameters26iter.dat');
dat_19_533proc_p =load('Parameters_19_533_procenti.dat');

dat_old_z     =load('Z_optimization_Data_Motor_optimization_old.dat');
dat_old_abs_z =load('Z_optimization_Data_Motor_optimization_old_ABS.dat');
dat_big_z     =load('Z_optimization_big_program.dat');
dat_MO_z      =load('Z_optimization_Data_Motor_optimization.dat');
dat_NEW_26iter_z =load('Z_Optimization_New_26iter.dat');
dat_19_533proc_z =load('Z_19_533_procenti_opt.dat');

dat_meas      =load('green_load_load.dat');

par_num       =(1:1:36)';
par_num_26    =(1:1:24)';
%% plots
fig1 = figure;
hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Xscale','log')
set(fig1,'position',[360   370   918   552])
plot(dat_meas(:,1),abs(dat_meas(:,2)+1i.*dat_meas(:,3)),'r','LineWidth',2)
plot(dat_old_abs_z(:,1),abs(dat_old_abs_z(:,2)+1i.*dat_old_abs_z(:,3)),'b--','LineWidth',2)
plot(dat_old_z(:,1),abs(dat_old_z(:,2)+1i.*dat_old_z(:,3)),'k--','LineWidth',2)
plot(dat_big_z(:,1),abs(dat_big_z(:,2)+1i.*dat_big_z(:,3)),'m--','LineWidth',2)
plot(dat_MO_z(:,1),abs(dat_MO_z(:,2)+1i.*dat_MO_z(:,3)),'g--','LineWidth',2)
plot(dat_NEW_26iter_z(:,1),abs(dat_NEW_26iter_z(:,2)+1i.*dat_NEW_26iter_z(:,3)),'y--','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlabel('Frequency')
ylabel('\Omega')
legend('Measured abs[Z]','otimization "old abs" abs[Z]','otimization "old" abs[Z]','otimization "big program" abs[Z]','otimization "NEW motor opt" abs[Z]',...
    'otimization "NEW 26iteration" abs[Z]')
grid on

fig2 = figure;
hold on
%set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Yscale','log')
set(fig2,'position',[1   300   1500   500])
plot(par_num(:,1),dat_old_abs_p(:,1),'b*','LineWidth',2)
plot(par_num(:,1),dat_old_p(:,1),'ko','LineWidth',2)
plot(par_num(:,1),dat_big_p(:,1),'m+','LineWidth',2)
plot(par_num(:,1),dat_MO_p(:,1),'g+','LineWidth',2)
plot(par_num_26(:,1),dat_NEW_26iter_p(1,:),'y+','LineWidth',2)
set(gca,'YTick',[1e-13 1e-11 1e-9 1e-7 1e-5 1e-3 1e-1 1 600 1e5 1e7]);
set(gca,'YTickLabel',['1e-13';'1e-11';'1e-9 ';'1e-7 ';'1e-5 ';'1e-3 ';'1e-1 ';'1    ';'600  ';'1e5  ';'1e7  '])
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25,...
    26 27 28 29 30 31 32 33 34 35 36]);
set(gca,'XTickLabel',['1 ';'2 ';'3 ';'4 ';'5 ';'6 ';'7 ';'8 ';'9 ';'10';...
    '11';'12';'13';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23';'24';...
    '25';'26';'27';'28';'29';'30';'31';'32';'33';'34';'35';'36'])
xlabel('Optimization parameter numeration P _')
ylabel('Optimization parameter value')
legend('otimization "old abs"','otimization "old"','otimization "big program"','otimization "NEW motor opt" abs[Z]',...
    'otimization "NEW 26iteration" abs[Z]')
xlim([0 37])
% ylim([1e-13 10000])
grid on


fig3 = figure;
hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Xscale','log')
set(fig3,'position',[360   370   918   552])
plot(dat_meas(:,1),abs(dat_meas(:,2)+1i.*dat_meas(:,3)),'r','LineWidth',2)
plot(dat_19_533proc_z(:,1),abs(dat_19_533proc_z(:,2)+1i.*dat_19_533proc_z(:,3)),'k--','LineWidth',2)
plot(dat_NEW_26iter_z(:,1),abs(dat_NEW_26iter_z(:,2)+1i.*dat_NEW_26iter_z(:,3)),'y--','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlabel('Frequency')
ylabel('\Omega')
legend('Measured abs[Z]','otimization "NEW 19.533 %" abs[Z]',...
    'otimization "NEW 26iteration" abs[Z]')
grid on

fig4 = figure;
hold on
%set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Yscale','log')
set(fig4,'position',[1   300   1500   500])
plot(par_num_26(:,1),dat_19_533proc_p(:,1),'ko','LineWidth',2)
plot(par_num_26(:,1),dat_NEW_26iter_p(1,:),'y+','LineWidth',2)
set(gca,'YTick',[1e-13 1e-11 1e-9 1e-7 1e-5 1e-3 1e-1 1 600 1e5 1e7]);
set(gca,'YTickLabel',['1e-13';'1e-11';'1e-9 ';'1e-7 ';'1e-5 ';'1e-3 ';'1e-1 ';'1    ';'600  ';'1e5  ';'1e7  '])
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25,...
    26 27 28 29 30 31 32 33 34 35 36]);
set(gca,'XTickLabel',['1 ';'2 ';'3 ';'4 ';'5 ';'6 ';'7 ';'8 ';'9 ';'10';...
    '11';'12';'13';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23';'24';...
    '25';'26';'27';'28';'29';'30';'31';'32';'33';'34';'35';'36'])
xlabel('Optimization parameter numeration P _')
ylabel('Optimization parameter value')
legend('otimization "NEW 19.533 %" abs[Z]',...
    'otimization "NEW 26iteration" abs[Z]')
xlim([0 37])
% ylim([1e-13 10000])
grid on
