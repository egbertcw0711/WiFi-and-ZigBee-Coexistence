% ======================================================================= %
% get_mean_throughput gets the mean throughput from the data, and calculate
% the number of packets received on the data sheet you chose.
% ======================================================================= %

function [mean_throughput, num_rcvd_pkts] = get_mean_throughput()
    [filename, path] = uigetfile('.txt', 'Select the Text File');
    fp = strcat(path, filename);
    filetype = 1; % 0 ZigBee data (under-develop), 1 WiFi data
    good_data = process_txt_file(fp, filetype);

    % extract features from data matrix
    time_stamp = good_data(1:end-1,1);
    throughput = good_data(1:end-1,3);

    % data processing
    time_duration = time_stamp(end) - time_stamp(1);
    mean_throughput = sum(throughput) / time_duration; % kbps
    num_rcvd_pkts = good_data(end,2);


function good_data = process_txt_file(filename, filetype)
    fileID = fopen(filename, 'r');
    % process the ZigBee txt file
    if(filetype == 0)
        return 
    % process the WiFi txt file
    else   
        formatSpec = '%f %f %f';
        sizeA = [3 Inf]; % three column read all data in rows

        data = fscanf(fileID, formatSpec, sizeA);
        fclose(fileID);
        
        data = data';
        good_data = data_preproc(data); %
    end

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
    
    
    
    
            
