% ======================================================================= %
% ======== This program visualize the wifi and zigbee throughput ======== % 
% =============== under the interference with each other ================ %
% ==================== written on Aug 7th 2017 ========================== %
% ======================================================================= %

% load wifi throughput wifi constant delay
load('.\WiFiUnderZB\WIFI512underZB10B10ms_0807.mat')
wifi512withInterference10B10ms = wifi_throughput_interference;

% load zigbee throughput wifi constant delay
load('.\ZigbeeThroughput\zigbee10byte10ms.mat')
zigbee10byte10ms_512 = t; % we add more points on this file

% load zigbee throughput wifi exponential delay
load('.\ZigbeeThroughput\zigbee_exp_10byte10ms.mat')
zigbee10byte10ms_512_exp = t;

% test points
wifi_delay = [0.1, 0.5, 1, 2, 4, 5, 8, 10, 15, 20, 50, 100, 200]';
wifi_exp_delay = [20, 50, 100, 200]';

% zigbee throughput under wifi interference constant delay
figure,
semilogx(wifi_delay, zigbee10byte10ms_512, 'bo-')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
grid on

% wifi exponential delay
hold on
semilogx(wifi_exp_delay, zigbee10byte10ms_512_exp, 'ro-')
hold off
legend('constant delay', 'exponential delay')

% wifi throughput under zigbee interference
figure,
semilogx(wifi_delay, wifi512withInterference10B10ms, 'bo-')
xlabel('wifi constant delay (ms)')
ylabel('wifi throughput (kbps)')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            WHY the zigbee throughput line looks like this ?             %
%                      CLICK TO SEE THE GRAPH                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

