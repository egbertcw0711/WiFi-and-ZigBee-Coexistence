figure,
loglog(mean_delay, mean_throughput600B, 'r*-', ...
    mean_delay, mean_throughput, 'bo-')
xlabel('constant delay (ms)')
ylabel('WiFi throughput (kbps)')
title('WiFi Throughput vs. Constant Delay Time')
legend('Packet Size = 600B', 'Packet Size = 1112B')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS
