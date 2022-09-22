clc
clear all
close all

%% chemi awyobili test1 

%% datos awyobili test1

%% box with chveni dinamiki marto
box_atoms_only = load('dinamiki_atoms_yutshi_marto.txt');

%% 3 dinamikis shedareba
naklebad_gacentrili_garedan_Z        = load('ATOMS_naklebad_gacentrili_garet_18g_plastelin.txt');
naklebad_gacentrili_garedan_Z_shaiba = load('ATOMS_naklebad_gacentrili_garet_18plastelin_shaiba.txt');

naklebad_gacentrili_shignit_Z        = load('ATOMS_naklebad_gacentrili_shignit_18g_plastelin.txt');

idealurad_gacentrili_Z               = load('ATOMS_idealurad_gacentrili_18g_plastelin.txt');


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
plot(naklebad_gacentrili_garedan_Z(:,1),naklebad_gacentrili_garedan_Z(:,2),'r','LineWidth',2)
plot(naklebad_gacentrili_garedan_Z_shaiba(:,1),naklebad_gacentrili_garedan_Z_shaiba(:,2),'b--','LineWidth',2)

plot(naklebad_gacentrili_shignit_Z(:,1),naklebad_gacentrili_shignit_Z(:,2),'m','LineWidth',2)

plot(idealurad_gacentrili_Z(:,1),idealurad_gacentrili_Z(:,2),'k','LineWidth',2)

set(gca,'XTick',[1 100 1e3 2e4]);
set(gca,'XTickLabel',['1Hz   ';'100Hz ';'1kHz  ';'20kHz '])
xlim([1 20e3])
ylim([0 100])
t = xlabel('Frequency [Hz]');
p = ylabel('Meas Z magnitue ohm');
t.Color = 'red';
p.Color = 'red';
legend('naklebad gacentrili garedan Z','naklebad gacentrili garedan Z shaiba',...
    'naklebad gacentrili shignit Z','idealurad gacentrili Z')
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
