clc
clear all
close all
global data_meas f
dat1            = load('output.dat');
data_meas       = load('Motor_optimization\green_load_load.dat');
f               = data_meas(:, 1);

%% test final_data
number_of_elements = 24;
final_dat          = zeros(1,number_of_elements+1);
if number_of_elements == 23
    min_dat_output   = 0;
    min_index_output = 0;
    [min_dat_output,min_index_output] = min(dat1(:,number_of_elements+1));
    final_dat = dat1(min_index_output,:);
else
    min_dat_output   = 0;
    min_index_output = 0;
    [min_dat_output,min_index_output] = min(dat1(:,number_of_elements+1));
    final_dat = dat1(min_index_output,:);
end
break
%%
ni = (1:length(dat1(:,1)))';
w  = [ni dat1(:,length(dat1(1,:)))];

x_lok = w(2,2);
y_lok = 0;
f_lok = 0;
count_n = 0;
count_1 = 1;
count_index = 0;
dat_for_grad = zeros(1,length(dat1(1,:))-1);

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


% 10 sauketeso varianti
[B, IX]   = sort(t);
t           = [f_lok(IX(1:10,2)) B(1:10,2)];
% mozebne dat1 shi sauketeso ati da chawere koordinatebi
for m = 1:length(t)
    dat_for_grad(m,:) = dat1(t(m,1),1:((length(dat1(1,:)))-1));
end

% vugzavni dat_for_grad s gradientebis funqcias
[gr_magn,G,G_max]= GradF(dat_for_grad);  % <=== es unda davabrunebino main funqciit
% %% unda shevcvalo parametrebi gradientis nishnis mixedvit
% for k1 = 1:length(gr_magn)  % <=== mosafiqrebeli !!!!
%
%     if gr_magn (k1)
%     end
%
% end
%% < ==== es gasaketebeli maqvss !!!!!!!!!!!!!!!!!!!!!!!!!!!

%%archeuli parametrebit vushveb LTspices
[Z,mat_par] = OPT_FUNC_RUN_SPICE(gr_magn(1),gr_magn(2),gr_magn(3),gr_magn(4),...
    gr_magn(5),gr_magn(6),gr_magn(7),gr_magn(8),gr_magn(9),gr_magn(10),gr_magn(11),gr_magn(12),gr_magn(13),...
    gr_magn(14),gr_magn(15),gr_magn(16),gr_magn(17),gr_magn(18),gr_magn(19),gr_magn(20),gr_magn(21),gr_magn(22),gr_magn(23),gr_magn(24));

% plot
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
ylabel('\Omega _ First Aproximation')
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
ylabel('\Omega _ First Aproximation')
legend('Meas abs','optim abs')
eval(['title(''',num2str(mat_par),' % '')'])
grid on

% min_dat   = 0;
% min_index = 0;
% [min_dat,min_index] = min(w(:,2));
