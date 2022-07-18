clc
clear all
close all

a(:,1) = 1:1:180;
b(:,1) = 1:1:180

for w = 1:1:180
    
    if w == 1
        r(w) = 0;
    else
        r(w,1) = w*2.0; % 180 wertilis shemtxveva
    end
    
    if (w == 180)
        r(w) = 360;
    end
    
    d(w,1) = ceil((32*sind(r(w))+31)/2);
%     d(w,1) = ceil((32*sind(r(w))));

    iseven = rem(w, 2) == 0
    if iseven == 0
    l(w,1) = 32;
    else
    l(w,1) = 0;   
    end
        
end

sinDat_0_360Dg_180Po = [a(:,1) d(:,1)];
Dat_32_0 = [b(:,1) l(:,1)];

FileName = 'sinDat_0_360Dg_180Po.dat';
fid = fopen(FileName, 'w');

for k = 1:180
   fprintf(fid,'%5d  %5d\n',            sinDat_0_360Dg_180Po(k,1),sinDat_0_360Dg_180Po(k,2));
end
fclose(fid);

clear k

FileName = 'Dat_32_0.dat';
fid = fopen(FileName, 'w');

for k = 1:180
   fprintf(fid,'%5d  %5d\n',            Dat_32_0(k,1),Dat_32_0(k,2));
end
fclose(fid);


%% samushao kodi ==========================================================
% l(:,1) = 1:1:360;
% b(:,1) = randi([0 60],1,176);
% 
% d = zeros(176,1);
% for k = 1:1:360
%     if k == 1
%         p = 0;
%         d(k) = (60*sind(p)+60)/2;
%     else
%         d(k) = (60*sind(k)+60)/2;
%     end
% end
% 
% si_ndat        = [l(:,1) d(:,1)];
% inter_sin      = interp1(si_ndat(:,1),si_ndat(:,2),r(:,1),'linear');
% inter_sin_data = [r(:,1) inter_sin(:,1)];
% 
% c = zeros(176,1);
% for n = 1:1:176
%     if n<10
%         c(n) = 10;
%     elseif (n>=10 & n<20)
%         c(n)=2;
%     else
%         c(n)=30;
%     end
% end
%% ========================================================================

fig3 = figure;
hold on
% set(gca,'fontsize',14,'Xscale','log','Yscale','log')
set(fig3,'position',[680   423   671   355])
% plot(r(:,1),d(:,1),'k','LineWidth',2)
plot(r(:,1),sinDat_0_360Dg_180Po(:,2),'r','LineWidth',2)
plot(r(:,1),Dat_32_0(:,2),'r','LineWidth',2)
% set(gca,'YTick',[1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3 1e4 1e5 1e6]);
% set(gca,'YTickLabel',['1m  ';'10m ';'100m';'1   ';'10  ';'100 ';'1k  ';'10k ';'100k';'1M  '])
% set(gca,'XTick',[100 1e3 1e4 1e5 1e6 10e6 100e6]);
title('ceil(sind(x)); x=0-360(degree); 180Points')
xlabel('degrees') 
ylabel('sind(x)')
legend('')
grid on
box on


