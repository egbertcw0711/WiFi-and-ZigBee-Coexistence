figure,
total_transmission = 100;

PLR50B = 100*(total_transmission - num_rcvd_packets50B) ./ total_transmission;
PLR100B = 100*(total_transmission - num_rcvd_packets) ./ total_transmission;

plot(transmission_interval, PLR50B, 'r*-', ...
    transmission_interval, PLR100B, 'bo--')
xlabel('ZigBee transmission interval (ms)')
ylabel('ZigBee packet error rate (%)')
title('Without WiFi Interference')
legend('ZigBee Packet Size = 50 Byte', 'ZigBee Packet Size = 100 Byte')
grid on