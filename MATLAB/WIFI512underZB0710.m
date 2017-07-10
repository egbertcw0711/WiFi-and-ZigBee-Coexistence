%=========================================================================%
% Program for investigating WiFi throughput under ZigBee interference     %
% the data are in the WiFiUnderZB/ and WiFiNoZB/ folder, and corresponding
% mat file is in the same folder called the same name as the script. 
%-------------------------------------------------------------------------%
% related file: WIFI512underZB0710.mat, WIFI512noZB0710.mat
% related experiment data: WiFiUnderZB/   and   WiFiNoZB/
%=========================================================================%

close all
wifi_delay = [0.1, 0.5, 5, 20, 50, 100, 200]';

%% read the experiment data with interference
wifi_throughput_interference = zeros(7,1);
wifi_rcvd_pkts_interference = zeros(7,1);

for i = 1:5
    [wifi_throughput_interference(i), wifi_rcvd_pkts_interference(i)] = ...
        get_mean_throughput();
end

wifi_throughput_interference(6) = 40.96;
wifi_throughput_interference(7) = 20.48;
wifi_rcvd_pkts_interference(6) = 500;
wifi_rcvd_pkts_interference(7) = 500;

%% read the experiment data no interference
wifi_throughput_no_interference = zeros(7,1);
wifi_rcvd_pkts_no_interference = zeros(7,1);

for i = 1:5
    [wifi_throughput_no_interference(i), wifi_rcvd_pkts_no_interference(i)] = ...
        get_mean_throughput();
end

wifi_throughput_no_interference(6) = 40.96;
wifi_throughput_no_interference(7) = 20.48;
wifi_rcvd_pkts_no_interference(6) = 500;
wifi_rcvd_pkts_no_interference(7) = 500;

%% visualization the data
figure,
plot(wifi_delay, wifi_throughput_interference, 'bo-', ...
    wifi_delay, wifi_throughput_no_interference, 'r*--')
xlabel('constant delay (ms)')
ylabel('WiFi throughput (kbps)')
title('WiFi Throughput vs. Constant Delay Time')
legend('WiFi Throughput Under ZigBee Interefence',...
    'WiFi Throughput No Interference')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS
