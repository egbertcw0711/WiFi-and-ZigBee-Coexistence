figure,
transmission_interval = [500, 400, 300, 200, 100, 50, 10];
plot(transmission_interval, mean_throughput50B, 'r*-', ...
    transmission_interval, mean_throughput, 'bo-')
xlabel('transmission interval (ms)')
ylabel('ZigBee throughput (kps)')
title('ZigBee Throughput vs. Transmission Interval without WiFi Interference')
legend('ZigBee Packet Size = 50B', 'ZigBee Packet Size = 100B')
grid on
set(gca, 'XDir', 'reverse')