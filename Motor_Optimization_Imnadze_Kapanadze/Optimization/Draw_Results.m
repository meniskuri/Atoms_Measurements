clc
clear all
close all

%data_meas = load('Motor_optimization\green_load_load.dat'); % <=== emcos motor
data_meas = load('Motor_optimization\Z_meas_YANMAR_MOTOR.dat'); % <=== yanmar motor
f         = data_meas(:, 1);

%% set_cir_param
mat_par            = 0;
data_and_cir_fname = 'Motor_optimization';
problem_path       = 'Motor_optimization';

% get Voltage

% get Current

IData_re = [];
IData_im = [];

fid_r = fopen(fullfile(problem_path, [data_and_cir_fname, '.raw']), 'r')
fullfile(problem_path, [data_and_cir_fname, '.raw'])

str = fgetl(fid_r);
k =  0;
while ~feof(fid_r)
    str = fgetl(fid_r);
    if ~isempty(str2num(str))
        data_tmp = str2num(str);
        if length(data_tmp) == 3
            k = k+1;
            n = 0;
            freq(k) = data_tmp(2);
        else
            n = n+1;
            IData_re(n, k) = data_tmp(1);
            IData_im(n, k) = data_tmp(2);
        end
    end
end
fclose(fid_r);

IRe       = interp1(freq, IData_re, f);
IIm       = interp1(freq, IData_im, f);
Z_complex = 1./complex(IRe, IIm);
Z         = (-Z_complex);  % complex optimization impedance
Z_re      = real(Z_complex);
Z_im      = imag(Z_complex);
res_data  = [f  Z_re Z_im];

x = 0;
y = 0;

for count_m = 1:1:length(f)
    x(1,count_m) = (abs((data_meas(count_m, 2)+1i*data_meas(count_m, 3)) - Z(count_m))).^2;
    y(1,count_m) = (abs(data_meas(count_m, 2)+1i*data_meas(count_m, 3))).^2;
end

mat_par = 100*(sqrt(sum(x)))/(sqrt(sum(y)));


fig2 = figure;
hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Xscale','log')
set(fig2,'position',[360   370   918   552])
plot(f,data_meas(:, 2),'r--','LineWidth',2)
plot(f,data_meas(:, 3),'b--','LineWidth',2)
plot(f,real(Z),'r','LineWidth',2)
plot(f,imag(Z),'b','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlabel('Frequency')
ylabel('\Omega')
legend('Meas real','Meas imag','optim real','optim imag')
eval(['title(''',num2str(mat_par),' % '')'])
grid on

fig3 = figure;
hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Xscale','log')
set(fig3,'position',[360   370   918   552])
plot(f,abs(data_meas(:, 2)+i*data_meas(:, 3)),'r--','LineWidth',2)
plot(f,abs(Z),'r','LineWidth',2)
set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlabel('Frequency')
ylabel('\Omega')
legend('Meas abs','optim abs')
eval(['title(''',num2str(mat_par),' % '')'])
grid on


