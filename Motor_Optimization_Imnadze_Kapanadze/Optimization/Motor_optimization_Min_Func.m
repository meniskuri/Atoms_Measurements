close all
clear all
clc

format long

%% global parameters
global f data_meas

%% circuit parameters
%% measured motor data and optimization parameters
number_of_elements   = 24;
number_of_iterations = 20;

% data_meas            = load('Motor_optimization\green_load_load.dat'); % <=== emcos motor
data_meas            = load('Motor_optimization\Z_meas_YANMAR_MOTOR.dat'); % <=== yanmar motor
f                    = data_meas(:, 1);
final_dat            = zeros(1,number_of_elements+1); % am vectorshi chaiwereba minimaluri procenti da misi koordinatebi

p_1 = 5e-3; % p1_min = ; p1_max = ;  % R22 R26 R30 % vtoveb 
p_2 = 1e6; % R31 % vtoveb
p_6 = 3e-10; % C17 % min
p_7 = 2e-11; % C18 % max
p_8 = 1e-10; % C19 % min
p_11 = 1e-3; % R32 % no change
p_14 = 200e-9; % L12 L3 L11 % vtoveb  <===
p_15 = 80e-9; % C22 C23 C24 % vtoveb
p_16 = 18; % R57 R58 R59 % vtoveb
p_17 = 10e-3; % R60 R61 R62 % vtoveb
p_18 = 3e-10; % C25 % max
p_19 = 2e-11; % C26 % max
p_20 = 1e-10; % C27 % min
p_21 = 3e-10; % C30 % max
p_22 = 2e-11; % C31 % min
p_23 = 1e-10; % C32 % min
p_24 = 110e-6; % L13 L14 L15 % vtoveb  <===

x3  = 1e-9;
y3  = 1.5e-9;
x4  = 0.1e-6;
y4  = 300e-6; % yanmar
% y4  = 20e-6; % emcos
x5  = 0.1e-6;
y5  = 300e-6; % yanmar
% y5  = 20e-6; % emcos
x9  = 1.7e-12;
y9  = 1.7e-9;
x10  = 200e-14;
y10  = 200e-12;
x12  = 300;
y12  = 500;
x13  = 100;
y13  = 500;

 N   = 3; % number of elements in each vector

for N_I = 1:number_of_iterations
    %N   = 3; % number of elements in each vector
    
    p_3 = linspace(x3,y3,N); % C9 % vtoveb  <===
    
    
    p_4 = linspace(x4,y4,N); % L1 L16 L18 = p4 p18 p27 % vcvli  <===
    
    
    p_5 = linspace(x5,y5,N); % L2 L17 L19 = p5 p19 p28 % vcvli  <===
    
    
    p_9  = linspace(x9,y9,N); % C20 C28 C33 = p9 p23 p32% vcvli  <===
    
    
    p_10 = linspace(x10,y10,N); % C21 C29 C34 = p10 p24 p33% vcvlin  <===
    
    
    p_12 = linspace(x12,y12,N); % R33 R63 R65 = p12 p25 p34 % vcvli  <===
    
    
    p_13 = linspace(x13,y13,N); % R34 R64 R66 = p13 p26 p35 % vcvli  <===
    
    count = 0;
    for m1 = 1:length(p_3);
        for m2 = 1:length(p_4);
            for m3 = 1:length(p_5);
                for m4 = 1:length(p_9);
                    for m5 = 1:length(p_10);
                        for m6 = 1:length(p_12);
                            for m7 = 1:length(p_13);
                                
                                % opt algorithm func
                                [Z,mat_par] = OPT_FUNC_RUN_SPICE(p_1,p_2,p_3(m1),p_4(m2),...
                                    p_5(m3),p_6,p_7,p_8,p_9(m4),p_10(m5),p_11,p_12(m6),p_13(m7),...
                                    p_14,p_15,p_16,p_17,p_18,p_19,p_20,p_21,p_22,p_23,p_24);
                                
                                count = count + 1;
                                
                                for k=1:(number_of_elements + 1)
                                    if k ~= number_of_elements + 1
                                        if k ~= 3 && k ~= 4 && k ~= 5 && k ~= 9 && k ~= 10 && k ~= 12 && k ~= 13
                                            output_data(count,k) = eval(['p_',int2str(k),';']);
                                        else
                                            switch k
                                                case 3
                                                    output_data(count,k) = eval(['p_',int2str(k),'(m1);']);
                                                case 4
                                                    output_data(count,k) = eval(['p_',int2str(k),'(m2);']);
                                                case 5
                                                    output_data(count,k) = eval(['p_',int2str(k),'(m3);']);
                                                case 9
                                                    output_data(count,k) = eval(['p_',int2str(k),'(m4);']);
                                                case 10
                                                    output_data(count,k) = eval(['p_',int2str(k),'(m5);']);
                                                case 12
                                                    output_data(count,k) = eval(['p_',int2str(k),'(m6);']);
                                                case 13
                                                    output_data(count,k) = eval(['p_',int2str(k),'(m7);']);
                                            end
                                        end
                                    else
                                        output_data(count,k) = mat_par;
                                    end
                                end
                                
                            end
                        end
                    end
                end
            end
        end
    end
    
    
    
    % final_data chaiwereba aq
    if N_I == 1
        min_dat_output   = 0;
        min_index_output = 0;
        [min_dat_output,min_index_output] = min(output_data(:,number_of_elements+1));
        final_dat = output_data(min_index_output,:);
    else
        min_dat_output   = 0;
        min_index_output = 0;
        [min_dat_output,min_index_output] = min(output_data(:,number_of_elements+1));
        if min_dat_output < final_dat(number_of_elements+1)
            final_dat = output_data(min_index_output,:);
        else
            min_dat_output   = 0;
            min_index_output = 0;
        end
    end
    
    % vamushaveb output_datas vezeb pikebs da mozebnili pikebidan virchev
    % at sauketeso variants tavisi koordinatebit romelsac vugzavni grads
    ni = (1:length(output_data(:,1)))';
    w  = [ni output_data(:,length(output_data(1,:)))];
    
    x_lok = w(2,2);
    y_lok = 0;
    f_lok = 0;
    count_n = 0;
    count_1 = 1;
    count_index = 0;
    dat_for_grad = zeros(1,length(output_data(1,:))-1); % datas for grad
    dat_for_grad_chek = zeros(1,length(output_data(1,:))); % datas for analog to grad but + error (to save)
    gr_magn = 0; % yvelaze kargi gradientistvis monacemebi (titoeuli iteraciistvis)
    G = 0; % gradientebis matrica (titoeuli iteraciistvis)
    G_max = 0; % gradientebis matricidan yvelaze kargi gradient vectori (titoeuli iteraciistvis)
    
    for n=3:1:length(w)
        
        if n==3 && (x_lok<=w(1,2) || x_lok>=w(1,2))
            y_lok(count_1,1) = w(1,2);
            f_lok(count_1,1) = w(1,1);
            x_lok = w(n,2);
            count_index(count_1) = 1;
            count_1 = count_1 + 1;
        elseif n==length(w) && x_lok<=w(length(w),2)
            y_lok(count_1,1) = w(length(w),2);
            f_lok(count_1,1) = w(length(w),1);
            x_lok = w(n,2);
            count_index(count_1) = length(w);
            count_1 = count_1 + 1;
        else
            if ((x_lok<=w(n-2,2) && x_lok<=w(n,2)))
                y_lok(count_1,1) = w(n-1,2);
                f_lok(count_1,1) = w(n-1,1);
                x_lok = w(n,2);
                count_index(count_1) = n-1; % <== count index !!!!
                count_1 = count_1 + 1;
            else
                x_lok = w(n,2);
            end
            
        end
    end
    
    count_1   = 0;
    n         = 0;
    t          = [f_lok, y_lok];
    
    %% 10 sauketeso varianti
    [B, IX]   = sort(t);
    t         = [f_lok(IX(1:10,2)) B(1:10,2)];
    
    %% mozebne output shi sauketeso ati da chawere koordinatebi dat_for_grad shi
    for m = 1:length(t)
        dat_for_grad(m,:) = output_data(t(m,1),1:((length(output_data(1,:)))-1));
    end
    % viwer monacemebs dat_for_grad_chek shi shesamowmeblad da vinaxav
    % yovel iteraciaze 10 archeul sauketeso variants inaxavs
    for m = 1:length(t)
        dat_for_grad_chek(m,:) = output_data(t(m,1),1:((length(output_data(1,:)))));
    end
    eval(['save(''dat_for_grad',int2str(N_I),'.dat'',''dat_for_grad_chek'',''-ascii'')']) % <=== chawers tvitoeuli iteraciistvis 10 sauketeso variants shesamowmeblad
    %% vugzavni dat_for_grad s gradientebis funqcias _ vawvdi mxolod parametrebs dat_for_grad it da errors ara
    [gr_magn,G,G_max]= GradF(dat_for_grad);  % <=== es unda davabrunebino main funqciit
    
    %% unda shevcvalo parametrebi gradientis nishnis mixedvit
    if  N_I ~= number_of_iterations
        for k1 = 1:length(G_max)  % <=== mosafiqrebeli !!!!
            
            if k1 ~= 3 && k1 ~= 4 && k1 ~= 5 && k1 ~= 9 && k1 ~= 10 && k1 ~= 12 && k1 ~= 13
                
                if G_max(k1)>0
                    eval(['p_',int2str(k1),'= (gr_magn(',int2str(k1),'))*95/100'])
                end
                if G_max(k1)<0
                    eval(['p_',int2str(k1),'= (gr_magn(',int2str(k1),'))*105/100'])
                else
                    eval(['p_',int2str(k1),'= gr_magn(',int2str(k1),')'])
                end
                
            else
                switch k1
                    case 3
                        % p_3(1)
                        if G_max(k1)>0 && gr_magn(k1) == p_3(1)
                            x3 = x3;
                            y3 = (p_3(2)+p_3(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_3(1)
                            x3 = x3;
                            y3 = (p_3(2)+p_3(3))/2;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_3(1)
                            x3 = x3;
                            y3 = (p_3(2)+p_3(3))/2;
                        end
                        % p_3(2)
                        if G_max(k1)>0 && gr_magn(k1) == p_3(2)
                            x3 = x3;
                            y3 = (p_3(2)+p_3(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_3(2)
                            x3 = (p_3(1)+p_3(2))/2;
                            y3 = y3;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_3(2)
                            x3 = (p_3(1)+p_3(2))/2;
                            y3 = (p_3(2)+p_3(3))/2;
                        end
                        % p_3(3)
                        if G_max(k1)>0 && gr_magn(k1) == p_3(3)
                            x3 = (p_3(1)+p_3(2))/2;
                            y3 = y3;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_3(3)
                            x3 = (p_3(1)+p_3(2))/2;
                            y3 = y3;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_3(3)
                            x3 = (p_3(1)+p_3(2))/2;
                            y3 = y3;
                        end
                        %
                    case 4
                        % p_4(1)
                        if G_max(k1)>0 && gr_magn(k1) == p_4(1)
                            x4 = x4;
                            y4 = (p_4(2)+p_4(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_4(1)
                            x4 = x4;
                            y4 = (p_4(2)+p_4(3))/2;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_4(1)
                            x4 = x4;
                            y4 = (p_4(2)+p_4(3))/2;
                        end
                        % p_4(2)
                        if G_max(k1)>0 && gr_magn(k1) == p_4(2)
                            x4 = x4;
                            y4 = (p_4(2)+p_4(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_4(2)
                            x4 = (p_4(1)+p_4(2))/2;
                            y4 = y4;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_4(2)
                            x4 = (p_4(1)+p_4(2))/2;
                            y4 = (p_4(2)+p_4(3))/2;
                        end
                        % p_4(3)
                        if G_max(k1)>0 && gr_magn(k1) == p_4(3)
                            x4 = (p_4(1)+p_4(2))/2;
                            y4 = y4;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_4(3)
                            x4 = (p_4(1)+p_4(2))/2;
                            y4 = y4;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_4(3)
                            x4 = (p_4(1)+p_4(2))/2;
                            y4 = y4;
                        end
                        %
                    case 5
                        % p_5(1)
                        if G_max(k1)>0 && gr_magn(k1) == p_5(1)
                            x5 = x5;
                            y5 = (p_5(2)+p_5(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_5(1)
                            x5 = x5;
                            y5 = (p_5(2)+p_5(3))/2;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_5(1)
                            x5 = x5;
                            y5 = (p_5(2)+p_5(3))/2;
                        end
                        % p_5(2)
                        if G_max(k1)>0 && gr_magn(k1) == p_5(2)
                            x5 = x5;
                            y5 = (p_5(2)+p_5(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_5(2)
                            x5 = (p_5(1)+p_5(2))/2;
                            y5 = y5;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_5(2)
                            x5 = (p_5(1)+p_5(2))/2;
                            y5 = (p_5(2)+p_5(3))/2;
                        end
                        % p_5(3)
                        if G_max(k1)>0 && gr_magn(k1) == p_5(3)
                            x5 = (p_5(1)+p_5(2))/2;
                            y5 = y5;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_5(3)
                            x5 = (p_5(1)+p_5(2))/2;
                            y5 = y5;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_5(3)
                            x5 = (p_5(1)+p_5(2))/2;
                            y5 = y5;
                        end
                        %
                    case 9
                        % p_9(1)
                        if G_max(k1)>0 && gr_magn(k1) == p_9(1)
                            x9 = x9;
                            y9 = (p_9(2)+p_9(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_9(1)
                            x9 = x9;
                            y9 = (p_9(2)+p_9(3))/2;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_9(1)
                            x9 = x9;
                            y9 = (p_9(2)+p_9(3))/2;
                        end
                        % p_9(2)
                        if G_max(k1)>0 && gr_magn(k1) == p_9(2)
                            x9 = x9;
                            y9 = (p_9(2)+p_9(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_9(2)
                            x9 = (p_9(1)+p_9(2))/2;
                            y9 = y9;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_9(2)
                            x9 = (p_9(1)+p_9(2))/2;
                            y9 = (p_9(2)+p_9(3))/2;
                        end
                        % p_9(3)
                        if G_max(k1)>0 && gr_magn(k1) == p_9(3)
                            x9 = (p_9(1)+p_9(2))/2;
                            y9 = y9;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_9(3)
                            x9 = (p_9(1)+p_9(2))/2;
                            y9 = y9;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_9(3)
                            x9 = (p_9(1)+p_9(2))/2;
                            y9 = y9;
                        end
                        %
                    case 10
                        % p_10(1)
                        if G_max(k1)>0 && gr_magn(k1) == p_10(1)
                            x10 = x10;
                            y10 = (p_10(2)+p_10(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_10(1)
                            x10 = x10;
                            y10 = (p_10(2)+p_10(3))/2;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_10(1)
                            x10 = x10;
                            y10 = (p_10(2)+p_10(3))/2;
                        end
                        % p_10(2)
                        if G_max(k1)>0 && gr_magn(k1) == p_10(2)
                            x10 = x10;
                            y10 = (p_10(2)+p_10(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_10(2)
                            x10 = (p_10(1)+p_10(2))/2;
                            y10 = y10;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_10(2)
                            x10 = (p_10(1)+p_10(2))/2;
                            y10 = (p_10(2)+p_10(3))/2;
                        end
                        % p_10(3)
                        if G_max(k1)>0 && gr_magn(k1) == p_10(3)
                            x10 = (p_10(1)+p_10(2))/2;
                            y10 = y10;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_10(3)
                            x10 = (p_10(1)+p_10(2))/2;
                            y10 = y10;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_10(3)
                            x10 = (p_10(1)+p_10(2))/2;
                            y10 = y10;
                        end
                        %
                    case 12
                        % p_12(1)
                        if G_max(k1)>0 && gr_magn(k1) == p_12(1)
                            x12 = x12;
                            y12 = (p_12(2)+p_12(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_12(1)
                            x12 = x12;
                            y12 = (p_12(2)+p_12(3))/2;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_12(1)
                            x12 = x12;
                            y12 = (p_12(2)+p_12(3))/2;
                        end
                        % p_12(2)
                        if G_max(k1)>0 && gr_magn(k1) == p_12(2)
                            x12 = x12;
                            y12 = (p_12(2)+p_12(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_12(2)
                            x12 = (p_12(1)+p_12(2))/2;
                            y12 = y12;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_12(2)
                            x12 = (p_12(1)+p_12(2))/2;
                            y12 = (p_12(2)+p_12(3))/2;
                        end
                        % p_12(3)
                        if G_max(k1)>0 && gr_magn(k1) == p_12(3)
                            x12 = (p_12(1)+p_12(2))/2;
                            y12 = y12;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_12(3)
                            x12 = (p_12(1)+p_12(2))/2;
                            y12 = y12;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_12(3)
                            x12 = (p_12(1)+p_12(2))/2;
                            y12 = y12;
                        end
                        %
                    case 13
                        % p_13(1)
                        if G_max(k1)>0 && gr_magn(k1) == p_13(1)
                            x13 = x13;
                            y13 = (p_13(2)+p_13(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_13(1)
                            x13 = x13;
                            y13 = (p_13(2)+p_13(3))/2;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_13(1)
                            x13 = x13;
                            y13 = (p_13(2)+p_13(3))/2;
                        end
                        % p_13(2)
                        if G_max(k1)>0 && gr_magn(k1) == p_13(2)
                            x13 = x13;
                            y13 = (p_13(2)+p_13(3))/2;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_13(2)
                            x13 = (p_13(1)+p_13(2))/2;
                            y13 = y13;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_13(2)
                            x13 = (p_13(1)+p_13(2))/2;
                            y13 = (p_13(2)+p_13(3))/2;
                        end
                        % p_13(3)
                        if G_max(k1)>0 && gr_magn(k1) == p_13(3)
                            x13 = (p_13(1)+p_13(2))/2;
                            y13 = y13;
                        end
                        if G_max(k1)<0 && gr_magn(k1) == p_13(3)
                            x13 = (p_13(1)+p_13(2))/2;
                            y13 = y13;
                        end
                        if G_max(k1)==0 && gr_magn(k1) == p_13(3)
                            x13 = (p_13(1)+p_13(2))/2;
                            y13 = y13;
                        end
                        %
                end
            end
            
        end
    end
    
     N   = 3; 
    
end

%% roca morcheba zeda cikls da momcems ragac vectors yvelaze kargi gradientistvis am vectors davatrialeb 3000 jer
% da vnaxav ras mivigeb mere am yvelafers shevadareb final_dat is procents
% da romelic uketesi iqneba imas davxatav TEST VARIANT!!!!!!!
dat_for_grad_2 = gr_magn;

for k2 = 1:2500 % <====
    gr_magn = 0;
    G       = 0;
    G_max   = 0;
    
    [gr_magn,G,G_max]= GradF(dat_for_grad_2);
    
    for k3 = 1:length(G_max)
        if G_max(k3)>0
%   dasamtavrebeli ====>%          if eval(['(gr_magn(',int2str(k3),'))*95/100 ~> p',int2str(k3),'_min'])
            eval(['p_',int2str(k3),'= (gr_magn(',int2str(k3),'))*95/100'])
%             else
                
        end
        if G_max(k3)<0
            eval(['p_',int2str(k3),'= (gr_magn(',int2str(k3),'))*105/100'])
        else
            eval(['p_',int2str(k3),'= gr_magn(',int2str(k3),')'])
        end
    end
    
    dat_for_grad_2 = [p_1 p_2 p_3 p_4 p_5 p_6 p_7 p_8 p_9 p_10 p_11 p_12 p_13 ...
        p_14 p_15 p_16 p_17 p_18 p_19 p_20 p_21 p_22 p_23 p_24];
    
end

Z       = 0;
mat_par = 0;

[Z,mat_par] = OPT_FUNC_RUN_SPICE(p_1,p_2,p_3,p_4,...
    p_5,p_6,p_7,p_8,p_9,p_10,p_11,p_12,p_13,...
    p_14,p_15,p_16,p_17,p_18,p_19,p_20,p_21,p_22,p_23,p_24);


if mat_par > final_dat(number_of_elements+1)
    Z       = 0;
    mat_par = 0;
    [Z,mat_par] = OPT_FUNC_RUN_SPICE(final_dat(1),final_dat(2),final_dat(3),final_dat(4),...
        final_dat(5),final_dat(6),final_dat(7),final_dat(8),final_dat(9),final_dat(10),final_dat(11),final_dat(12),final_dat(13),...
        final_dat(14),final_dat(15),final_dat(16),final_dat(17),final_dat(18),final_dat(19),final_dat(20),final_dat(21),final_dat(22),final_dat(23),final_dat(24));
end

%% plots
% archeuli parametrebit vushveb LTspices
% Z       = 0;
% mat_par = 0;
% [Z,mat_par] = OPT_FUNC_RUN_SPICE(gr_magn(1),gr_magn(2),gr_magn(3),gr_magn(4),...
%     gr_magn(5),gr_magn(6),gr_magn(7),gr_magn(8),gr_magn(9),gr_magn(10),gr_magn(11),gr_magn(12),gr_magn(13),...
%     gr_magn(14),gr_magn(15),gr_magn(16),gr_magn(17),gr_magn(18),gr_magn(19),gr_magn(20),gr_magn(21),gr_magn(22),gr_magn(23),gr_magn(24));

%% save data

%% plot
fig1 = figure;
hold on
set(gca,'fontsize',14,'xscale','log','yscale','log')
%set(gca,'fontsize',14,'xscale','log')
set(fig1,'position',[70  100   1250   500])
plot(ni,w(:,2),'r','linewidth',2)
plot(t(:,1),t(:,2),'bo','linewidth',2)
set(gca,'ytick',[0 5 10 27 40 60 80 100 120 150]);
set(gca,'yticklabel',['0%  ';'5%  ';'10% ';'27% ';'40% ';'60% ';'80% ';'100%';'120%';'150%'])
set(gca,'xtick',[10 100 500 1e3 1.5e3 2.100e3]);
set(gca,'xticklabel',['10  ';'100 ';'500 ';'1k  ';'1.5k';'2k  ';'2.1k'])
xlabel('iteration numbers')
ylabel('error')
legend('opt abs','opt abs pikebi')
xlim([0 2300])
ylim([0 150])
grid on

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
eval(['ylabel(''\Omega _ number of iterations ',int2str(N_I),''')'])
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
eval(['ylabel(''\Omega _ number of iterations ',int2str(N_I),''')'])
legend('Meas abs','optim abs')
eval(['title(''',num2str(mat_par),' % '')'])
grid on

