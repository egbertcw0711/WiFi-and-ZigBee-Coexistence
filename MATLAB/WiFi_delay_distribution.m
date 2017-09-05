close all;
clear

f0 = fopen('./data/Delay_0.txt');
f1 = fopen('./data/Delay_1_100.txt');
f2 = fopen('./data/Delay_2_200.txt');
f3 = fopen('./data/Delay_3_300.txt');
f4 = fopen('./data/Delay_4_500.txt');

f5 = fopen('./data/Delay_5_1000.txt');
f6 = fopen('./data/Delay_6_2000.txt');
f7 = fopen('./data/Delay_7_4000.txt');
f8 = fopen('./data/Delay_8_8000.txt');

formatSpec = '%d';
sizeA = [1, inf];

data0 = fscanf(f0, formatSpec, sizeA);
data1 = fscanf(f1, formatSpec, sizeA);
data2 = fscanf(f2, formatSpec, sizeA);
data3 = fscanf(f3, formatSpec, sizeA);
data4 = fscanf(f4, formatSpec, sizeA);

data5 = fscanf(f5, formatSpec, sizeA);
data6 = fscanf(f6, formatSpec, sizeA);
data7 = fscanf(f7, formatSpec, sizeA);
data8 = fscanf(f8, formatSpec, sizeA);

fclose(f0); fclose(f1);
fclose(f2); fclose(f3);
fclose(f4); fclose(f5);
fclose(f6); fclose(f7);
fclose(f8);

figure
histogram(data0, 'BinWidth',5, 'BinLimits', [0, 800])
hold on
histogram(data1, 'BinWidth',5, 'BinLimits', [0, 800])
histogram(data2, 'BinWidth',5, 'BinLimits', [0, 800])
histogram(data3, 'BinWidth',5, 'BinLimits', [0, 800])
histogram(data4, 'BinWidth',5, 'BinLimits', [0, 800])
hold off
legend('0_u_s', '100_u_s', '200_u_s', '300_u_s', '500_u_s')
title('distribution')
xlabel('time (us)')
ylabel('count')

figure
histogram(data5, 'BinWidth',5, 'BinLimits', [1000, 1500])
title('distribution')
xlabel('time (us)')
ylabel('count')
figure
histogram(data6, 'BinWidth',5, 'BinLimits', [2000, 2500])
title('distribution')
xlabel('time (us)')
ylabel('count')
figure
histogram(data7, 'BinWidth',5, 'BinLimits', [4000, 4500])
title('distribution')
xlabel('time (us)')
ylabel('count')
figure
histogram(data8, 'BinWidth',5, 'BinLimits', [8000, 8500])
title('distribution')
xlabel('time (us)')
ylabel('count')