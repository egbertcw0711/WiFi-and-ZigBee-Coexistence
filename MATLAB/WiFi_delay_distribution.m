close all;
clear

f = fopen('./data/Delay.txt');
formatSpec = '%d';
sizeA = [1, inf];

data = fscanf(f, formatSpec, sizeA);
fclose(f);

histogram(data,'BinWidth',5, 'BinLimits', [0, 260])