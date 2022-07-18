clear all
close all

flag = 1;   % (1) Triaxial Tube Method   (TTM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable
% (2) Probe Injection Method (PIM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable
% (3) Line Injection Method  (LIM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable

%% datvla exelis cxrilidan
R1    = 11
R2    = 50 % iyo 50 load of the injection circuit
% Rs    = 50*sqrt(1-(R1/50))
% Rp    = R1/(sqrt(1-(R1/50)))

Rs    = 120
Rp    = 60

Km    = (2*sqrt(R2/R1))/(1+(Rs+R2)*(Rp+R1)/(Rp*R1)) % datvla eqselis cxrilidan migebuli formulit
loss  = Km
%%


% COROPLAST FHLRG2GCB2G 1x25mm2 cable data

ZC = 12.3; % ar gamoiyeneba
% loss = 0.27; % <<< LOSSS chawere aq (kalkulatorit daitvale exselshi)
%% kley
d=0.185e-3;    % filament diameter
n=7;    %  number of filaments in each carrier
C=24;   %  number of carriers

D0 = 7.65e-3;  % diameter of core including conductor and insulation

wave_angle_deg = 30;

sigma_copper = 50e6;   % conductivity of the shield filaments
sigma_tin = 50e6;   % conductivity of the shield filaments

automatic_opt_cover = 1;
if  automatic_opt_cover == 0
    K_opt_cover = 0.983;
end
%%
switch flag
    case 1 % Triaxial Tube Method (TTM)for COROPLAST FHLRG2GCB2G 1x25mm2 cable
        file_1 =  'Closed_foil_soldered_termination_part_power_10dBm.s2p';
        data_T1 = read(rfdata.data,file_1);
        Freq                 = data_T1.freq;
        
        S_matrix_T1=extract(data_T1,'S-PARAMETERS');
        S21_T1 = S_matrix_T1(2,1,:);
        
        a_meas_1 = S21_T1(:);
        
        Lc_TTM=0.306; %  in m (sigrdze)
        
        R1N=39;    %inner circuit
        R1F=147;  %inner circuit for connector datuna 
        
        R2N=50;   %outer circuit
        R2F=0;    %outer circuit
        
        %km=ZC/(R1N+ZC);
        
        
        %Z_t_1 = ((R1F+ZC)*a_meas_1)/(2*Lc*km);   % see Mushtaq & Frei "Analysis of Shielding Effectiveness of HV Cable and Connector Systems used for Electric Vehicles"
        
        Zt_TTM_VNA_E5080A = ((R1F+R2N)*a_meas_1)/(2*Lc_TTM*loss);
        
        %Z_t_1 = (R1F*(R1F+50)*a_meas_1)/(sqrt(ZC*50)*Lc*km);
        
    case 2 % Probe Injection Method (PIM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable
        
        Lc_PIM=0.48; %  in m
        
        Data_file_PIM = read(rfdata.data,'PIM_Coroplast_1x25mm2_VNA_E5080A_DEC2019_IF_10Hz_N1.s3p');
        
        f_52         = load('F52_transfer_imp.dat');    % Transfer impedance of FCC F52 current probe from data sheet; MAG in dB
        f_52_impedance = f_52(:,2);
        
        Freq=Data_file_PIM.freq;
        S_matrix_data=extract(Data_file_PIM,'S-PARAMETERS');
        
        f_52_meas_VNA_E5080A  = interp1(f_52(:,1),f_52_impedance,Freq,'linear');
        
        for k=1:length(Freq)
            F140_TO_CABLE_VNA_E5080A(k) = S_matrix_data(2,1,k);
            F140_TO_F52_VNA_E5080A(k)   = S_matrix_data(3,2,k);
            
            Zt_PIM_VNA_E5080A(k,1) = (2/(Lc_PIM*loss)).*(F140_TO_CABLE_VNA_E5080A(k)./(F140_TO_F52_VNA_E5080A(k))).*10.^(f_52_meas_VNA_E5080A(k)/20);
        end
        
    case 3 % Line Injection Method (LIM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable
        
        Data_file_LIM = read(rfdata.data,'LIM_Coroplast_FHLR2GCB2G_1x25mm2_VNA_E5080A_DEC2019_IF_10Hz.s3p');
        
        Lc_LIM=0.445; % coupling length for LIM in m
        
        Freq=Data_file_LIM.freq;
        S_matrix_data=extract(Data_file_LIM,'S-PARAMETERS');
        
        for k=1:length(Freq)
            a_meas_5(k) = S_matrix_data(1,2,k);
            a_meas_6(k) = S_matrix_data(1,3,k);
        end
        
        
        R2N=50;
        R2F=50;
        
        Zt_LIM_near_VNA_E5080A     = ((2*R2N)/(Lc_LIM*loss))*(a_meas_5);
        Zt_LIM_far_VNA_E5080A      = ((2*R2N)/(Lc_LIM*loss))*(a_meas_6);
        
end


%======== Shield parameters for modeling =======

P=10/31e-3;   % number of carrier crossings per unit length (the picks)

Dm = D0+2*d;  % mean diameter a of the shield
b_shield = Dm/2;    %mean radius a of the shield

mu_0 = 4*pi*1e-7;          % permeability of free space
%sigma_copper = 57600000;   % conductivity of the shield filaments



d_foil = 0.015e-3;
sigma_foil = 2.5e6;
psi_foil = 45*pi/180;
M_foil = 1;
w_foil = 0;
a_foil = Dm/2+d;
b_foil =a_foil+a_foil/10;

%S=Levy(Freq,sigma_foil,d_foil);


wave_angle_rad = deg2rad(wave_angle_deg);

dR = (0.67*d)/sqrt(cos(wave_angle_rad));

b=((2*pi*Dm)/C)-((n*d)/cos(wave_angle_rad));

%=========== Calculations ================

del = sqrt(2./(2*pi*Freq*mu_0*sigma_tin));


R_shield = (4/(pi*d^2*n*C*sigma_copper*cos(wave_angle_rad)));

gamma = sqrt(j*2*pi*Freq*mu_0*sigma_copper);
Zd = R_shield*(gamma*dR./sinh(gamma*dR));

ZR = R_shield*(d*(1+j)./del)./sinh(d*(1+j)./del);

e = sqrt(1-tan(wave_angle_rad)^2);


[K, E] = ellipke(e);

F = n*d*C/(4*pi*b_shield*cos(wave_angle_rad));
F0 = F*cos(wave_angle_rad);

if automatic_opt_cover == 1
    K_opt_cover = 2*F-F^2
else
    K_opt_cover
end

M = (pi*mu_0/(6*C))*((1-K_opt_cover)^(3/2))*(e^2/(E-(1-e^2)*K));

Z_t_model_Vance = Zd + j*2*pi*Freq*M;

w=2*pi*Dm*(cos(wave_angle_rad)-n*d)/C;
h1 = 2*d/(1+w/d);
Lp= (mu_0*h1/(4*pi*Dm))*(1-tan(wave_angle_rad)^2);

Z_t_model_Tyni = Z_t_model_Vance - j*2*pi*Freq*Lp;

k_cable = (-1.16/(C*n*d))*atan(n/3)*sin(pi/2-2*wave_angle_rad)*sqrt(mu_0/sigma_copper);

Z_t_model_Demoulin = Z_t_model_Tyni + k_cable*sqrt(2*pi*Freq)*exp(j*pi/4);

% =================== Start Kley model =========================

tau_H = 9.6*F*(K_opt_cover^2*d/Dm)^(1/3);

Ma = 0.875*M*exp(-tau_H);

k1 = pi/(4*(2*F0/3+pi/10));
Lb = -0.11*mu_0*d*cos(2*k1*wave_angle_rad)/(2*pi*Dm*F0);

Lt = Ma+Lb;

tau_E = 12*F*(K_opt_cover^2*d/Dm)^(1/3);
Da = 10*pi*F0^2*cos(wave_angle_rad)*(1-F)*exp(-tau_E)/Dm;

k2 = pi/(4*(2*F0/3+3/8));
Db = -3.3*cos(2*k2*wave_angle_rad)/(2*pi*Dm*F0);

w_Ls = (1./(pi*sigma_tin*del)).*(Da+Db);

Z_t_model_Kley = ZR+w_Ls+(j*2*pi*Freq*Lt+j*w_Ls);

% =================== End Kley model =========================


% =================== Start Kley model + foil =========================

%Z_t_model_Kley_foil = ZR+w_Ls+(j*2*pi*Freq*Lt+j*w_Ls)./S;

% =================== End Kley model + foil =========================


disp(['L_T = ' num2str(1e9*Lt(1)) ' nH'])
disp(['M_a = ' num2str(1e9*Ma(1)) ' nH'])
disp(['L_b = ' num2str(1e9*Lb(1)) ' nH'])
disp(['L_s = ' num2str(1e9*w_Ls(1)/(2*pi*Freq(1))) ' nH'])


switch flag
    case 1
        fig = figure(3);
        hold on
        set(gca,'fontsize',14,'Xscale','log','Yscale','log')
        set(fig,'position',[360   200   758   500])
        plot(Freq,(abs(Zt_TTM_VNA_E5080A)),'k','linewidth',2)
%         plot(Freq,abs(Z_t_model_Kley),'m-','linewidth',2) % tu dagchirda
        %plot(f,abs(2*pi*f*Lt),'k','linewidth',2)
        %plot(f,abs(w_Ls),'c','linewidth',2)
        %plot(f,abs(Z_t_model_Kley_foil),'m','linewidth',2)
        grid on
        box on
        legend('Measurement','Kley Model')
        xlabel('Frequency')
        ylabel('Magnitude of transfer impedance [\Omega/m]')
        set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6 500e6]);
        set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz';'500MHz'])
        set(gca,'YTick',[1e-3 1e-2 1e-1 1e-0 1e1 1e2]);
        set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 '])
%         ylim([0.5e-3 0.53])
        xlim([9e3 500e6])
        title('Triaxial Tube Method (TTM) for con')
    case 2
        fig = figure(3);
        hold on
        set(gca,'fontsize',14,'Xscale','log','Yscale','log')
        set(fig,'position',[360   200   758   500])
        plot(Freq,(abs(Zt_PIM_VNA_E5080A)),'b','linewidth',2)
        plot(Freq,abs(Z_t_model_Kley),'m-','linewidth',2)
        %plot(f,abs(2*pi*f*Lt),'k','linewidth',2)
        %plot(f,abs(w_Ls),'c','linewidth',2)
        %plot(f,abs(Z_t_model_Kley_foil),'m','linewidth',2)
        grid on
        box on
        legend('Measurement','Kley Model')
        xlabel('Frequency')
        ylabel('Magnitude of transfer impedance [\Omega/m]')
        set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6 500e6]);
        set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz';'500MHz'])
        set(gca,'YTick',[1e-3 1e-2 1e-1 1e-0 1e1 1e2]);
        set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 '])
        ylim([0.5e-3 0.53])
        xlim([9e3 500e6])
        title('Probe Injection Method (PIM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable')
    case 3
        fig = figure(3);
        hold on
        set(gca,'fontsize',14,'Xscale','log','Yscale','log')
        set(fig,'position',[360   200   758   500])
        plot(Freq,(abs(Zt_LIM_near_VNA_E5080A)),'g','linewidth',2)
        plot(Freq,abs(Z_t_model_Kley),'m-','linewidth',2)
        %plot(f,abs(2*pi*f*Lt),'k','linewidth',2)
        %plot(f,abs(w_Ls),'c','linewidth',2)
        %plot(f,abs(Z_t_model_Kley_foil),'m','linewidth',2)
        grid on
        box on
        legend('Measurement','Kley Model')
        xlabel('Frequency')
        ylabel('Magnitude of transfer impedance [\Omega/m]')
        set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6 500e6]);
        set(gca,'XTickLabel',['100Hz ';'1kHz  ';'10kHz ';'100kHz';'1MHz  ';'10MHz ';'100MHz';'500MHz'])
        set(gca,'YTick',[1e-3 1e-2 1e-1 1e-0 1e1 1e2]);
        set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 '])
        ylim([0.5e-3 0.53])
        xlim([9e3 500e6])
        title('Line Injection Method (LIM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable')
end

% switch flag
%     case 1
%         fig = figure(4);
%         hold on
%         set(gca,'fontsize',14,'Xscale','log')
%         set(fig,'position',[86.2000 550 950.4000 441.6000])
%         plot(Freq,(real(Zt_TTM_VNA_E5080A)),'b','linewidth',2)
%         plot(Freq,(imag(Zt_TTM_VNA_E5080A)),'r','linewidth',2)
%         plot(Freq,real(Z_t_model_Kley),'c','linewidth',2)
%         plot(Freq,(imag(Z_t_model_Kley)),'m','linewidth',2)
%         grid on
%         box on
%         legend('Real MEAS','Imag MEAS','Real KLEY','Imag KLEY')
%         xlabel('Frequency [Hz]')
%         ylabel('Z_T_R \Omega/m')
%         set(gca,'XTick',[1e4 1e5 1e6 10e6 100e6 1e9]);
%         set(gca,'XTickLabel',['10k ';'100k';'1M  ';'10M ';'100M';'1G  '])
%         %set(gca,'YTick',[1e-3 1e-2 1e-1 1e-0 1e1 1e2]);
%         %set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 '])
%         ylim([-0.04 0.04])
%         xlim([5e3 500e6])
%         title('Triaxial Tube Method (TTM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable')
%     case 2
%         fig = figure(4);
%         hold on
%         set(gca,'fontsize',14,'Xscale','log')
%         set(fig,'position',[86.2000 550 950.4000 441.6000])
%         plot(Freq,(real(Zt_PIM_VNA_E5080A)),'b','linewidth',2)
%         plot(Freq,(imag(Zt_PIM_VNA_E5080A)),'r','linewidth',2)
%         plot(Freq,real(Z_t_model_Kley),'c','linewidth',2)
%         plot(Freq,(imag(Z_t_model_Kley)),'m','linewidth',2)
%         grid on
%         box on
%         legend('Real MEAS','Imag MEAS','Real KLEY','Imag KLEY')
%         xlabel('Frequency [Hz]')
%         ylabel('Z_T_R \Omega/m')
%         set(gca,'XTick',[1e4 1e5 1e6 10e6 100e6 1e9]);
%         set(gca,'XTickLabel',['10k ';'100k';'1M  ';'10M ';'100M';'1G  '])
%         %set(gca,'YTick',[1e-3 1e-2 1e-1 1e-0 1e1 1e2]);
%         %set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 '])
%         ylim([-0.04 0.04])
%         xlim([5e3 500e6])
%         title('Probe Injection Method (PIM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable')
%     case 3
%         fig = figure(4);
%         hold on
%         set(gca,'fontsize',14,'Xscale','log')
%         set(fig,'position',[86.2000 550 950.4000 441.6000])
%         plot(Freq,(real(Zt_LIM_far_VNA_E5080A)),'b','linewidth',2)
%         plot(Freq,(imag(Zt_LIM_far_VNA_E5080A)),'r','linewidth',2)
%         plot(Freq,real(Z_t_model_Kley),'c','linewidth',2)
%         plot(Freq,(imag(Z_t_model_Kley)),'m','linewidth',2)
%         grid on
%         box on
%         legend('Real MEAS','Imag MEAS','Real KLEY','Imag KLEY')
%         xlabel('Frequency [Hz]')
%         ylabel('Z_T_R \Omega/m')
%         set(gca,'XTick',[1e4 1e5 1e6 10e6 100e6 1e9]);
%         set(gca,'XTickLabel',['10k ';'100k';'1M  ';'10M ';'100M';'1G  '])
%         %set(gca,'YTick',[1e-3 1e-2 1e-1 1e-0 1e1 1e2]);
%         %set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 '])
%         ylim([-0.04 0.04])
%         xlim([5e3 500e6])
%         title('Line Injection Method (LIM) for COROPLAST FHLRG2GCB2G 1x25mm2 cable')
% end


% for_save_meas = [Freq_PIM real(Zt_PIM_VNA_E5080A) imag(Zt_PIM_VNA_E5080A)];
% for_save_sim = [Freq_PIM real(Z_t_model_Kley) imag(Z_t_model_Kley)];
%
%
% switch flag
%     case 1
%         save SIM_ZT_COROPLAST_1x25mm2.s1p  for_save_sim  -ascii
%     case 2
%         save SIM_ZT_COROPLAST_1x50mm2.s1p  for_save_sim  -ascii
%     case 3
%         save SIM_ZT_COROPLAST_1x70mm2.s1p  for_save_sim  -ascii
%     case 4
%         save ZT_COROPLAST_2x6mm2.s1p  for_save_meas  -ascii
%     case 5
%         save ZT_COROPLAST_4x6mm2.s1p  for_save_meas  -ascii
%     case 6
%         save ZT_ACOME_4x6mm2.s1p  for_save_meas  -ascii
% end

