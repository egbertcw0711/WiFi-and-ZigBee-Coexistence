% ======================================================================= %
% get_mean_throughput gets the mean throughput and total received packets 
% from the data, and calculate the number of packets received on the data 
% sheet you choose.
% ======================================================================= %

function [mean_throughput, num_rcvd_pkts] = get_mean_throughput()
    % choose the file from GUI prompt
    [filename, path] = uigetfile('*.*', 'Select the Text File');   
    fp = strcat(path, filename); % file path
    
    % get the file extension
    [~, ~, ext] = fileparts(filename);
    if(strcmp(ext, '.txt')) % WiFi .txt Fil
        filetype = 1; 
    elseif(strcmp(ext, '.log')) % ZigBee .log File
        filetype = 0; 
    else    % if choose other file, restart the program
        disp('Please choose the right file')
        return
    end
    
    % -------------- data preprocessing -------------- %
    
    % good_data: [time_stamp, num_rcvd_pkts, instant_throughput]
    good_data = process_file(fp, filetype); 
    
    % extract features from data matrix
    throughput = good_data(1:end-1,2);

    % get the desired parameters for further processing
    mean_throughput = mean(throughput); % unit: kbps
    num_rcvd_pkts = good_data(end,1);


function good_data = process_file(filename, filetype)
    % process the ZigBee txt file
    if(filetype == 0)
        [time, data] = readLogData(filename); 
        good_data = ZigBeedata_preproc(time, data);
        
    % process the WiFi txt file
    else   
        fileID = fopen(filename, 'r');
        formatSpec = '%f %f %f';
        sizeA = [3 Inf]; % three column read all data in rows

        data = fscanf(fileID, formatSpec, sizeA);
        fclose(fileID);
        
        data = data';
        good_data = WiFidata_preproc(data); %
    end
    
    
% -------- functions below used for processing ZigBee .log File --------- %
function [ TIME, DATA ] = readLogData( filename )

    fileID = fopen(filename);
    fgetl(fileID); % escape the first two lines
    fgetl(fileID);

    C = textscan(fileID, '%s %u %s %s', 'Delimiter', ','); % scan the log file
    fclose(fileID);

    times = cell2mat(C{1}); % get time value matrix
    DATA = cell2mat(C{4});  % get DATA value matrix

    time_hours = str2num(times(:, 12:13)); % hour
    time_minutes = str2num(times(:, 15:16)); % minute
    time_seconds = str2num(times(:, 18:end)); % second

    TIME = time_hours * 3600+time_minutes * 60 + time_seconds;

function good_data_out = ZigBeedata_preproc(time_in, data_in)
    % packet_size = 100; % 5 is the header_length, total = 105 byte / packet
    packet_size_in_hex = (data_in(1, 5:6));
    packet_size = hex2dec(packet_size_in_hex) - 5;
    [num_packets, ~] = size(data_in);
    
    % calculate the instant throughput
    throughput = zeros(floor(num_packets/10),1);
    % time_stamp = throughput;
    packets = num_packets * ones(floor(num_packets/10),1);
    
    for i = 1:num_packets
       if(mod(i,10) == 0) % once every 10 packets, calculate the instant throughput
           Q = fix(i/10);
           % time_stamp(Q) = time_in(10*Q); % do not need time_stamp
           throughput(Q) = 10.0 * packet_size * 8 / (1000*(time_in(10*Q) - time_in(Q*10 - 9)));
       end
    end
    good_data_out = [packets, throughput];

% --------- functions below used for processing WiFi .txt File ---------- %    
function good_data_out = WiFidata_preproc(data_in)

    index_start = 0;
    [row, ~] = size(data_in);
    index_end = row;
    
    % find the start index which indicates the start of the collecting
    for i = 1:row
        if(data_in(i,3) ~= 0)
            index_start = i+1;
            break;
        end
    end
    
    % find the end index which indicates the end of the collecting
    for j = row:-1:1
        if(data_in(j,3) ~= 0)
            index_end = j;
            break;
        end
    end
    
    good_data_out = data_in(index_start:index_end,2:3);
    
