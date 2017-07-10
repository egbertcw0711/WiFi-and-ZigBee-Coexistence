% ======================================================================= %
% This script is stand alone, there is no need related experiment data
% folder or the mat file. All the experiment data are typed in the matrix
% in the program
% ======================================================================= %

close all

wifi_delay = [0.1, 0.5, 5, 20, 50, 100, 200]';

zigbee_throughput_no_interference = 1.09 .* ones(7,1); % kbps
zigbee_throughput_interference = [0.725, 0.745, 0.755, 0.945, ...
    1.04, 1.075, 1.085]; % kbps

% visualize the data
plot(wifi_delay, zigbee_throughput_interference, 'bo-', ...
    wifi_delay, zigbee_throughput_no_interference, 'r--')
xlabel('wifi constant delay (ms)')
ylabel('zigbee throughput (kbps)')
legend('ZigBee Throughput under WiFi interference', ...
    'ZigBee Throughput without WiFi interference')

grid on