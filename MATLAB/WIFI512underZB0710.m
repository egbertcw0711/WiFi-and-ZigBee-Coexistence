%=========================================================================%
% Program for investigating WiFi throughput with/withput ZigBee interference
% the data are in the WiFiUnderZB/ and WiFiNoZB/ folder, and corresponding
% mat file. 
%-------------------------------------------------------------------------%
% related experiment data: WiFiUnderZB/ *.mat   and   WiFiNoZB/ *.mat
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

for i = 1:6
    [wifi_throughput_no_interference(i), wifi_rcvd_pkts_no_interference(i)] = ...
        get_mean_throughput();
end

filename = input('enter the filename: ');
save(filename)

%% visualization the data
% load the experiment data
load('WIFI128BnoInterference.mat')
wifi128noInterference = wifi_throughput_no_interference;
load('WIFI512BnoInterference.mat')
wifi512noInterference = wifi_throughput_no_interference;
load('WIFI1024BnoInterference.mat')
wifi1024noInterference = wifi_throughput_no_interference;

wifi2048noInterference = 0 .* ones(6,1);

% plot the WIFI throughput vs. const delay with different wifi packet size
figure,
semilogx(wifi_delay, wifi128noInterference, 'bo-', ...
    wifi_delay, wifi512noInterference,'c^-', ...
    wifi_delay, wifi1024noInterference, 'r*-', ...
    wifi_delay, wifi2048noInterference, 'ks-')
xlabel('constant delay (ms)')
ylabel('WiFi throughput (kbps)')
title('WiFi Throughput vs. Constant Delay Time')
legend('WiFi packet size = 128 byte',...
    'WiFi packet size = 512 byte',...
    'WiFi packet size = 1024 byte',...
    'WiFi packet size = 2048 byte')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS

% plot WIFI throughput with/without ZigBee Interference
figure,

