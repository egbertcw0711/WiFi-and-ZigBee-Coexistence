% read the experiment data with interference
close all;
clc, clear
wifi_delay = [0,0.1,0.2,0.3,0.5,1,2,4,8,10,15,20,50,100,200]';
len = length(wifi_delay);

wifi_throughput_interference = zeros(len,1);
wifi_rcvd_pkts_interference = zeros(len,1);

for i = 1:len
    [wifi_throughput_interference(i), wifi_rcvd_pkts_interference(i)] = ...
        get_mean_throughput();
end

filename = input('enter the filename: ');
save(filename)