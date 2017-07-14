%=========================================================================%
% Program for investigating WiFi throughput with/withput ZigBee interference
% the data are in the WiFiUnderZB/ and WiFiNoZB/ folder, and corresponding
% mat file. 
%-------------------------------------------------------------------------%
% related experiment data: WiFiUnderZB/ *.mat   and   WiFiNoZB/ *.mat
%=========================================================================%

close all

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

%% load the data
wifi_delay = [0.1, 5, 20, 50, 100, 200]';
wifi_exp_delay = [20, 50, 100, 200]';

% wifi thrpughput no interference
load('.\WiFiNoZB\WIFI128BnoInterference.mat')
wifi128noInterference = wifi_throughput_no_interference;

load('.\WiFiNoZB\WIFI512BnoInterference.mat')
wifi512noInterference = wifi_throughput_no_interference;

load('.\WiFiNoZB\WIFI1024BnoInterference.mat')
wifi1024noInterference = wifi_throughput_no_interference;

wifi2048noInterference = 0 .* ones(6,1);

% wifi throughput with interference 
load('.\WiFiUnderZB\WIFI128BwithInterference10B10ms.mat')
wifi128withInterference10B10ms = wifi_throughput_interference;

load('.\WiFiUnderZB\WIFI512underZB100B25ms_0711.mat')
wifi512withInterference100B25ms = wifi_throughput_interference;

load('.\WiFiUnderZB\WIFI512underZB10B25ms_0711.mat')
wifi512withInterference10B25ms = wifi_throughput_interference;

load('.\WiFiUnderZB\WIFI512underZB10B10ms_0713.mat')
wifi512withInterference10B10ms = wifi_throughput_interference;

load('.\WiFiUnderZB\WIFI1024underZB10B10ms_0713.mat')
wifi1024withInterference10B10ms = wifi_throughput_interference;

load('.\WiFiUnderZB\WIFI512expUnderZB10byte10ms.mat')
wifi512expwithInterference10B10ms = wifi_throughput_interference;
%% Visualization
% WIFI throughput vs. const delay with different wifi packet size no Inter
figure,
loglog(wifi_delay, wifi128noInterference, 'bo-', ...
    wifi_delay, wifi512noInterference,'c^-', ...
    wifi_delay, wifi1024noInterference, 'r*-', ...
    wifi_delay, wifi2048noInterference, 'ks-')
xlabel('WiFi constant delay (ms)')
ylabel('WiFi throughput (kbps)')
title('WiFi Throughput vs. Constant Delay Time')
legend('WiFi packet size = 128 byte',...
    'WiFi packet size = 512 byte',...
    'WiFi packet size = 1024 byte',...
    'WiFi packet size = 2048 byte')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS

% WIFI512 throughput with exponential delay
figure,
loglog(wifi_delay, wifi512noInterference, 'c*-', ...
    wifi_delay, wifi512withInterference10B10ms, 'bo-', ...
    wifi_exp_delay, wifi512expwithInterference10B10ms, 'rs-')
xlabel('WiFi delay (ms)')
ylabel('WiFi throughput (kbps)')
legend('WiFi No Interference', 'WiFi Interference const delay',...
    'WiFi Interference exponential delay')
grid on,
set(gca, 'XDir', 'reverse') % reverse the X-AXIS

% WIFI 128,512,1024 Byte throughput with/without ZigBee Interference
figure,
loglog(wifi_delay, wifi128noInterference, 'r*-', ...
    wifi_delay, wifi128withInterference10B10ms, 'bo-')
hold on,

loglog(wifi_delay, wifi512noInterference, 'r*--', ...
    wifi_delay, wifi512withInterference10B10ms, 'bo--')

loglog(wifi_delay, wifi1024noInterference, 'r*:', ...
    wifi_delay, wifi1024withInterference10B10ms, 'bo:')

xlabel('WiFi constant delay (ms)')
ylabel('WiFi throughput (kbps)')
legend('WiFi Packet Size 128', '','WiFi Packet Size 512', '',...
    'WiFi Packet Size 1024', '')
title('WiFi throughput with constant delay')
set(gca, 'XDir', 'reverse') % reverse the X-AXIS
grid on

% WiFi 512 Byte throughput with different zigbee packet size and 
% different zigbee transmission interval
figure, % with different zigbee packet size
loglog(wifi_delay, wifi512noInterference, 'r*-',...
    wifi_delay, wifi512withInterference10B25ms, 'bo--', ...
    wifi_delay, wifi512withInterference100B25ms, 'c^:')
xlabel('WiFi constant delay (ms)')
ylabel('WiFi throughput (kbps)')
title('WiFi Throughput with different ZigBee(25 ms) Packet Size')
legend('WiFi no Interference', 'ZigBee Packet size 10 byte', ...
    'ZigBee Packet size 100 byte')
set(gca, 'XDir', 'reverse') % reverse the X-AXIS
grid on


figure, % with different zigbee transmission time
loglog(wifi_delay, wifi512noInterference, 'r*-', ...
    wifi_delay, wifi512withInterference10B10ms, 'bo--', ...
    wifi_delay, wifi512withInterference10B25ms, 'c^:')
xlabel('WiFi constant delay (ms)')
ylabel('WiFi throughput (kbps)')
title('WiFi Throughput with different ZigBee(10 byte) Transmission Interval')
legend('WiFi no Interference', 'ZigBee transmission interval 10 ms', ...
    'ZigBee transmission interval 25ms')
set(gca, 'XDir', 'reverse') % reverse the X-AXIS
grid on

