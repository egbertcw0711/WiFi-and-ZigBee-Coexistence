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
wifi_exp_delay = [20, 50, 100, 200]';

% experiment zigbee throughput without interference
zigbee_throughput_no_interference_10_25ms = 3.2 .* ones(6,1); % kbps
zigbee_throughput_no_interference_10_100ms = 0.78 .* ones(6,1);
zigbee_throughout_no_interference_10_10ms = 7.99 .* ones(6,1);
zigbee_throughput_no_interference_100_25ms = 31.8 .* ones(6,1);
zigbee_throughput_no_interference_100_100ms = 8.0 .* ones(6,1);

% load the experiment data
zigbee10byte100ms = [0.725, 0.755, 0.945, ...
     1.04, 1.075, 1.085] ./ 1.4; % kbps
load('.\ZigbeeThroughput\zigbee10byte25ms.mat')
zigbee10byte25ms = t;
load('.\ZigbeeThroughput\zigbee10byte10ms.mat')
zigbee10byte10ms = t;

load('.\ZigbeeThroughput\zigbee100byte100ms.mat')
zigbee100byte100ms = t;
load('.\ZigbeeThroughput\zigbee100byte50ms.mat')
zigbee100byte50ms = t;
load('.\ZigbeeThroughput\zigbee100byte25ms.mat')
zigbee100byte25ms = t;

load('.\ZigbeeThroughput\zigbee_exp_10byte10ms.mat')
zigbee_exp_10byte10ms = t;

% ========================== visualize the data ========================= %

% plot wifi throughput with different zigbee payload [10, 100] under the 
% same transimssion interval 25ms
% figure,
% plot(wifi_delay, zigbee10byte25ms, 'bo-', ...
%     wifi_delay, zigbee_throughput_no_interference_10_25ms, 'r--')
% xlabel('wifi constant delay (ms)')
% ylabel('zigbee throughput (kbps)')
% title('Zigbee Packet size = 10 byte, transmission interval = 25ms')
% legend('ZigBee Throughput under WiFi interference',...
%     'ZigBee Throughput without WiFi interference')
% grid on
% 
% figure,
% plot(wifi_delay, zigbee100byte25ms, 'bo-', ...
%     wifi_delay, zigbee_throughput_no_interference_100_25ms, 'r--')
% xlabel('wifi constant delay (ms)')
% ylabel('zigbee throughput (kbps)')
% title('Zigbee Packet size = 100 byte, transmission interval = 25ms')
% legend('ZigBee Throughput under WiFi interference', ...
%     'ZigBee Throughput without WiFi interference')
% grid on
% 
% figure,
% plot(wifi_delay, zigbee10byte10ms, 'bo-', ...
%     wifi_delay, zigbee_throughout_no_interference_10_10ms, 'r--')
% xlabel('wifi constant delay (ms)')
% ylabel('zigbee throughput (kbps)')
% title('Zigbee Packet size = 10 byte, transmission interval = 10ms')
% legend('ZigBee Throughput under WiFi interference',...
%     'ZigBee Throughput without WiFi interference')
% grid on
% 
% % plot both const and exponential wifi delay
% figure,
% plot(wifi_delay, zigbee_throughout_no_interference_10_10ms, 'r--',...
%     wifi_delay, zigbee10byte10ms, 'bo-', ...
%     wifi_exp_delay, zigbee_exp_10byte10ms, 'rs-')
% xlabel('wifi delay (ms)')
% ylabel('zigbee throughput (kbps)')
% title('Zigbee Packet size = 10 byte, transmission interval = 10ms')
% legend('No Interference', 'WiFi Interference Const Delay', ...
%     'WiFi Interference Exponential Delay')
% grid on

% NOTE: right now, I am no interested to show the above graphs, keep it
% comment
%-------------------------------------------------------------------------%

% The following 2 plots describes: I WILL INVESTIGATE IT LATER
% (1) zigbee throughput is linear with the zigbee packet size
figure,
semilogy(wifi_delay, zigbee10byte25ms, 'bo-', ...
    wifi_delay, zigbee100byte25ms, 'g^-', ...
    wifi_delay, zigbee_throughput_no_interference_10_25ms, 'r--', ...
    wifi_delay, zigbee_throughput_no_interference_100_25ms, 'r--')
grid on
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee packet size 10 byte',...
    'ZigBee packet size 100 byte')
title('ZigBee throughput under WiFi512 interference')

% (2) zigbee throughput vs. packet size 10, 100 byte with different delays
% TODO: 25 byte / packet
packetsize = [10, 100]';
zigbee25ms = [zigbee10byte25ms; zigbee100byte25ms];
figure,
hold on
for i = 1:6
    plot(packetsize, zigbee25ms(:,i), 'b*-')
end
hold off
grid on
xlabel('zigbee packet size (byte)')
ylabel('zigbee throughput(kbps)')
title('zigbee transmission interval 25ms')


%-------------------------------------------------------------------------%


% plot wifi throughput with different transmission interval under the same
% zigbee payload 10 byte
% zigbee throughput is linear with the zigbee transmission rate or inverse
% with zigbee transmission interval
figure,
semilogy(wifi_delay, zigbee10byte10ms, 'r*-',...
    wifi_delay, zigbee10byte25ms, 'bo-', ...
    wifi_delay, zigbee10byte100ms, 'g^-')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee transmission interval 10ms',...
    'ZigBee transmission interval 25ms',...
    'ZigBee transmission interval 100ms')
title('ZigBee Packet Size 10 byte')
grid on

TI10 = [10, 25, 100]';
zigbee10byte = [zigbee10byte10ms; zigbee10byte25ms; zigbee10byte100ms];
figure,
hold on
for i = 1:6
    semilogy(1000./TI10, zigbee10byte(:,i), 'bs-')
end
hold off
grid on
xlabel('zigbee packet per second')
ylabel('zigbee throughput(kbps)')
title('zigbee packet size 10 byte')

% zigbee payload 100 byte
figure,
semilogy(wifi_delay, zigbee100byte25ms, 'r*-',...
    wifi_delay, zigbee100byte50ms, 'bo-', ...
    wifi_delay, zigbee10byte100ms, 'g^-')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee transmission interval 25ms',...
    'ZigBee transmission interval 50ms',...
    'ZigBee transmission interval 100ms')
title('ZigBee Packet Size 100 byte')
grid on

TI100 = [25, 50, 100]';
tmp = 0 .* zigbee10byte10ms;
zigbee100byte = [zigbee100byte25ms; zigbee100byte50ms; zigbee100byte100ms];
figure,
hold on
for i = 1:6
    semilogy(1000./TI100, zigbee100byte(:,i), 'bs-')
end
hold off
grid on
xlabel('zigbee packet per second')
ylabel('zigbee throughput(kbps)')
title('zigbee packet size 100 byte')

%-------------------------------------------------------------------------%
% combining the factors zigbee packet size and the transmission interval
% which confirm our assumption that throughput = k * ps/ti
% figure,
% plot(wifi_delay, zigbee10byte10ms, 'bo-', ...
%     wifi_delay, zigbee100byte100ms, 'r^--')
% xlabel('wifi constant delay (ms)')
% ylabel('zigbee throughput (kbps)')
% legend('ZigBee: 10 byte / (packet * 10ms)',...
%     'ZigBee: 100 byte / (packet * 100ms)')
% title('ZigBee throughput under WiFi512 interference')
% grid on
