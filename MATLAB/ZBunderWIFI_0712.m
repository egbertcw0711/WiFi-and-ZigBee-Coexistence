% ======================================================================= %
% This script visualize the zigbee throughput under WiFi interference with
% different wifi packet sizes i.e. 128, 512 and 1024 byte/packet
% ----------------------------------------------------------------------- %
% related file: ZigbeeThroughput\*.mat  and WiFiPacketSize\*.mat
% ======================================================================= %

close all

% wifi constant delay
wifi_delay = [0.1, 5, 20, 50, 100, 200]';

% experiment zigbee throughput without interference
zigbee_throughout_no_interference_10_10ms = 7.99 .* ones(6,1);


% load the experiment data
load('.\ZigbeeThroughput\zigbee10byte10ms.mat')
zigbee10byte10ms_512 = t;
load('.\WiFiPacketSize\zigbeewifi1024.mat')
zigbee10byte10ms_1024 = t;
load('.\WiFiPacketSize\zigbeewifi128.mat')
zigbee10byte10ms_128 = t;

% ========================== visualize the data ========================= %figure,
plot(wifi_delay, zigbee10byte10ms_1024, 'g*-', ...
    wifi_delay, zigbee10byte10ms_512, 'bo-', ...
    wifi_delay, zigbee10byte10ms_128, 'c^-',...
    wifi_delay, zigbee_throughout_no_interference_10_10ms, 'r--')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
title('Zigbee Packet size = 10 byte, transmission interval = 10ms')
legend('WiFi packet size = 1024 byte', ...
    'WiFi packet size = 512 byte',...
    'WiFi packet size = 128 byte ',...
    'No Interference')
grid on