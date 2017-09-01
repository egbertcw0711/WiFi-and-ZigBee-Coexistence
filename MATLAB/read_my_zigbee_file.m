% read the experiment data with interference
close all;
clc, clear
wifi_delay = [0,0.1,0.2,0.3,0.5,1,2,4,8,15,20,50,100,200]'; % delete 10
len = length(wifi_delay);

m = zeros(len,1);
% sd = zeros(len,1);
num = zeros(len,1);
maxi = zeros(len,1);
mini = zeros(len,1);

for i = 1:len
    [m(i), maxi(i), mini(i), num(i)] = process_file();
end

save('ZB10B10_WF1500Nexp205_new.mat')