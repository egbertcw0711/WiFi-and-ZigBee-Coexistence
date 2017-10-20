%% simulation
clear, clc,

time_stamp = zeros(1,20000000); % simulate 100s and time interval 5us
time_interval = 5; % us

wifi_delays = [0, 100, 200, 300, 500, 1000, 2000, 4000, 5000,8000, 15000, 20000,...
    30000, 40000, 50000];%, 60000, 70000, 80000, 90000, 100000];
throughputs = zeros(1, length(wifi_delays));

% create WiFi signal
for j = 1:length(wifi_delays)
    transmission_interval = wifi_delays(j); % us
    header = zeros(1,27); % backoff time 135us
    transmission_time = 1528 * 8 / 54; % us
    num_time_inter = ceil(transmission_time / time_interval);
    transwifi = ones(1,num_time_inter); % tansmission time on PHY
    idle = zeros(1,transmission_interval/time_interval); % idle time, 1600 * 5us = 10ms
    perwifi = [transwifi, idle]; % transmission interval
    WiFi = repmat(perwifi,[1,ceil(20000000/length(perwifi))]);
    WiFi = [header, WiFi];
    WiFi = WiFi(1:20000000); % WiFi transmission during the first 100ms

    % creare ZigBee signal
    transmission_interval = 10000; % us
    header = zeros(1, 64); % backoff time 320us
    transmission_time_zb = 19 * 8 / 250 * 1000; % us
    num_time_inter_zb = ceil(transmission_time_zb / time_interval);
    transzb = ones(1, num_time_inter_zb);
    idle = zeros(1, transmission_interval/time_interval - num_time_inter_zb);
    perzb = [transzb, idle];
    ZB = repmat(perzb, [1,ceil(20000000/length(perzb))]);
    ZB = [header,ZB];
    ZB = ZB(1:20000000);

    % C = zeros(1,20000000);
    count = 0;
    rcvd = 0;
    for i = 1:length(ZB)-1
        
        % version 1: only wifi and zigbee packet collides at the beginning 
        % and the end of zigbee packets are considered collision
%         if(count == 0)
%             if(ZB(i) == 1 && WiFi(i) == 0)
%                 count = count + 1;
%             end
%         else
%             if(ZB(i) == 1)
%                 count = count + 1;
%                 if(count == 122 && WiFi(i) == 0)
%                     rcvd = rcvd + 1; 
%                     count = 0;
%                 elseif (count == 122 && WiFi(i) == 1)
%                     count = 0;
%                 end
%             end
%         end

       % version 2: whenever wifi and zigbee packets overlap are considered
       % collision
       if(ZB(i) == 1 && WiFi(i) == 0)           
           if(ZB(i+1) == 1 && WiFi(i+1) == 0)
               count = count + 1;
               if(count == 121)
                    rcvd = rcvd + 1;
                    count = 0;
               end
           else
                count = 0;
           end 
       end
    end

    throughputs(j) = rcvd * 10 * 8 / 100000; % kbps
end

%% plotting
semilogx(wifi_delays/1000, throughputs, 'r*-')
xlabel('wifi delay (ms)')
ylabel('zigbee throughput (kbps)')
title('wifi and zigbee always transmit')
grid on
