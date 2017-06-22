% ======================================================================= %
% get_mean_throughput gets the mean throughput and total received packets 
% from the data, and calculate the number of packets received on the data 
% sheet you choose.
% ======================================================================= %

function [mean_throughput, num_rcvd_pkts] = get_mean_throughput()
    % choose the file from GUI prompt
    [filename, path] = uigetfile('*.*', 'Select the Text File');
    
    % check whether the file is open or not
    if(isempty(filename))
        disp('Error to open the file')
        return 
    end
    
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
    good_data = process_file(fp, filetype);

    % extract features from data matrix
    time_stamp = good_data(1:end-1,1);
    throughput = good_data(1:end-1,3);

    % get the desired parameters for further processing
    time_duration = time_stamp(end) - time_stamp(1);
    mean_throughput = sum(throughput) / time_duration; % kbps
    num_rcvd_pkts = good_data(end,2);


function good_data = process_file(filename, filetype)
    % process the ZigBee txt file
    if(filetype == 0)
        [time, data] = readLogData(filename); 
    % process the WiFi txt file
    else   
        fileID = fopen(filename, 'r');
        formatSpec = '%f %f %f';
        sizeA = [3 Inf]; % three column read all data in rows

        data = fscanf(fileID, formatSpec, sizeA);
        fclose(fileID);
        
        data = data';
        good_data = data_preproc(data); %
    end
    
    
% -------- functions below used for processing ZigBee .log File --------- %
function [ TIME, DATA ] = readLogData( filename )
%   [TIME, DATA] = readTimestampData(FILENAME)
%   reads the timestamps and data from FILENAME.
%
%   TIME is a vector of timestamps converted to seconds
%   DATA is a vector of the raw data from each packet

fileID = fopen(filename, 'r');
C = textscan(fileID, '%s %u %s %s', 'Delimiter', ','); % scan the log file

times = cell2mat(C{1}); % get time value matrix
DATA = cell2mat(C{4});  % get DATA value matrix

time_hours = str2num(times(:, 12:13)); % hour
time_minutes = str2num(times(:, 15:16)); % minute
time_seconds = str2num(times(:, 18:end)); % second

TIME = time_hours * 3600+time_minutes * 60 + time_seconds;



% --------- functions below used for processing WiFi .txt File ---------- %    
function good_data_out = data_preproc(data_in)

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
    
    good_data_out = data_in(index_start:index_end,:);
    
    
    
    
            
