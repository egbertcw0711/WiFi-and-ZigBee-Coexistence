%=========================================================================%
% Program for investigating WiFi throughput under ZigBee interference     %
% the data are in the WiFiUnderZB/ and WiFiNoZB/ folder, and corresponding
% mat file is in the same folder called the same name as the script. 
%-------------------------------------------------------------------------%
% related file: WIFI512underZB0710.mat, WIFI512underZB100B25ms_0711.mat,
%               WIFI512noZB0710.mat
% related experiment data: WiFiUnderZB/   and   WiFiNoZB/
%=========================================================================%

close all
wifi_delay = [0.1, 5, 20, 50, 100, 200]';

%% read the experiment data with interference
wifi_throughput_interference = zeros(6,1);
wifi_rcvd_pkts_interference = zeros(6,1);

for i = 1:6
    [wifi_throughput_interference(i), wifi_rcvd_pkts_interference(i)] = ...
        get_mean_throughput();
end

filename = input('enter the filename: ');
save(filename)

%% read the experiment data no interference
wifi_throughput_no_interference = zeros(6,1);
wifi_rcvd_pkts_no_interference = zeros(6,1);

for i = 1:4
    [wifi_throughput_no_interference(i), wifi_rcvd_pkts_no_interference(i)] = ...
        get_mean_throughput();
end


wifi_throughput_no_interference(5) = 40.96; % kbps
wifi_rcvd_pkts_no_interference(5)= 500;
wifi_throughput_no_interference(6) = 20.48; % kbps
wifi_rcvd_pkts_no_interference(6)= 500;

filename = input('enter the filename: ');
save(filename)

%% visualization the data
load('WIFI512underZB10B25ms_0711.mat')
wifi_throughput_interference_10 = wifi_throughput_interference;
load('WIFI512underZB100B25ms_0711.mat')
wifi_throughput_interference_100 = wifi_throughput_interference;

figure,
loglog(wifi_delay, wifi_throughput_interference_10, 'bo-', ...
    wifi_delay, wifi_throughput_interference_100,'k^--', ...
    wifi_delay, wifi_throughput_no_interference, 'r*:')
xlabel('constant delay (ms)')
ylabel('WiFi throughput (kbps)')
title('WiFi Throughput vs. Constant Delay Time')
legend('Zigbee Packet Size 10byte',...
    'ZigBee Packet Size 100byte',...
    'No ZigBee Transmission')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS
