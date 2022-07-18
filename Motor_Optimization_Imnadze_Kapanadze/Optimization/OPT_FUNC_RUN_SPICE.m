function [Z,mat_par] = OPT_FUNC_RUN_SPICE(p_1,p_2,p_3,p_4,p_5,p_6,p_7,p_8,p_9,p_10,p_11,p_12,p_13,...
    p_14,p_15,p_16,p_17,p_18,p_19,p_20,p_21,p_22,p_23,p_24)

p1  = p_1;
p2  = p_2;
p3  = p_3;
p4  = p_4;
p5  = p_5;
p6  = p_6;
p7  = p_7;
p8  = p_8;
p9  = p_9;
p10 = p_10;
p11 = p_11;
p12 = p_12;
p13 = p_13;
p14 = p_14;
p15 = p_15;
p16 = p_16;
p17 = p_17;
p18 = p_18;
p19 = p_19;
p20 = p_20;
p21 = p_21;
p22 = p_22;
p23 = p_23;
p24 = p_24;

%% global parameters
global f data_meas

%% set_cir_param
mat_par            = 0;
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
fprintf(fid_w, 'L13 N006 N007 %s\n', num2str(p24));
fprintf(fid_w, 'L14 N011 N012 %s\n', num2str(p24));
fprintf(fid_w, 'L15 N018 N015 %s\n', num2str(p24));
fprintf(fid_w, 'C22 N007 N005 %s\n', num2str(p15));
fprintf(fid_w, 'C23 N012 N010 %s\n', num2str(p15));
fprintf(fid_w, 'C24 N015 N014 %s\n', num2str(p15));
fprintf(fid_w, 'R57 N012 N010 %s\n', num2str(p16));
fprintf(fid_w, 'R58 N015 N014 %s\n', num2str(p16));
fprintf(fid_w, 'R59 N007 N005 %s\n', num2str(p16));
fprintf(fid_w, 'R60 N006 N005 %s\n', num2str(p17));
fprintf(fid_w, 'R61 N011 N010 %s\n', num2str(p17));
fprintf(fid_w, 'R62 N018 N014 %s\n', num2str(p17));
fprintf(fid_w, 'L16 N009 N008 %s\n', num2str(p4));
fprintf(fid_w, 'L17 N003 N009 %s\n', num2str(p5));
fprintf(fid_w, 'C25 N008 0 %s\n', num2str(p18));
fprintf(fid_w, 'C26 N009 0 %s\n', num2str(p19));
fprintf(fid_w, 'C27 N003 0 %s\n', num2str(p20));
fprintf(fid_w, 'C28 N009 N008 %s\n', num2str(p9));
fprintf(fid_w, 'C29 N003 N009 %s\n', num2str(p10));
fprintf(fid_w, 'R63 N009 N008 %s\n', num2str(p12));
fprintf(fid_w, 'R64 N003 N009 %s\n', num2str(p13));
fprintf(fid_w, 'L18 N017 N016 %s\n', num2str(p4));
fprintf(fid_w, 'L19 N003 N017 %s\n', num2str(p5));
fprintf(fid_w, 'C30 N016 0 %s\n', num2str(p21));
fprintf(fid_w, 'C31 N017 0 %s\n', num2str(p22));
fprintf(fid_w, 'C32 N003 0 %s\n', num2str(p23));
fprintf(fid_w, 'C33 N017 N016 %s\n', num2str(p9));
fprintf(fid_w, 'C34 N003 N017 %s\n', num2str(p10));
fprintf(fid_w, 'R65 N017 N016 %s\n', num2str(p12));
fprintf(fid_w, 'R66 N003 N017 %s\n', num2str(p13));

%% aqamde

fprintf(fid_w, 'V1 N004 0 AC 1 0 %s\n\n', '');

% fprintf(fid_w, '.ac oct 64 9K 50Meg %s\n', ''); % form emcos motor
fprintf(fid_w, '.ac oct 64 40 50Meg %s\n', ''); % form yanmar motor
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
Z         = (-Z_complex);  % complex optimization impedance
Z_re      = real(Z_complex);
Z_im      = imag(Z_complex);
res_data  = [f  Z_re Z_im];

x = 0;
y = 0;
% ?
for count_m = 1:1:length(f)
    x(1,count_m) = (abs((data_meas(count_m, 2)+1i*data_meas(count_m, 3)) - Z(count_m))).^2;
    y(1,count_m) = (abs(data_meas(count_m, 2)+1i*data_meas(count_m, 3))).^2;
end

mat_par = 100*(sqrt(sum(x)))/(sqrt(sum(y)));

