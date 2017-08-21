% ======================================================================= %
% ======== This program visualize the wifi and zigbee throughput ======== % 
% =============== under the interference with each other ================ %
% ==================== written on Aug 7th 2017 ========================== %
% ======================================================================= %

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

load('.\WiFiUnderZB\WIFI512outneg10ZB10byte10ms_0816.mat')
wifi512outneg10withZB10B10ms = wifi_throughput_interference;

% load zigbee throughput wifi constant delay
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout20.5dbm_var.mat')
zigbee10byte10ms_wifiout205 = t(:,1); % we add more points on this file
zigbee10byte10ms_wifiout205_var = sqrt(t(:,2)); % add the variance 08-15-2017

load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout10dbm_var.mat')
zigbee10byte10ms_wifiout10 = t(:,1);
zigbee10byte10ms_wifiout10_var = sqrt(t(:,2));

load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout5dbm_var.mat')
zigbee10byte10ms_wifiout5 = t(:,1);
zigbee10byte10ms_wifiout5_var = sqrt(t(:,2));

load('.\ZigbeeThroughput\zigbee10byte10ms_wifioutneg10dbm_var.mat')
zigbee10byte10ms_wifioutneg10 = t(:,1);
zigbee10byte10ms_wifioutneg10_var = sqrt(t(:,2));

% load zigbee throughput wifi exponential delay
load('.\ZigbeeThroughput\zigbee_exp_10byte10ms.mat')
zigbee10byte10ms_512_exp = t;

% delete point delay 5: 08-15-2017
% modified in "process_data_in_folder.m"
wifi = [0, 0.1, 0.2, 0.3, 0.5, 1, 2, 4, 8, 10, 15, 20, 50, 100, 200]';

%% plot the graph
% zigbee throughput under wifi interference constant delay
figure,
errorbar(wifi, zigbee10byte10ms_wifiout10,...
    zigbee10byte10ms_wifiout10_var, 'bx--')
hold on
errorbar(wifi, zigbee10byte10ms_wifiout205, ...
    zigbee10byte10ms_wifiout205_var, 'rx--')

errorbar(wifi, zigbee10byte10ms_wifiout5, ...
    zigbee10byte10ms_wifiout5_var, 'gx--')

errorbar(wifi, zigbee10byte10ms_wifioutneg10, ...
    zigbee10byte10ms_wifioutneg10_var, 'kx--')
set(gca,'xscale','log', 'Xdir','reverse');
hold off
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('wifi 10dbm, zigbee 0dbm', 'wifi 20.5dbm, zigbee 0dbm',...
    'wifi 5dbm, zigbee 0dbm', 'wifi 20.5dbm, zigbee -10dbm')
grid on

%% % more on wifi exponential delay
% hold on
% semilogx(wifi_exp_delay, zigbee10byte10ms_512_exp, 'ro-')
% hold off
% legend('constant delay', 'exponential delay')

%% wifi packet error rate
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

%% modified on 2017-08-16
% add standard deviation on the mean zigbee throughput
figure,
errorbar(wifi512out10withZB10B10ms, zigbee10byte10ms_wifiout10,...
    zigbee10byte10ms_wifiout10_var, 'bx--')
hold on
errorbar(wifi512out20dot5withZB10B10ms, zigbee10byte10ms_wifiout205, ...
    zigbee10byte10ms_wifiout205_var, 'rx--')

errorbar(wifi512out5withZB10B10ms, zigbee10byte10ms_wifiout5, ...
    zigbee10byte10ms_wifiout5_var, 'gx--')

errorbar(wifi512outneg10withZB10B10ms, zigbee10byte10ms_wifioutneg10, ...
    zigbee10byte10ms_wifioutneg10_var, 'kx--')

hold off
xlabel('wifi throughput (kbps)')
ylabel('zigbee throughput (kbps)')
legend('wifi 10dbm, zigbee 0dbm', 'wifi 20.5dbm, zigbee 0dbm',...
    'wifi 5dbm, zigbee 0dbm', 'wifi 20.5dbm, zigbee -10dbm')
grid on
title('CCA: -44(dbm)')
% set(gca,'xscale','log');

%% modified on 2017-08-21
% load the corresponding data
% wifi output power 20.5dbm, const delay
load('.\WiFiUnderZB\WIFI512out20.5ZB10byte10ms_0814.mat')
wifi512out20dot5withZB10B10ms = wifi_throughput_interference;
% wifi output power 20.5dbm exponential delay
load('.\WiFiUnderZB\WIFI512out20.5_expZB10byte10ms_0821.mat')
wifi512out20dot5expwithZB10B10ms = wifi_throughput_interference;
% wifi output power 5dbm exponential delay
load('.\WiFiUnderZB\WIFI512out5_expZB10byte10ms_0821.mat')
wifi512out5expwithZB10B10ms = wifi_throughput_interference;

% zigbee throughput under wifi output power 20.5dbm constant delay
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout20.5dbm_var.mat')
zigbee10byte10ms_wifiout205 = t(:,1); 
zigbee10byte10ms_wifiout205_var = sqrt(t(:,2));
% zigbee throughput under wifi output power 20.5dbm exp delay
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout20.5expdbm_var.mat')
zigbee10byte10ms_wifiout20dot5exp = t(:,1);
zigbee10byte10ms_wifiout20dot5exp_var = sqrt(t(:,2));
% zigbee throughpuyt under wifi output power 5dbm exp delay
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout5expdbm_var.mat')
zigbee10byte10ms_wifiout5exp = t(:,1);
zigbee10byte10ms_wifiout5exp_var = sqrt(t(:,2));

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% compare zigbee throughput with const and exponential delay under the %
% same wifi output power, i.e. 20.5 dbm                                %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
figure,
% const wifi delay
errorbar(wifi512out20dot5withZB10B10ms, zigbee10byte10ms_wifiout205, ...
    zigbee10byte10ms_wifiout205_var, 'rx--')
hold on
% exp wifi delay
errorbar(wifi512out20dot5expwithZB10B10ms, zigbee10byte10ms_wifiout20dot5exp, ...
    zigbee10byte10ms_wifiout20dot5exp_var, 'bx--')
hold off
legend('const delay', 'exp delay')
grid on
set(gca,'xscale','log');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% compare zigbee throughput with different wifi power using exp delay %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
figure,
errorbar(wifi512out20dot5expwithZB10B10ms, zigbee10byte10ms_wifiout20dot5exp, ...
    zigbee10byte10ms_wifiout20dot5exp_var, 'rx--')
hold on
errorbar(wifi512out5expwithZB10B10ms, zigbee10byte10ms_wifiout5exp, ...
    zigbee10byte10ms_wifiout5exp_var, 'bx--')
hold off
title('CCA: -76(dbm)')
legend('20.5dbm', '5.0dbm')
grid on