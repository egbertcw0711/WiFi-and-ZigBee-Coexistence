function TheoriticalMaxThroughput()
close all; clc, clear
% open the files
fileID_B = fopen('N:\windat.V2\WiFi\TMT\B472.txt', 'r');
fileID_B_CH1 = fopen('N:\windat.V2\WiFi\TMT\B472_ch1.txt', 'r');
fileID_B_CH6 = fopen('N:\windat.V2\WiFi\TMT\B472_ch6.txt', 'r');
fileID_G = fopen('N:\windat.V2\WiFi\TMT\G472.txt', 'r');
fileID_G_CH1 = fopen('N:\windat.V2\WiFi\TMT\G472_ch1.txt', 'r');
fileID_G_CH6 = fopen('N:\windat.V2\WiFi\TMT\G472_ch6.txt', 'r');
fileID_N = fopen('N:\windat.V2\WiFi\TMT\N472.txt', 'r');
fileID_N_CH1 = fopen('N:\windat.V2\WiFi\TMT\N472_ch1.txt', 'r');
fileID_N_CH6 = fopen('N:\windat.V2\WiFi\TMT\N472_ch6.txt', 'r');

formatSpec = '%f %f %f'; % file format
sizeA = [3 Inf]; % three column read all data in rows

% scan the txt files
G = fscanf(fileID_G, formatSpec, sizeA);
G_CH1 = fscanf(fileID_G_CH1, formatSpec, sizeA);
G_CH6 = fscanf(fileID_G_CH6, formatSpec, sizeA);

B = fscanf(fileID_B, formatSpec, sizeA);
B_CH1 = fscanf(fileID_B_CH1, formatSpec, sizeA);
B_CH6 = fscanf(fileID_B_CH6, formatSpec, sizeA);

N = fscanf(fileID_N, formatSpec, sizeA);
N_CH1 = fscanf(fileID_N_CH1, formatSpec, sizeA);
N_CH6 = fscanf(fileID_N_CH6, formatSpec, sizeA);

% close the files
fclose(fileID_B); fclose(fileID_B_CH1); fclose(fileID_B_CH6); 
fclose(fileID_G); fclose(fileID_G_CH1); fclose(fileID_G_CH6);
fclose(fileID_N); fclose(fileID_N_CH1); fclose(fileID_N_CH6);

% transpose the data
B = B'; G = G'; N = N';
B_CH1 = B_CH1'; G_CH1 = G_CH1'; N_CH1 = N_CH1';
G_CH6 = G_CH6'; B_CH6 = B_CH6'; N_CH6 = N_CH6';

% get the wifi throughput from the data
Throughput_B = WiFidata_preproc(B);
XB = 1:length(Throughput_B);

Throughput_B_CH1 = WiFidata_preproc(B_CH1);
XB_CH1 = 1:length(Throughput_B_CH1);

Throughput_B_CH6 = WiFidata_preproc(B_CH6);
XB_CH6 = 1:length(Throughput_B_CH6);

Throughput_G = WiFidata_preproc(G);
XG = 1:length(Throughput_G);

Throughput_G_CH1 = WiFidata_preproc(G_CH1);
XG_CH1 = 1:length(Throughput_G_CH1);

Throughput_G_CH6 = WiFidata_preproc(G_CH6);
XG_CH6 = 1:length(Throughput_G_CH6);

Throughput_N = WiFidata_preproc(N);
XN = 1:length(Throughput_N);

Throughput_N_CH1 = WiFidata_preproc(N_CH1);
XN_CH1 = 1:length(Throughput_N_CH1);

Throughput_N_CH6 = WiFidata_preproc(N_CH6);
XN_CH6 = 1:length(Throughput_N_CH6);

%% TMT
figure,
% plot the theoretical line
% TMT_G = 25.98 * ones(length(XG), 1); % RTS, CTS 1472
% TMT_G = 12.75 * ones(length(XG), 1); % RTS, CTS    472
% TMT_G = 31.2 .* ones(length(XG), 1); % no RTS, CTS  1472
TMT_G = 16.915.* ones(length(XG), 1); % no RTS, CTS  472
plot(XG, TMT_G, 'r:', 'LineWidth', 3)

hold on

plot(XG, Throughput_G ./ 1000, 'b^--', ...
    XN, Throughput_N ./ 1000, 'ms--')
xlabel('number of points')
ylabel('throughput (Mbps)')
title('Maximum Throughput for ESP8266 WIFI device without RTS & CTS')
grid on
hold off
legend('Theoretical Max Throughput for 802.11g', ...
    '802.11g', '802.11n')

%% Throughput on Different Channels
% figure,
% plot(XB, Throughput_B ./ 1000, 'b^:', ...
%     XB_CH1, Throughput_B_CH1 ./ 1000, 'r^:', ...
%     XB_CH6, Throughput_B_CH6 ./ 1000, 'c^:')
% legend('Channel 11', 'Channel 1', 'Channnel 6')
% xlabel('number of points')
% ylabel('throughput (Mbps)')
% title('802.11b')
% grid on
% 
% figure,
% plot(XG, Throughput_G ./ 1000, 'b^:', ...
%     XG_CH1, Throughput_G_CH1 ./ 1000, 'r^:', ...
%     XG_CH6, Throughput_G_CH6 ./ 1000, 'c^:')
% legend('Channel 11', 'Channel 1', 'Channnel 6')
% xlabel('number of points')
% ylabel('throughput (Mbps)')
% title('802.11g')
% grid on
% 
% figure,
% plot(XN, Throughput_N ./ 1000, 'b^:', ...
%     XN_CH1, Throughput_N_CH1 ./ 1000, 'r^:', ...
%     XN_CH6, Throughput_N_CH6 ./ 1000, 'c^:')
% legend('Channel 11', 'Channel 1', 'Channnel 6')
% xlabel('number of points')
% ylabel('throughput (Mbps)')
% title('802.11n')
% grid on


% ======================================================================= %
%                     BELOW ARE HELPER FUNCTIONS                          %
% ======================================================================= %
function good_data_out = WiFidata_preproc(data_in)

    index_start = 0;
    [row, ~] = size(data_in);
    index_end = row;
    
    % find the start index which indicates the start of the collecting
    for i = 1:row
        if(data_in(i,3) ~= 0)
            index_start = i+50;
            break;
        end
    end
    
    % find the end index which indicates the end of the collecting
    for j = row:-1:1
        if(data_in(j,3) ~= 0)
            index_end = j-1;
            break;
        end
    end
    
    good_data_out = data_in(index_start:index_end, 3);