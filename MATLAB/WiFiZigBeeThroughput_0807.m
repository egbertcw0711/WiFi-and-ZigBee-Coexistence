% ======================================================================= %
% ======== This program visualize the wifi and zigbee throughput ======== % 
% =============== under the interference with each other ================ %
% ==================== written on Aug 7th 2017 ========================== %
% ======================================================================= %

% modified on Aug 9th 2017
% modified on Aug 15th 2017

%% load the experiment data
close all
clear, clc
% load wifi throughput wifi constant delay
load('.\WiFiUnderZB\WIFI512out20.5ZB10byte10ms_0814.mat')
wifi512out20dot5withZB10B10ms = wifi_throughput_interference;

load('.\WiFiUnderZB\WIFI512out10ZB10byte10ms_0814.mat')
wifi512out10withZB10B10ms = wifi_throughput_interference;

load('.\WiFiUnderZB\WIFI512out5ZB10byte10ms_0815.mat')
wifi512out5withZB10B10ms = wifi_throughput_interference;

% load zigbee throughput wifi constant delay
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout20.5dbm_var.mat')
zigbee10byte10ms_wifiout205 = t(:,1); % we add more points on this file
zigbee10byte10ms_wifiout205_var = t(:,2); % add the variance 08-15-2017

load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout10dbm_var.mat')
zigbee10byte10ms_wifiout10 = t(:,1);
zigbee10byte10ms_wifiout10_var = t(:,2);

load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout5dbm_var.mat')
zigbee10byte10ms_wifiout5 = t(:,1);
zigbee10byte10ms_wifiout5_var = t(:,2);

% load zigbee throughput wifi exponential delay
load('.\ZigbeeThroughput\zigbee_exp_10byte10ms.mat')
zigbee10byte10ms_512_exp = t;

% delete point delay 5: 08-15-2017
% modified in "process_data_in_folder.m"
wifi = [0, 0.1, 0.2, 0.3, 0.5, 1, 2, 4, 8, 10, 15, 20, 50, 100, 200]';

%% 
% wifi_exp_delay = [20, 50, 100, 200]';
% tot = 5000; 
% rcvd = [3471, 3556, 3593, 3620, 3621, 3666, 3699, 3641, 3644, 3772, ...
%    4019, 4279, 4377, 4797, 4945, 4992]';
% rcvd = [3471, 3556, 3593, 3621, 3666, 3699, 3641, 3644, 3772, ...
%     4019, 4279, 4377, 4797, 4945, 4992]';
% trans = [3304, 3410, 3598, 3550, 3536, 3519, 3609, 3553, 3688, 3942, ...
%     4184, 4296, 4699, 4866, 4962]';
% % rcvd = [];
% % trans = [];
% 
% rcvd_ratio = rcvd ./ tot * 100;
% delivery_ratio = trans ./ tot * 100;

%% plot the graph
% % zigbee throughput under wifi interference constant delay
% figure,
% semilogx(wifi_delay, zigbee10byte10ms_512, 'bo-')
% xlabel('wifi constant delay (ms)')
% ylabel('zigbee throughput (kbps)')
% grid on
% 
% % wifi exponential delay
% hold on
% semilogx(wifi_exp_delay, zigbee10byte10ms_512_exp, 'ro-')
% hold off
% legend('constant delay', 'exponential delay')
% 
% % wifi throughput under zigbee interference
% figure,
% semilogx(wifi_delay, wifi512withInterference10B10ms, 'bo-')
% xlabel('wifi constant delay (ms)')
% ylabel('wifi throughput (kbps)')
% grid on

% figure,
% subplot(2,1,1)
% % plot(wifi512withInterference10B10ms, delivery_ratio, 'bo-')
% % xlabel('wifi throughput (kbps)')
% % ylabel('percentage of successfully transmitted (%)')
% % grid on
% plot(wifi512out20dot5withZB10B10ms, zigbee10byte10ms_wifiout205, 'bo-')
% xlabel('wifi throughput (kbps)')
% ylabel('zigbee throughput (kbps)')
% grid on
% 
% subplot(2,1,2)
% plot(wifi512out20dot5withZB10B10ms, rcvd_ratio, 'bo-')
% xlabel('wifi throughput (kbps)')
% ylabel('percentage of successfully rcvd (%)')
% grid on

% figure,
% plot(wifi512withInterference10B10ms, zigbee10byte10ms_512, 'bo-')
% xlabel('wifi throughput (kbps)')
% ylabel('zigbee throughput (kbps)')
% grid on

%% modified on 2017-08-14
% % plot with different wifi output power 10 and 20.5
% figure,
% plot(wifi512out10withZB10B10ms, zigbee10byte10ms_wifiout10, 'bo-', ...
%     wifi512out20dot5withZB10B10ms, zigbee10byte10ms_wifiout205, 'r*-')
% xlabel('wifi throughput (kbps)')
% ylabel('zigbee throughput (kbps)')
% legend('wifi output 10dbm', 'wifi output 20.5dbm')
% grid on

%% modified on 2017-08-15
% add data variance based on above
figure,
errorbar(wifi512out10withZB10B10ms, zigbee10byte10ms_wifiout10,...
    zigbee10byte10ms_wifiout10_var, 'bx--')
hold on
errorbar(wifi512out20dot5withZB10B10ms, zigbee10byte10ms_wifiout205, ...
    zigbee10byte10ms_wifiout205_var, 'rx--')

errorbar(wifi512out5withZB10B10ms, zigbee10byte10ms_wifiout5, ...
    zigbee10byte10ms_wifiout5_var, 'gx--')

hold off
xlabel('wifi throughput (kbps)')
ylabel('zigbee throughput (kbps)')
legend('wifi output 10dbm', 'wifi output 20.5dbm', 'wifi output 5dbm')
grid on
