clc
clear all
close all

%% chemi awyobili test1 

%% datos awyobili test1

%% box with chveni dinamiki marto
box_atoms_only = load('dinamiki_atoms_yutshi_marto.txt'); % ATOMS yuti shavi marto vuferi (chveni)

%% box N3 Z measurements - with C (gayofili) box N3 cota sxva zomisaa 
yuti_N3_bass_z        = load('yuti_N3_bass_z.txt');

yuti_N3_tweeter_z     = load('yuti_N3_tweeter_z.txt');

yuti_N3_mtliani_z     = load('yuti_N3_mtliani_z.txt');

yuti_N3_tweeter_only_withot_C_z     = load('yuti_N3_tweeter_only_withot_C_z.txt');

% measurements with crossover (L = 4mH and C =0.1 uF; 2 way 12db; Cutoff 8khz) 
yuti_N3_mtliani_z_with_crossover_STST1 = load('yuti_N3_mtliani_z_with_crossover_STST1.txt');
yuti_N3_bass_z_with_crossover_STST1    = load('yuti_N3_bass_z_with_crossover_STST1.txt');


%% plots 
%% Plots
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
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
% set(gca,'fontsize',14,'Xscale','log')
set(fig1,'position',[200   370   900   500])

plot(yuti_N3_bass_z(:,1),yuti_N3_bass_z(:,2),'r','LineWidth',2)

plot(yuti_N3_tweeter_z(:,1),yuti_N3_tweeter_z(:,2),'b--','LineWidth',2)

plot(yuti_N3_mtliani_z(:,1),yuti_N3_mtliani_z(:,2),'m','LineWidth',2)

plot(yuti_N3_tweeter_only_withot_C_z(:,1),yuti_N3_tweeter_only_withot_C_z(:,2),'k','LineWidth',2)

plot(yuti_N3_mtliani_z_with_crossover_STST1(:,1),yuti_N3_mtliani_z_with_crossover_STST1(:,2),'g--','LineWidth',2)

plot(yuti_N3_bass_z_with_crossover_STST1(:,1),yuti_N3_bass_z_with_crossover_STST1(:,2),'y--','LineWidth',2)

set(gca,'XTick',[1 100 1e3 2e4]);
set(gca,'XTickLabel',['1Hz   ';'100Hz ';'1kHz  ';'20kHz '])
xlim([1 20e3])
ylim([0 100])
t = xlabel('Frequency [Hz]');
p = ylabel('Meas Z magnitue ohm');
t.Color = 'red';
p.Color = 'red';
legend('yuti N3 bass z','yuti N3 tweeter z',...
    'yuti N3 mtliani z','yuti N3 tweeter only withot C,z','yuti N3 mtliani z with crossover STST1','yuti N3 bass z with crossover STST1')
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
plot(box_atoms_only(:,1),box_atoms_only(:,2),'g','LineWidth',2)
set(gca,'XTick',[1 100 1e3 2e4]);
set(gca,'XTickLabel',['1Hz   ';'100Hz ';'1kHz  ';'20kHz '])
xlim([1 20e3])
ylim([0 100])
t = xlabel('Frequency [Hz]');
p = ylabel('Meas Z magnitue ohm');
t.Color = 'red';
p.Color = 'red';
legend('box ;)')
grid on
