% ======================================================================= %
%  The file read the data from the experiment we did from the data folder 
% ======================================================================= %
mean_delay = [200, 100, 50, 30, 20, 10, 5, 4, 3 , 2, 1, .5, .3, .1]';

[num_data,~] = size(mean_delay);
  
mean_throughput = zeros(num_data, 1);
num_rcvd_packets = zeros(num_data, 1);

% please select the log in correspond to the same order [200,100,...,.1]
for i = 1:num_data
    [mean_throughput(i),  num_rcvd_packets(i)] = get_mean_throughput();
end
