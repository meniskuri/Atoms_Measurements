clc
clear all
close all

%% chemi awyobili test1 

%% datos awyobili test1

%% box with chveni dinamiki marto
box_atoms_only = load('dinamiki_atoms_yutshi_marto.txt');

%% box with pishalka marto

% box with sruli gazomva (pishalka + atoms) 

%% Shenishvnebi

%% plots 

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
