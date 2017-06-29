% WiFi total transmission packets
total_transmission = 1e3 * [.5, .5, .5, .5, 5, 50, 50, 50, 50, 50, 50, 50, 50, 50]';
% ZigBee total transmission packets
% total_transmission = 500 * ones(14,1);

% calculate the packet error rate
PLR0600B = 100 * (total_transmission - num_rcvd_packets600B) ./ total_transmission;
PLR1112B = 100 * (total_transmission - num_rcvd_packets) ./ total_transmission;

% plot WiFi Packet Error Rate vs Constant Delay at the end of WiFi transmission
figure,
loglog(mean_delay, PLR0600B, 'r*-', mean_delay, PLR1112B, 'bo-')
xlabel('constant delay (ms)')
ylabel('WiFi packet error rate (%)')
title('WiFi Packet Error Rate vs. Constant Delay Time')
legend('Packet Size = 600B', 'Packet Size = 1112B')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS