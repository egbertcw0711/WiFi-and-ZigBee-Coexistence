% ======================================================================= %
% The main is the script loaded the data from the readData.m and further 
% did the data visualization in order to obeserve the WiFi behavior vs 
% with the exponential random delay added at the end of each tranmssion
% which is also change the WiFi transmission rate.
% ======================================================================= %

close all 
%% ========================= data visualization ======================== %%

% plot graph: mean delay vs. wifi throughput without ZigBee Interference
figure,
semilogx(mean_delay600B, mean_throughput600B, 'r*-',...
    mean_delay1112B, mean_throughput1112B, 'bo--');
title('WiFi Throughput vs. mean delay')
xlabel('mean delay (ms)')
ylabel('throughput (kbps)')
legend('packet size = 600B', 'packet size = 1112B')
grid on   
set(gca, 'XDir', 'reverse') % reverse the X-AXIS

% plot graph: mean delay vs.packet error rate(%) without ZigBee Interference
packet_loss_rate600B = 100 * (total_transmission600B - num_rcvd_packets600B) ./ ...
    total_transmission600B;
packet_loss_rate1112B = 100 * (total_transmission1112B - num_rcvd_packets1112B) ./ ...
    total_transmission1112B;

figure,
semilogx(mean_delay600B, packet_loss_rate600B, 'r*-', ...
    mean_delay1112B, packet_loss_rate1112B, 'bo--');
title('WiFi Packet error rate vs. mean delay')
xlabel('mean delay (ms)')
ylabel('packet loss rate (%)')
legend('packet size = 600B', 'packet size = 1112B')
grid on
set(gca, 'XDir', 'reverse')