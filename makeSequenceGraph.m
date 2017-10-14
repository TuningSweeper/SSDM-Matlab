% This makes illustrative plots of the SSDM operation
%
% Juho Vesanen, 2017, MIT license

ratio = 0.3;
bits = 5;
length = 64; % in samples


threshold = floor(ratio*2^bits);

[signal randomSeq] = ssdm(ratio, bits, 1, 1, length);



figure;
subplot(2,1,1);
stairs(randomSeq, 'b','LineWidth',1);
hold on;
x=1:size(randomSeq, 2);
y=threshold;
plot(x,y*ones(size(x)), 'r','LineWidth',2)
axis([0 length -0.1 2^bits]);
title('Pseudo random sequence and desired threshold');
grid on;


subplot(2,1,2);
stairs(signal, 'b','LineWidth',1)
hold on;
fs = [];
for n=0:size(signal, 2)-1
    s = (((n-32)>0) * (n-32) + ((n-32)<=0));
    fs = [fs mean(signal(s:n))];
end


plot(fs, 'r','LineWidth',2)
axis([0 length -0.1 1.1]);
title('SSDM signal');
grid on;
legend('SSDM signal','Averaged signal')

x0=0;
y0=0;
width=800;
height=400
set(gcf,'units','points','position',[x0,y0,width,height]);

hgexport(gcf, 'media\SSDM_5bits_30pct_sequence.png', hgexport('factorystyle'), 'Format', 'png');
