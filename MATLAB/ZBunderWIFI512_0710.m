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
zigbee_throughput_no_interference_100 = 31.8 .* ones(6,1);

% load the experiment data
load('.\ZigbeeThroughput\zigbee100byte25ms.mat')
zigbee100byte25ms = t;
load('.\ZigbeeThroughput\zigbee10byte25ms.mat')
zigbee10byte25ms = t;
zigbee10byte100ms = [0.725, 0.755, 0.945, ...
     1.04, 1.075, 1.085] ./ 1.4; % kbps

% ========================== visualize the data ========================= %
% plot wifi throughput with different zigbee payload [10, 100] under the 
% same transimssion interval 25ms
figure(1),
plot(wifi_delay, zigbee10byte25ms, 'bo-', ...
    wifi_delay, zigbee_throughput_no_interference_10_25ms, 'r--')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee Throughput under WiFi interference: 10 byte / 25ms',...
    'ZigBee Throughput without WiFi interference: 10 byte / 25ms')
grid on

figure(2)
plot(wifi_delay, zigbee100byte25ms, 'bo-', ...
    wifi_delay, zigbee_throughput_no_interference_100, 'r--')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee Throughput under WiFi interference: 100 byte / 25ms', ...
    'ZigBee Throughput without WiFi interference: 100 byte / 25ms')
grid on

% here the zigbee throughput is linear with the zigbee packet size
% TODO: add zigbee packet size = 1byte, plot the graph
figure(3)
semilogy(wifi_delay, zigbee10byte25ms, 'bo-', ...
    wifi_delay, zigbee100byte25ms, 'g^-')
grid on
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee transmission rate no interference: 10 byte / 25ms',...
    'ZigBee transmission rate no interference: 100 byte / 25ms')
title('ZigBee transmission rate under WiFi interference')


% plot wifi throughput with different transmission interval under the same
% zigbee payload 10 byte
% ------------------ %
% TODO:              %
% DO THE EXPERIMENT! %
% ------------------ %
% further more, with specific wifi constant delay time, zigbee throughput
% is inverse of the transmission interval
figure(4),
semilogy(wifi_delay, zigbee10byte25ms, 'bo-', ...
    wifi_delay, zigbee10byte100ms, 'g^-')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee transmission rate no interference: 10 byte / 25ms',...
    'ZigBee transmission rate no interference: 10 byte / 100ms')
grid on
