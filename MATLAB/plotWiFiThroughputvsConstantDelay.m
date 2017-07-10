% ======================================================================= %
% This script plot the WIFI Throughput vs. WIFI Constant Delay with
% different WIFI packet size
% ----------------------------------------------------------------------- %
% related experiment data: WiFiNoZB/
% related file: WIFI512noZB0710.mat  WiFi600noZB.mat   WiFi1112noZB.mat
% ======================================================================= %
load('WIFI512noZB0710.mat')

%% read the experiment data from the folder
wifi_throughput600 = zeros(7,1);
wifi_rcvd_pkts600 = zeros(7,1);
for i = 1:7
    [wifi_throughput600(i), wifi_rcvd_pkts600(i)] = get_mean_throughput();
end

wifi_throughput1112 = zeros(7,1);
wifi_rcvd_pkts1112 = zeros(7,1);
for i = 1:7
    [wifi_throughput1112(i), wifi_rcvd_pkts1112(i)] = get_mean_throughput();
end

%% load the pre-processed data if the data already exists
load('WiFi600noZB.mat')
load('WiFi1112noZB.mat')

%% visualize
figure,
loglog(wifi_delay, wifi_throughput_no_interference, 'r*-', ...
    wifi_delay, wifi_throughput600, 'b*-', ...
    wifi_delay, wifi_throughput1112, 'g*-')
xlabel('constant delay (ms)')
ylabel('WiFi throughput (kbps)')
title('WiFi Throughput vs. Constant Delay Time')
legend('Packet Size = 512B', 'Packet Size = 600B', 'Packet Size = 1112B')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS
