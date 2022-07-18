clc
clear all
close all

% Create an Excel file named myExample.xlsx.
values = {1, 2, 3; 4, 5, 6; 7, 8, 9};
headers = {'First','Second','Third'};
xlswrite('myExample.xlsx',[headers; values]);
% aqedan
filename = 'Transformer_N43_0.1A.xlsx';

status = xlsfinfo(filename)

[status,sheets] = xlsfinfo(filename)

[status,sheets,format] = xlsfinfo(filename)

pause
A = xlsread(filename,char(sheets(2)))

% xlswrite('myExample_test.xlsx',A);


columnB = xlsread(filename,'A:A')

% freq = columnB(1:801)