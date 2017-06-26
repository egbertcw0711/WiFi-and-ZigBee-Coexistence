close all

% load('constDelay.mat') % load the corresponding data in the folder
total_transmission = 500 * ones(14,1);
% plot WiFi Throughput vs Constant Delay at the end of WiFi transmission
figure,
semilogx(mean_delay, mean_throughput, 'bo--')
xlabel('constant delay (ms)')
ylabel('WiFi throughput (kbps)')
title('WiFi Throughput vs. Constant Delay Time')
% legend('Packet Size = 1112B')
legend('Packet Size = 600B')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS

% calculate the packet error rate
PLR = 100 * (total_transmission - num_rcvd_packets) ./ total_transmission;

% plot WiFi Packet Error Rate vs Constant Delay at the end of WiFi transmission
figure,
semilogx(mean_delay, PLR, 'bo--')
xlabel('constant delay (ms)')
ylabel('WiFi packet error rate (%)')
title('WiFi Packet Error Rate vs. Constant Delay Time')
legend('Packet Size = 1112B')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS