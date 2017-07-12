% ======================================================================= %
% This script visualize the zigbee behavior under WiFi interference
% All the experiment data are stored in the ZigbeeThroughput folder
% in the program
% ----------------------------------------------------------------------- %
% related file: ZigbeeThroughput\*.mat
% ======================================================================= %

close all

% wifi constant delay
wifi_delay = [0.1, 5, 20, 50, 100, 200]';

% experiment zigbee throughput without interference
zigbee_throughput_no_interference_10_25ms = 3.2 .* ones(6,1); % kbps
zigbee_throughput_no_interference_10_100ms = 0.78 .* ones(6,1);
zigbee_throughout_no_interference_10_10ms = 7.99 .* ones(6,1);
zigbee_throughput_no_interference_100_25ms = 31.8 .* ones(6,1);
zigbee_throughput_no_interference_100_100ms = 8.0 .* ones(6,1);

% load the experiment data
load('.\ZigbeeThroughput\zigbee100byte25ms.mat')
zigbee100byte25ms = t;
load('.\ZigbeeThroughput\zigbee10byte25ms.mat')
zigbee10byte25ms = t;
load('.\ZigbeeThroughput\zigbee10byte10ms.mat')
zigbee10byte10ms = t;
load('.\ZigbeeThroughput\zigbee100byte100ms.mat')
zigbee100byte100ms = t;

zigbee10byte100ms = [0.725, 0.755, 0.945, ...
     1.04, 1.075, 1.085] ./ 1.4; % kbps

% ========================== visualize the data ========================= %
% plot wifi throughput with different zigbee payload [10, 100] under the 
% same transimssion interval 25ms
figure,
plot(wifi_delay, zigbee10byte25ms, 'bo-', ...
    wifi_delay, zigbee_throughput_no_interference_10_25ms, 'r--')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
title('Zigbee Packet size = 10 byte, transmission interval = 25ms')
legend('ZigBee Throughput under WiFi interference',...
    'ZigBee Throughput without WiFi interference')
grid on

figure,
plot(wifi_delay, zigbee100byte25ms, 'bo-', ...
    wifi_delay, zigbee_throughput_no_interference_100_25ms, 'r--')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
title('Zigbee Packet size = 100 byte, transmission interval = 25ms')
legend('ZigBee Throughput under WiFi interference', ...
    'ZigBee Throughput without WiFi interference')
grid on

figure,
plot(wifi_delay, zigbee10byte10ms, 'bo-', ...
    wifi_delay, zigbee_throughout_no_interference_10_10ms, 'r--')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
title('Zigbee Packet size = 10 byte, transmission interval = 10ms')
legend('ZigBee Throughput under WiFi interference',...
    'ZigBee Throughput without WiFi interference')
grid on

% here the zigbee throughput is linear with the zigbee packet size
% TODO: add zigbee packet size = 1byte, plot the graph
figure,
semilogy(wifi_delay, zigbee10byte25ms, 'bo-', ...
    wifi_delay, zigbee100byte25ms, 'g^-')
grid on
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee packet size 10 byte',...
    'ZigBee packet size 100 byte')
title('ZigBee transmission rate under WiFi interference')


% plot wifi throughput with different transmission interval under the same
% zigbee payload 10 byte
% further more, with specific wifi constant delay time, zigbee throughput
% is inverse of the transmission interval
figure,
semilogy(wifi_delay, zigbee10byte10ms, 'r*-',...
    wifi_delay, zigbee10byte25ms, 'bo-', ...
    wifi_delay, zigbee10byte100ms, 'g^-')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee transmission interval 10ms',...
    'ZigBee transmission time interval 25ms',...
    'ZigBee transmission time interval 100ms')
grid on

% combining the factors zigbee packet size and the transmission interval
% which confirm our assumption that t = k * ps/ti
figure,
plot(wifi_delay, zigbee10byte10ms, 'bo-', ...
    wifi_delay, zigbee100byte100ms, 'r^--')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee: 10 byte / (packet * 10ms)',...
    'ZigBee: 100 byte / (packet * 100ms)')
grid on
