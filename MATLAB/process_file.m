function [mean_throughput, maxi, mini, num_transmission] = process_file()
        [filename, path] = uigetfile('*.*', 'Select the Text File');    
        fp = strcat(path, filename); % file path
         
        fileID = fopen(fp, 'r');
        formatSpec = '%f %f %f';
        sizeA = [3 Inf]; % three column read all data in rows

        data = fscanf(fileID, formatSpec, sizeA);
        fclose(fileID);
        
        data = data';
        good_data = WiFidata_preproc(data); %
        num_transmission = good_data(end,2);
        mean_throughput = mean(good_data(:,1));
        % standarddv = std(good_data(:,1));
        maxi = max(good_data(:,1));
        mini = min(good_data(:,1));


function good_data_out = WiFidata_preproc(data_in)

    index_start = 0;
    [row, ~] = size(data_in);
    index_end = row;
    
    % find the start index which indicates the start of the collecting
    for i = 1:row
        if(data_in(i,3) ~= 0)
            index_start = i;
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