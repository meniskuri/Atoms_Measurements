close all
clear all
clc

format longE

% p_1 = 50e-3;
% p_2 = 1e6;
% p_3 = 1.25e-9;
% p_4 = 13e-6;
% p_5 = 15e-6;
% p_6 = 350e-12;
% p_7 = 15e-12;
% p_8 = 125e-12;
% p_9 = 2.15e-9;
% p_10 = 250e-12;
% p_11 = 1e-3;
% p_12 = 400;
% p_13 = 225;
% p_14 = 200e-9;
% p_15 = 80e-9;
% p_16 = 18;
% p_17 = 10e-3; % ar icvleba
% p_18 = 13e-6;
% p_19 = 15e-6;
% p_20 = 350e-12;
% p_21 = 15e-12;
% p_22 = 125e-12;
% p_23 = 2.15e-9;
% p_24 = 250e-12;
% p_25 = 400;
% p_26 = 225;
% p_27 = 13e-6;
% p_28 = 15e-6;
% p_29 = 350e-12;
% p_30 = 15e-12;
% p_31 = 125e-12;
% p_32 = 2.15e-9;
% p_33 = 250e-12;
% p_34 = 400;
% p_35 = 225;
% p_36 = 110e-6;

p_1 = 1e-5:1e-5:1e-3;
% p_1 = 1e-7:1e-8:1e-5;
p_2 = 1e4:1e5:10e6;
p_3 = 1e-10:1e-10:10e-9;
p_4 = 1e-7:10e-7:100e-6;
p_5 = 1e-7:10e-7:100e-6;
p_6 = 1e-13:1e-13:1e-11;
p_7 = 1e-13:1e-13:1e-11;
p_8 = 1e-13:1e-13:1e-11;
p_9 = 1e-10:1e-10:10e-9;
p_10 = 1e-13:1e-13:1e-11;
p_11 = 1e-4:1e-3:100e-3;
p_12 = 200:4:600;
p_13 = 100:3:400;
p_14 = 1e-10:1e-10:1e-8;
p_15 = 1e-10:1e-10:1e-8;
p_16 = 1:1:100;
p_17 = 1e-4:1e-3:100e-3; % ar icvleba
p_18 = 1e-7:10e-7:100e-6;
p_19 = 1e-7:10e-7:100e-6;
p_20 = 1e-13:1e-13:1e-11;
p_21 = 1e-13:1e-13:1e-11;
p_22 = 1e-13:1e-13:1e-11;
p_23 = 1e-10:1e-10:1e-8;
p_24 = 1e-13:1e-13:1e-11;
p_25 = 200:4:600;
p_26 = 100:3:400;
p_27 = 1e-7:1e-7:1e-5;
p_28 = 1e-7:1e-7:1e-5;
p_29 = 1e-13:1e-13:1e-11;
p_30 = 1e-13:1e-13:1e-11;
p_31 = 1e-13:1e-13:1e-11;
p_32 = 1e-10:1e-10:1e-8;
p_33 = 1e-13:1e-13:1e-11;
p_34 = 200:4:600;
p_35 = 100:3:400;
p_36 = 1e-7:1e-7:1e-5;


number_of_elements = 36;
data_meas          = load('Motor_optimization\green_load_load.dat');
f                  = data_meas(:, 1);

for count_p = 1:1:number_of_elements+1
    
    mat_par = 0;
    if count_p == number_of_elements+1
        count_p_m = count_p - 1; % <= count_p_m = 1 ar damaviwydes
        m = count_p_m;
    else
        count_p_m = count_p;
    end
    count_p
    pause(1);
    for m = 1:1:length(eval(['p_',int2str(count_p_m)]))
        if count_p ~= number_of_elements+1
            eval(['p',int2str(count_p),' = p_',int2str(count_p),'(',int2str(m),');']);
            
            if count_p ~= number_of_elements
                
                for set_par = count_p:1:(number_of_elements-1)
                    eval(['p',int2str(set_par+1),' = p_',int2str(set_par+1),'(',int2str(1),');']);
                end
                
            else
                break
            end
        else
            break
        end
        %% set_cir_param
        data_and_cir_fname = 'Motor_optimization';
        
        P_fname            = 'Motor_optimization.cir';
        problem_path       = 'Motor_optimization';
        
        fid_w = fopen(fullfile(problem_path, P_fname), 'w');
        fullfile(problem_path, P_fname)
        
        
        fprintf(fid_w, '*\n');
        
        fprintf(fid_w, 'R22 N001 N007 %s\n', num2str(p1));
        fprintf(fid_w, 'R26 N008 N012 %s\n', num2str(p1));
        fprintf(fid_w, 'R30 N016 N015 %s\n', num2str(p1));
        fprintf(fid_w, 'R31 0 N003 %s\n', num2str(p2));
        fprintf(fid_w, 'C9 N013 N003 %s\n', num2str(p3));
        fprintf(fid_w, 'L1 N002 N001 %s\n', num2str(p4));
        fprintf(fid_w, 'L2 N003 N002 %s\n', num2str(p5));
        fprintf(fid_w, 'C17 N001 0 %s\n', num2str(p6));
        fprintf(fid_w, 'C18 N002 0 %s\n', num2str(p7));
        fprintf(fid_w, 'C19 N003 0 %s\n', num2str(p8));
        fprintf(fid_w, 'C20 N002 N001 %s\n', num2str(p9));
        fprintf(fid_w, 'C21 N003 N002 %s\n', num2str(p10));
        fprintf(fid_w, 'R32 0 N013 %s\n', num2str(p11));
        fprintf(fid_w, 'R33 N002 N001 %s\n', num2str(p12));
        fprintf(fid_w, 'R34 N003 N002 %s\n', num2str(p13));
        fprintf(fid_w, 'L3 N010 0 %s\n', num2str(p14));
        fprintf(fid_w, 'L11 N014 0 %s\n', num2str(p14));
        fprintf(fid_w, 'L12 N005 N004 %s\n', num2str(p14));
        fprintf(fid_w, 'L13 N006 N007 %s\n', num2str(p36));
        fprintf(fid_w, 'L14 N011 N012 %s\n', num2str(p36));
        fprintf(fid_w, 'L15 N018 N015 %s\n', num2str(p36));
        fprintf(fid_w, 'C22 N007 N005 %s\n', num2str(p15));
        fprintf(fid_w, 'C23 N012 N010 %s\n', num2str(p15));
        fprintf(fid_w, 'C24 N015 N014 %s\n', num2str(p15));
        fprintf(fid_w, 'R57 N012 N010 %s\n', num2str(p16));
        fprintf(fid_w, 'R58 N015 N014 %s\n', num2str(p16));
        fprintf(fid_w, 'R59 N007 N005 %s\n', num2str(p16));
        fprintf(fid_w, 'R60 N006 N005 %s\n', num2str(p17));
        fprintf(fid_w, 'R61 N011 N010 %s\n', num2str(p17));
        fprintf(fid_w, 'R62 N018 N014 %s\n', num2str(p17));
        fprintf(fid_w, 'L16 N009 N008 %s\n', num2str(p18));
        fprintf(fid_w, 'L17 N003 N009 %s\n', num2str(p19));
        fprintf(fid_w, 'C25 N008 0 %s\n', num2str(p20));
        fprintf(fid_w, 'C26 N009 0 %s\n', num2str(p21));
        fprintf(fid_w, 'C27 N003 0 %s\n', num2str(p22));
        fprintf(fid_w, 'C28 N009 N008 %s\n', num2str(p23));
        fprintf(fid_w, 'C29 N003 N009 %s\n', num2str(p24));
        fprintf(fid_w, 'R63 N009 N008 %s\n', num2str(p25));
        fprintf(fid_w, 'R64 N003 N009 %s\n', num2str(p26));
        fprintf(fid_w, 'L18 N017 N016 %s\n', num2str(p27));
        fprintf(fid_w, 'L19 N003 N017 %s\n', num2str(p28));
        fprintf(fid_w, 'C30 N016 0 %s\n', num2str(p29));
        fprintf(fid_w, 'C31 N017 0 %s\n', num2str(p30));
        fprintf(fid_w, 'C32 N003 0 %s\n', num2str(p31));
        fprintf(fid_w, 'C33 N017 N016 %s\n', num2str(p32));
        fprintf(fid_w, 'C34 N003 N017 %s\n', num2str(p33));
        fprintf(fid_w, 'R65 N017 N016 %s\n', num2str(p34));
        fprintf(fid_w, 'R66 N003 N017 %s\n', num2str(p35));
        
        %% aqamde
        
        fprintf(fid_w, 'V1 N004 0 AC 1 0 %s\n\n', '');
        
        fprintf(fid_w, '.ac oct 40 9K 50Meg %s\n', '');
        fprintf(fid_w, '.backanno %s\n', '');
        fprintf(fid_w, '.print I(V1) %s\n\n', '');
        fprintf(fid_w, '.end %s\n', '');
        
        fclose(fid_w);
        
        %% run LTspice
        eval(['cd ', problem_path])
        ! run.bat
        cd ..
        
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
        Z         = (-Z_complex);
        Z_re      = real(Z_complex);
        Z_im      = imag(Z_complex);
        res_data  = [f  Z_re Z_im];
        
        x = 0;
        y = 0;
        imre_com = 0;
        %% opt
        if count_p ~= number_of_elements+1
            for count_m = 1:1:length(f)
                x(1,count_m) = (real(Z(count_m)) - data_meas(count_m,2))^2;
               
                y(1,count_m) = (imag(Z(count_m)) - data_meas(count_m,3))^2;
                
                imre_com(1,count_m) = (x(1,count_m))^2 + (y(1,count_m))^2;
            end
            
            mat_par(1,m) = sum(imre_com);
            
            if m == length(eval(['p_',int2str(count_p)]))
                min_dat   = 0;
                min_index = 0;
                [min_dat,min_index] = min(mat_par);
                eval(['p',int2str(count_p),'= p_',int2str(count_p),'(min_index)'])
                eval(['p',int2str(count_p)])
                
            end
        else
            break
        end
        
    end
    
    
end
%% plots

fig1 = figure;
hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Xscale','log')
set(fig1,'position',[360   370   918   552])
plot(f,data_meas(:, 2),'r--','LineWidth',2)
plot(f,data_meas(:, 3),'b--','LineWidth',2)
plot(f,real(Z),'r','LineWidth',2)
plot(f,imag(Z),'b','LineWidth',2)

set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlabel('Frequency')
ylabel('Zm')
legend('Meas real','Meas imag','optim real','optim imag')
grid on

fig2 = figure;
hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(gca,'fontsize',14,'Xscale','log')
set(fig2,'position',[360   370   918   552])
plot(f,abs(data_meas(:, 2)+i*data_meas(:, 3)),'r--','LineWidth',2)
plot(f,abs(Z),'r','LineWidth',2)

set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz'])
xlabel('Frequency')
ylabel('Zm')
legend('Meas abs','optim abs')
grid on




