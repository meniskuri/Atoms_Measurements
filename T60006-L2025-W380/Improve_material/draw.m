clear all
close all
clc

d = load('ferrite_mu.dat');
f = d(:,1);
mu = d(:,2) + j*d(:,3);
clear d

d = load('ferrite_mu_kk.dat');
f_s = d(:,1);
mu_s = d(:,2) + j*d(:,3);
clear d

d = load('ferrite_mu_debye.dat');
f_a = d(:,1);
mu_a = d(:,2) + j*d(:,3);
clear d

%Drawing data saved to material file
fig = figure;
hold on
set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(fig,'position',[360   313   727   439])
plot(f,real(mu),'b','LineWidth',2)
plot(f,imag(mu),'r','LineWidth',2)
plot(f_s,real(mu_s),'g','LineWidth',2)
plot(f_s,imag(mu_s),'m','LineWidth',2)
plot(f_a,real(mu_a),'k','LineWidth',2)
plot(f_a,imag(mu_a),'k-.','LineWidth',2)
set(gca,'YTick',[1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3 1e4 1e5 1e6]);
set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 ';'1k  ';'10k ';'100k';'1M  '])
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlim([40 3e9])
%ylim([0.5 1e4])
title('WE CMB NiZn')
xlabel('Frequency')
ylabel('Permeability')
legend('\mu'' measured','\mu'''' measured','\mu'' smooth','\mu'''' LF_a_p_p_r_o_x => KK','\mu'' LF_a_p_p_r_o_x','\mu'''' LF_a_p_p_r_o_x => Debye')
grid on
box on