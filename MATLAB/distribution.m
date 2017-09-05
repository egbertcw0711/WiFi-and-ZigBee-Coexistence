close all;
clear

fh = dir('./data/');
fpath = './data/';
formatSpec = '%d';
sizeA = [1, inf];

hold on 
for i = 3:length(fh)
    % read file from the txt files
    fname = fh(i).name;
    fullpath = strcat(fpath, fname);
    f = fopen(fullpath);
    data = fscanf(f, formatSpec, sizeA);
    fclose(f);
    
    % plot the distribution histogram
    histogram(data, 'BinWidth', 5, 'BinLimits', [0, 2500])
end
hold off
xlabel('delay(ms)')
ylabel('count')
title('distribution')
legend('0us', '100us', '200us', '300us', '500us', '1000us', '2000us')