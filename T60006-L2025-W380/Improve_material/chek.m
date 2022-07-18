clc
clear all
close all

eps = load('Big_Eps.dat');
Mu  = load('ferrite_mu_debye.dat');

eps_interp_r           = interp1(eps(:,1),eps(:,2),Mu(:,1),'linear');
eps_interp_i           = interp1(eps(:,1),eps(:,3),Mu(:,1),'linear');

eps_interp = [Mu(:,1) eps_interp_r eps_interp_i]

material = [Mu(:,1) (eps_interp_r.*0)+10000 eps_interp_i.*0  Mu(:,2) Mu(:,3)]

save('material_interp.dat','material','-ascii')

fig3 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
%set(fig3,'position',[360   200   918   552])
set(fig3,'position',[680   423   671   355])
plot(material(:,1),material(:,4),'r','LineWidth',2)
plot(material(:,1),material(:,5),'b','LineWidth',2)
set(gca,'YTick',[1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3 1e4 1e5 3e5 1e6]);
set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 ';'1k  ';'10k ';'100k';'300k';'1M  '])
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([40 110e6])
ylim([0.5 20e4])
title('')
xlabel('Frequency')
ylabel('Permeability')
legend('\mu''','\mu''''')
grid on
box on

fig3 = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(fig3,'position',[680   423   671   355])
plot(material(:,1),material(:,2),'r','LineWidth',2)
plot(material(:,1),material(:,3),'b','LineWidth',2)
set(gca,'YTick',[1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3 1e4 2e4 1e5 3e5 1e6]);
set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 ';'1k  ';'10k ';'20k ';'100k';'300k';'1M  '])
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
% xlim([40 110e6])
%     ylim([0.5 1e4])
title('')
xlabel('Frequency')
ylabel('Permittivity')
legend('\epsilon''','\epsilon''''')
grid on
box on
