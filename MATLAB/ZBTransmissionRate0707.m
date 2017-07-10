% ======================================================================= %
% This program is stand-alone, all the experiment data are in the script
%======================================================================== %

% ZigBee packet: unit in byte
infoSize = 10:10:100;
header = 6;
pktSize = infoSize + header;

% transmission time include serial port and zigbee
tmTime = [6.9, 9.2, 11.6, 13.9, 16.0, 18.4, 20.6, 23.0 25.4, 27.6];
baudRate = 57600;
serialBit = pktSize * (8 + 2);
serialTime = serialBit ./ baudRate * 1000; % milisecond

zigbeeTime = tmTime - serialTime; % milisecond

% plot info size vs. zigbee time ()
plot(infoSize, zigbeeTime)

% plot zigbee rate vs. zigbee time
size = infoSize(1:end-1);
deltaY = diff(infoSize) * 8; % bit
deltaX = diff(zigbeeTime); % milisecond
zigbeeRate = deltaY ./ deltaX;
plot(size, zigbeeRate, 'r*--') % kbps
xlabel('packet size (byte/packet)')
ylabel('zigbee rate (kbps)')
grid on


