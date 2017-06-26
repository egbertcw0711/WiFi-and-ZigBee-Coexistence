close all

% load the corresponding data in the folder
% load('WiFi600BexponentialDelay.mat')

total_transmission = 500 * ones(14,1); % total transmission packets 

% plot ZigBee Throughput vs Exponential Delay
figure,
semilogx(mean_delay, mean_throughput, 'r*--')
xlabel('exponential delay (ms)')
ylabel('ZigBee throughput (kbps)')
title('ZigBee Throughput vs. Exponential Delay Time')
legend('Packet Size = 600B')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS

% calculate the packet error rate (%)
PLR = 100 * (total_transmission - num_rcvd_packets) ./ total_transmission;

% plot ZigBee Packet Error Rate vs Constant Delay
figure,
semilogx(mean_delay, PLR, 'r*--')
xlabel('exponential delay (ms)')
ylabel('ZigBee packet error rate (%)')
title('ZigBee Packet Error Rate vs. Exponential Delay Time')
legend('Packet Size = 600B')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS