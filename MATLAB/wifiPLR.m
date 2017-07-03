%=========================================================================%
% Program for investigating WiFi packet error rate without interference   %
% Here considering the problem that STA encounters the problem when
% managing packet sizes.                                                  %
%=========================================================================%

close all

%% plot PER & PLR vs. different packet_size
%read csv file
data = csvread('wifiplr.csv',0,0);

packet_size = data(:,1); % different packet size as X-axis

packet_transmitted = data(:,2); % packets successfully transmitted

packet_rcvd = data(:,3); % packets successfully received

total_num_packets = 50000; % total number of packets to transmit

% packets that not successfully transmitted
packet_not_transmitted = total_num_packets - packet_transmitted;
PNT = packet_not_transmitted ./ total_num_packets;

% total packet loss
packet_not_rcvd = total_num_packets - packet_rcvd;
PER = packet_not_rcvd ./ total_num_packets;

% packets transmitted, but not received
PE = (packet_transmitted - packet_rcvd) ./ packet_transmitted;

% plot
figure,
semilogx(packet_size, PNT, 'r*-')
xlabel('packet size (bytes per packet)')
ylabel('Packet not transmitted ratio(%)')
title('Packet not transmitted ratio')
grid on

figure,
semilogx(packet_size, PE, 'r*-')
xlabel('packet size (bytes per packet)')
ylabel('transmission error (%)')
title('packet error through transmission')
grid on

figure,
semilogx(packet_size, PER, 'r*-')
xlabel('packet size (bytes per packet)')
ylabel('packet error rate (%)')
title('Packet Error Rate vs. PKT SIZE with constant delay 1ms')
grid on

%% plot Throughput vs. different packet_size
[num, ~] = size(packet_size);
throughput = zeros(num,1);

% select file that packet size in increasing order
% exclude the packet size 2048
for i = 1:num-1
   [throughput(i), ~] = get_mean_throughput();
end

% plot
figure,
semilogx(packet_size(1:5), throughput, 'r*-')
xlabel('packet size (bytes per packet)')
ylabel('throughput (kbps)')
title('WiFi Throughput vs. Different Packet Size')
grid on