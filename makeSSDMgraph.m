% This makes illustrative plot of the SSDM operation.
%
% Juho Vesanen, 2017, MIT license

ratio = 0.4;
bits = 6;
length = 160; % in samples
average_length = 2^bits;

ssdm_signal = ssdm(ratio, bits, 1, 1, length);

figure;
stairs(ssdm_signal, 'b','LineWidth',1);
hold on;
axis([0 length -0.1 1.1]);
title('6-bit SSDM signal with signal density set at 40%');


fs = [];
for n=0:size(ssdm_signal, 2)-1
    s = (((n-2^bits)>0) * (n-2^bits) + ((n-2^bits)<=0));
    fs = [fs mean(ssdm_signal(s:n))];
end

plot(fs, 'r','LineWidth',2);
set(gca,'XTick',[])
grid on;
legend('SSDM signal','Averaged signal')

x0=0;
y0=0;
width=800;
height=250;
set(gcf,'units','points','position',[x0,y0,width,height]);

hgexport(gcf, 'media\SSDM_6bits_40pct_with_average.png', hgexport('factorystyle'), 'Format', 'png');
