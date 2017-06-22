% ======================================================================= %
% This program plot the zigbee throughput / zigbee packet error rate vs. 
% wifi constant delay with two different packet size (600B and 1112B) from
% the csv data in the same fold "DutyCycle.csv"
% CORRECT THE GRAPHS FROM THE LAST WEEK
% ======================================================================= %

close all
totalPackets = 500;

Data = csvread('DutyCycle.csv', 1, 0);

delay = Data(:,1);
throughput600B = Data(:,3);
throughput1112B = Data(:,5);
rcvd_600Bpackets = Data(:,7);
rcvd_1112Bpackets = Data(:,8);

num_error600B = totalPackets - rcvd_600Bpackets;
num_error1112B = totalPackets - rcvd_1112Bpackets;
PLR600B = 100 * num_error600B ./ totalPackets; % change decimal to percentage
PLR1112B = 100 * num_error1112B ./ totalPackets;

% plot wifi delay vs. zigbee throughput
figure,
semilogx(delay, throughput600B, 'r*-', delay, throughput1112B, 'bo-');
title('WiFi Transmissin Delay vs. ZigBee Throughput')
xlabel('WiFi Constant Delay (ms)')
ylabel('ZigBee Throughput (kbps)')
legend('packet size = 600B', 'packet size = 1112B')
grid on
set(gca, 'XDir', 'reverse')

% plot wifi delay with zigbee packet error
figure,
semilogx(delay, PLR600B, 'r*-', delay, PLR1112B, 'bo-');
title('WiFi Transmission Delay vs. ZigBee Pakcet loss')
xlabel('WiFi Constant Delay (ms)')
ylabel('ZigBee Packet Loss (%)')
legend('packet size = 600B', 'packet size = 1112B')
grid on
set(gca, 'XDir', 'reverse')