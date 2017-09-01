% ======================================================================= %
% ======== This program visualize the wifi and zigbee throughput ======== % 
% =============== under the interference with each other ================ %
% ======================================================================= %

%% load the experiment data
close all
clear, clc

% load wifi throughput wifi constant delay CCA: -44dbm
load('.\WiFiUnderZB\WIFI512out20.5ZB10byte10ms_0814.mat') % output 20.5
wifi512out20dot5withZB10B10ms_lowCCA = wifi_throughput_interference;

% load zigbee throughput wifi constant delay
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout20.5dbm_var.mat')
zigbee10byte10ms_wifiout205 = t(:,1); % we add more points on this file
zigbee10byte10ms_wifiout205_var = sqrt(t(:,2)); % add the variance 08-15-2017


load('.\WiFiUnderZB\WIFI512out10ZB10byte10ms_0814.mat') % output 10
wifi512out10withZB10B10ms = wifi_throughput_interference;

load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout10dbm_var.mat')
zigbee10byte10ms_wifiout10 = t(:,1);
zigbee10byte10ms_wifiout10_var = sqrt(t(:,2));


load('.\WiFiUnderZB\WIFI512out5ZB10byte10ms_0815.mat') % output 5
wifi512out5withZB10B10ms = wifi_throughput_interference;

load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout5dbm_var.mat')
zigbee10byte10ms_wifiout5 = t(:,1);
zigbee10byte10ms_wifiout5_var = sqrt(t(:,2));


load('.\WiFiUnderZB\WIFI512outneg10ZB10byte10ms_0816.mat') % output -10
wifi512outneg10withZB10B10ms = wifi_throughput_interference;

load('.\ZigbeeThroughput\zigbee10byte10ms_wifioutneg10dbm_var.mat')
zigbee10byte10ms_wifioutneg10 = t(:,1);
zigbee10byte10ms_wifioutneg10_var = sqrt(t(:,2));

% ----------------------------------------------------------------------- %
%% Visualize the experiment data
%------------------------------------------------------------------------ %

% delete point delay 5: 08-15-2017
% modified in "process_data_in_folder.m"
wifi = [0, 0.1, 0.2, 0.3, 0.5, 1, 2, 4, 8, 10, 15, 20, 50, 100, 200]';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
%  wifi throughput vs. wifi constant delay                                %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
figure,
loglog(wifi, wifi512out20dot5withZB10B10ms_lowCCA, 'r--', ...
    wifi, wifi512out10withZB10B10ms, 'g--', ...
    wifi, wifi512out5withZB10B10ms, 'b--', ...
    wifi, wifi512outneg10withZB10B10ms, 'k--')
xlabel('wifi constant delay (ms)')
ylabel('wifi throughput (kbps)')
legend('20.5dBm', '10dBm', '5dBm', '-10dBm')
grid on
title('CCA: -44dBm')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% zigbee throughput under wifi interference constant delay              %
% CCA: -44bdm                                                           %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
figure,
errorbar(wifi, zigbee10byte10ms_wifiout5, ...
    zigbee10byte10ms_wifiout5_var, 'gx--')

hold on
errorbar(wifi, zigbee10byte10ms_wifiout10,...
    zigbee10byte10ms_wifiout10_var, 'bx--')

errorbar(wifi, zigbee10byte10ms_wifiout205, ...
    zigbee10byte10ms_wifiout205_var, 'rx--')

errorbar(wifi, zigbee10byte10ms_wifioutneg10, ...
    zigbee10byte10ms_wifioutneg10_var, 'kx--')
hold off

xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('wifi 5dbm, zigbee 0dbm', 'wifi 10dbm, zigbee 0dbm',...
    'wifi 20.5dbm, zigbee 0dbm', 'wifi 20.5dbm, zigbee -10dbm')
title('CCA: -44dbm')
grid on
set(gca,'xscale','log', 'Xdir','reverse');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% zigbee throughput under wifi exponential delay %
% CCA: -76dbm                                    %
% modified on 2017-08-23                         %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %

% figure,
% errorbar(wifi, zigbee10byte10ms_wifiout5, ...
%     zigbee10byte10ms_wifiout5_var, 'gx--')
% 
% hold on
% errorbar(wifi, zigbee10byte10ms_wifiout10,...
%     zigbee10byte10ms_wifiout10_var, 'bx--')
% 
% errorbar(wifi, zigbee10byte10ms_wifiout205, ...
%     zigbee10byte10ms_wifiout205_var, 'rx--')
% 
% errorbar(wifi, zigbee10byte10ms_wifioutneg10, ...
%     zigbee10byte10ms_wifioutneg10_var, 'kx--')
% hold off
% 
% xlabel('wifi exponential delay (ms)')
% ylabel('zigbee throughput (kbps)')
% grid on
% set(gca,'xscale','log', 'Xdir','reverse');

%% modified on 2017-08-16
% 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% % zigbee throughput under wifi throughput,  constant delay              %
% % CCA: -44bdm                                                           %
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% figure,
% errorbar(wifi512out5withZB10B10ms, zigbee10byte10ms_wifiout5, ...
%     zigbee10byte10ms_wifiout5_var, 'gx--')
% 
% hold on
% errorbar(wifi512out10withZB10B10ms, zigbee10byte10ms_wifiout10,...
%     zigbee10byte10ms_wifiout10_var, 'bx--')
% 
% errorbar(wifi512out20dot5withZB10B10ms_lowCCA, zigbee10byte10ms_wifiout205, ...
%     zigbee10byte10ms_wifiout205_var, 'rx--')
% 
% errorbar(wifi512outneg10withZB10B10ms, zigbee10byte10ms_wifioutneg10, ...
%     zigbee10byte10ms_wifioutneg10_var, 'kx--')
% hold off
% 
% xlabel('wifi throughput (kbps)')
% ylabel('zigbee throughput (kbps)')
% legend('wifi 5dbm, zigbee 0dbm', 'wifi 10dbm, zigbee 0dbm',...
%     'wifi 20.5dbm, zigbee 0dbm', 'wifi 20.5dbm, zigbee -10dbm')
% grid on
% title('CCA: -44(dbm)')
% set(gca,'xscale','log');

%% modified on 2017-08-22
% wifi output power 20.5dbm, const delay, CCA: -76dbm -- 2017-08-22
load('.\WiFiUnderZB\WIFI512out20.5ZB10byte10ms_0822.mat')
wifi512out20dot5withZB10B10ms_lowCCA = wifi_throughput_interference;

% wifi output power 20.5dbm exponential delay, CCA: -76dbm
load('.\WiFiUnderZB\WIFI512out20.5_expZB10byte10ms_0821.mat')
wifi512out20dot5expwithZB10B10ms = wifi_throughput_interference;

% zigbee throughput under wifi output power 20.5dbm, const delay CCA: -76dbm
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout20.5constdbm_var.mat')
zigbee10byte10ms_wifiout205_lowCCA = t(:,1); 
zigbee10byte10ms_wifiout205_var_lowCCA = sqrt(t(:,2));

% zigbee throughput under wifi output power 20.5dbm, exp delay CCA: -76dbm
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout20.5expdbm_var.mat')
zigbee10byte10ms_wifiout20dot5exp = t(:,1);
zigbee10byte10ms_wifiout20dot5exp_var = sqrt(t(:,2));

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% compare WiFi throughpout with exponential delay                      %
% compare ZigBee throughput with constant delay                        %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
figure,
loglog(wifi, wifi512out20dot5expwithZB10B10ms, 'r--', ...
    wifi, wifi512out20dot5withZB10B10ms_lowCCA, 'b--')
xlabel('wifi delay (ms)')
ylabel('wifi throughput (kbps)')
title('CCA: -76dBm, Output: 20.5dBm')
legend('exponential', 'constant')
grid on

figure,
errorbar(wifi, zigbee10byte10ms_wifiout205_lowCCA, ...
    zigbee10byte10ms_wifiout205_var_lowCCA, 'rx--')
hold on
errorbar(wifi, zigbee10byte10ms_wifiout20dot5exp, ...
    zigbee10byte10ms_wifiout20dot5exp_var, 'bx--')
title('CCA: -76dBm, Output: 20.5dBm')
xlabel('wifi delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('constant', 'exponential')
grid on
set(gca, 'xscale', 'log')
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% compare zigbee throughput with WF throughput const and exponential   % 
% delay under the same wifi output power, i.e. 20.5 dbm and CCA: -76dbm%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %

% figure,
% errorbar(wifi512out20dot5withZB10B10ms_lowCCA, zigbee10byte10ms_wifiout205_lowCCA, ...
%     zigbee10byte10ms_wifiout205_var_lowCCA, 'rx--')
% hold on
% errorbar(wifi512out20dot5expwithZB10B10ms, zigbee10byte10ms_wifiout20dot5exp, ...
%     zigbee10byte10ms_wifiout20dot5exp_var, 'bx--')
% hold off
% title('CCA : -76dbm,  WIFI power: 20.5dbm')
% legend('const delay', 'exp delay')
% xlabel('WiFi throughput (kbps)')
% ylabel('ZigBee throughput (kbps)')
% grid on
% set(gca,'xscale','log');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% plot the graph with different ZigBee CCA threshold under the same WiFi  %
% output power, i.e. 20.5dbm and constant delay                                                 %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %

% zigbee throughput under wifi output power 20.5dbm, const delay, CCA:-44dbm
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout20.5dbm_var.mat')
zigbee10byte10ms_wifiout205 = t(:,1); 
zigbee10byte10ms_wifiout205_var = sqrt(t(:,2));

figure,
% CCA: -44dbm
errorbar(wifi, zigbee10byte10ms_wifiout205, ...
    zigbee10byte10ms_wifiout205_var, 'rx--')
hold on
% CCA: -76dbm
errorbar(wifi, zigbee10byte10ms_wifiout205_lowCCA, ...
    zigbee10byte10ms_wifiout205_var_lowCCA, 'bx--')
hold off
legend('-44dbm', '-76dbm')
xlabel('wifi constant delay (ms)')
ylabel('ZigBee throughput (kbps)')
title('Output: 20.5dBm')
axis([0, 210, 0, 8.5])
grid on
set(gca,'xscale','log');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% compare zigbee throughput with different wifi power using exp delay %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %

% wifi output power 5dbm, exponential delay, CCA:-76dbm
load('.\WiFiUnderZB\WIFI512out5_expZB10byte10ms_0821.mat')
wifi512out5expwithZB10B10ms = wifi_throughput_interference;

% zigbee throughpuyt under wifi output power 5dbm, exp delay, CCA: -76dbm
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout5expdbm_var.mat')
zigbee10byte10ms_wifiout5exp = t(:,1);
zigbee10byte10ms_wifiout5exp_var = sqrt(t(:,2));

figure,
loglog(wifi,wifi512out20dot5expwithZB10B10ms, 'rx--',...
    wifi, wifi512out5expwithZB10B10ms, 'bo--')
title('CCA: -76(dbm)')
legend('20.5dbm', '5.0dbm')
xlabel('WiFi exponential delay (ms)')
ylabel('WiFi throughput (kbps)')
grid on

% figure,
% errorbar(wifi, zigbee10byte10ms_wifiout20dot5exp, ...
%     zigbee10byte10ms_wifiout20dot5exp_var, 'bx--')
% hold on
% errorbar(wifi, zigbee10byte10ms_wifiout5exp, ...
%     zigbee10byte10ms_wifiout5exp_var, 'rx--')
% hold off
% title('CCA: -76(dbm)')
% legend('20.5dbm', '5.0dbm')
% xlabel('WiFi exponential delay (ms)')
% ylabel('ZigBee throughput (kbps)')
% grid on
% set(gca, 'xscale', 'log')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% plot the graph with different ZigBee CCA threshold under the same WiFi  %
% output power, i.e. 5dbm                                                 %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% wifi output power 5dbm exponential delay CCA:-44dbm
load('.\WiFiUnderZB\WIFI512out5ZB10bye10ms_exp_0822.mat')
wifi512out5expwithZB10B10ms_highCCA = wifi_throughput_interference;

% zigbee throughput under wifi output power 5dbm exp delay CCA: -44dbm
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiout5dbm_exp_var.mat')
zigbee10byte10ms_wifiout5exp_highCCA = t(:,1);
zigbee10byte10ms_wifiout5exp_var_highCCA = sqrt(t(:,2));
% 
% figure,
% errorbar(wifi512out5expwithZB10B10ms_highCCA, zigbee10byte10ms_wifiout5exp_highCCA, ...
%     zigbee10byte10ms_wifiout5exp_var_highCCA, 'rx--')
% hold on
% 
% % low CCA: -76dbm
% errorbar(wifi512out5expwithZB10B10ms, zigbee10byte10ms_wifiout5exp, ...
%     zigbee10byte10ms_wifiout5exp_var, 'bx--')
% hold off
% title('WiFi exponential delay, output power 5dbm')
% legend('-44dbm', '-76dbm')
% xlabel('WiFi throughput (kbps)')
% ylabel('ZigBee throughput (kbps)')
% axis([0, 9000, 2, 8.5])
% grid on


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% plot the graph with the same ZigBee CCA threshold, WiFi exponential delay
% with different WiFi output power
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% figure,
% errorbar(wifi512out5expwithZB10B10ms_highCCA, zigbee10byte10ms_wifiout5exp_highCCA, ...
% %     zigbee10byte10ms_wifiout5exp_var_highCCA, 'b--')
% hold on,
% errorbar(wifi512out20dot5withZB10B10ms, zigbee10byte10ms_wifiout205, ...
%     zigbee10byte10ms_wifiout205_var, 'r--') % needs to be changed to exponential delay
% hold off
% 
% xlabel('WiFi throughput (kbps)')
% ylabel('ZigBee throughput (kbps)')
% legend('WiFi output power 5dbm', 'WiFi output power 20.5dbm')
% title('WiFi exponential delay, CCA: -44dbm # CHANGE TO EXPONENTIAL DELAY! #')
% grid on


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% wifi avg transmission interval with wifi delay  % 
% zigbee throughput with wifi delay               %
% modified on 2017-08-23                          %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %

% CCA -76dbm, WiFi out 5dbm
figure,
loglog(wifi, 512 * 8 ./ wifi512out5expwithZB10B10ms, 'rx--', ...
    wifi, 512*8./wifi512out20dot5expwithZB10B10ms, 'bo--')
xlabel('wifi exponential delay (ms)')
ylabel(' wifi average transmission intervl (ms)')
legend('5 dbm', '20.5dbm')
title('WiFi 512byte/pkt, CCA: -76dbm')
grid on
% set(gca, 'xscale', 'log', 'xdir', 'reverse');


figure,
errorbar(wifi, zigbee10byte10ms_wifiout5exp, ...
    zigbee10byte10ms_wifiout5exp_var, 'r--')
hold on
% CCA -76dbm, WiFi out 20.5dbm
errorbar(wifi, zigbee10byte10ms_wifiout20dot5exp, ...
    zigbee10byte10ms_wifiout20dot5exp_var, 'b--')
hold off
xlabel('wifi exponential delay(ms)')
ylabel('zigbee throughput (kbps)')
legend('5 dbm', '20.5dbm')
title('WiFi 512byte/pkt, CCA: -76dbm')
grid on
set(gca, 'xscale', 'log');
axis([0.1, 210, 2, 8.5])

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% zigbee throughput under different packet size. %
% wifi mean transmission interval                %
% modified on 2017-08-23                         %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% wifi1500, out 20.5dbm, CCA: -76dbm
load('.\WiFiUnderZB\WIFI1500out205ZB10b10ms.mat')
wifi1500out205expwithZB10B10ms_lowCCA = wifi_throughput_interference;

load('.\ZigbeeThroughput\zigbee10byte10ms_wifi1500out20.5dbm_var.mat')
zigbee10byte10ms_wifi1500out205exp = t(:,1);
zigbee10byte10ms_wifi1500out205exp_var = sqrt(t(:,2));

figure,
loglog(wifi, wifi1500out205expwithZB10B10ms_lowCCA, 'rx-', ...
    wifi, wifi512out20dot5expwithZB10B10ms, 'bo--')

legend('1500 byte / pkt', '512 byte / pkt')
title('WiFi out 20.5dbm, CCA: -76dbm')
grid on
xlabel('wifi exponential delay (ms)')
ylabel('wifi throughput (kbps)')

figure,
errorbar(wifi, zigbee10byte10ms_wifiout20dot5exp, ...
    zigbee10byte10ms_wifiout20dot5exp_var, 'rx-')
hold on
errorbar(wifi, zigbee10byte10ms_wifi1500out205exp, ...
    zigbee10byte10ms_wifi1500out205exp_var, 'bo--')
hold off
legend('512 byte / pkt', '1500 byte / pkt')
title('WiFi out 20.5dbm, CCA: -76dbm')
grid on
xlabel('wifi exponential delay (ms)')
ylabel('zigbee throughput (kbps)')
set(gca, 'xscale', 'log');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
%  using the different protocol: 11b and 11n                              %
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
load('.\ZigbeeThroughput\zigbee10byte10ms_wifiB1500out20.5dbm_var.mat')
zigbee10byte10ms_wifiB1500out205exp = t(:,1);
zigbee10byte10ms_wifiB1500out205exp_var = sqrt(t(:,2));

load('.\WiFiUnderZB\WIFIB1500out20.5ZB10B10ms.mat')
wifiB1500out205expwithZB10B10ms_lowCCA = wifi_throughput_interference;

figure,
semilogx(wifi, wifi1500out205expwithZB10B10ms_lowCCA, 'rx--', ...
    wifi,wifiB1500out205expwithZB10B10ms_lowCCA, 'bo--')
legend('11N', '11B')
xlabel('Wi-Fi exponential delay (kbps)')
ylabel('Wi-Fi throughput (kbps)')
title('Compare 11B and 11N under the same situation')
grid on

figure,
errorbar(wifi, zigbee10byte10ms_wifi1500out205exp, ...
    zigbee10byte10ms_wifi1500out205exp_var, 'r--')
hold on
errorbar(wifi, zigbee10byte10ms_wifiB1500out205exp, ...
    zigbee10byte10ms_wifiB1500out205exp_var, 'bo--')

legend('11N', '11B')
xlabel('WiFi exponential delay (ms)')
ylabel('ZigBee throughput (kbps)')
title('Compare 11B and 11N under the same situation')
grid on
set(gca, 'xscale', 'log');

figure,
semilogx(wifi, 1 ./ wifi1500out205expwithZB10B10ms_lowCCA , 'rx--', ...
    wifi, 1./wifi512out20dot5expwithZB10B10ms, 'bo--')
xlabel('wifi exponential delay (ms)')
ylabel(' wifi average transmission intervl (ms/pkt)')
legend('1500', '512')
title('Output:20.5dBm, CCA: -76dbm')
grid on
