close all,  
clc, clear

% All the unit is in microsecond

idles = [0, 100, 200, 300, 500, 1000, 2000, 4000, 5000,8000, 15000, 20000,...
    30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000]'; % us
x = 185;
Lw = 1528 * 8 / 54; % wifi bit transmission time us
sifs = 10; difs = 28;
Lz = 19 * 8 / 250 * 1000; % zigbee bit transmission time us
Tz = 10000; % 10 ms
b = 1 / 250 * 1000; % bit duration of 802.15.4

Tw = Lw + sifs + difs + idles;
Tc = -ones(length(idles),1);

for idx = 1:numel(Tw)
    tw = Tw(idx);
    if(x >= 0 && x <= Lz - 2*tw)
        Tc(idx) = Lz - 2*(tw - Lw);
    elseif(x > Lz - 2*tw && x <= tw - Lw)
        Tc(idx) = 2 * Lw;
    elseif(x > tw - Lw && x <= Lz - (tw+Lw))
        Tc(idx) = 3 * Lw + x - Tw;
    elseif(x > Lz - (tw+Lw) && x <= Lz - tw)
        Tc(idx) = Lz - 2*(tw - Lw);
    elseif(x > Lz - tw && x <= 2*tw - Lw)
        Tc(idx) = 2*Lw;
    elseif(x > 2*tw - Lw && x <= Lz - Lw)
        Tc(idx) = 3*Lw + x - 2*tw;
    elseif(x > Lz - Lw && x <= 2*tw)
        Tc(idx) = Lz - 2*(tw -Lw);
    elseif(x > 2*tw && x <= Tz)
        Tc(idx) = 2 * Lw;
    end
end


% bound1 = Lz - 2 * Tw;
% bound2 = Tw - Lw;
% bound3 = Lz - (Tw + Lw);
% bound4 = Lz - Tw;
% bound5 = 2*Tw - Lw;
% bound6 = Lz - Lw;
% bound7 = 2*Tw;
% bound8 = Tz;

Pb = 0.1; Pb_I = 0.95; % arbitary to choose 2 numbers to see the pattern
% figure,
% semilogy(idles./1000, Tc, 'o-');
% xlabel('Idle Times(ms)')
% ylabel('collistion time')

Per = 1 - (1 - (1-Pb).^(Lz - Tc ./ b)) .* (1 - (1-Pb_I).^(Tc ./ b));

figure,
semilogy(idles./1000, Per, 'o-')
xlabel('Idle Times(ms)')
ylabel('PER(%)')
