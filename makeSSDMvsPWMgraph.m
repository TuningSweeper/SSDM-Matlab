% This makes illustrative plots of the SSDM operation
%
% Juho Vesanen, 2017, MIT license

ratio_a = 0.1;
ratio_b = 0.7;
bits = 7;
length = 1000; % in samples


ssdm_signal = [ssdm(ratio_a, bits, 1, 1, length/2) ssdm(ratio_b, bits, 1, 1, length/2)];

pwm_signal = [pwm(ratio_a, bits, 1, 1, length/2) pwm(ratio_b, bits, 1, 1, length/2)];



figure;
subplot(2,1,1);
stairs(ssdm_signal, 'b','LineWidth',1);
hold on;
axis([0 length -0.1 1.1]);
title('SSDM with signal density of 10% and 70%');
grid on;

fs = [];
for n=0:size(ssdm_signal, 2)-1
    s = (((n-2^bits)>0) * (n-2^bits) + ((n-2^bits)<=0));
    fs = [fs mean(ssdm_signal(s:n))];
end


plot(fs, 'r','LineWidth',2);
set(gca,'XTick',[])
legend('SSDM signal','Averaged signal')


subplot(2,1,2);
stairs(pwm_signal, 'b','LineWidth',1);
hold on;
axis([0 length -0.1 1.1]);
title('PWM with duty cycle of 10 and 70%');
grid on;

fs = [];
for n=0:size(pwm_signal, 2)-1
    s = (((n-2^bits)>0) * (n-2^bits) + ((n-2^bits)<=0));
    fs = [fs mean(pwm_signal(s:n))];
end

plot(fs, 'r','LineWidth',2);
set(gca,'XTick',[])
legend('PWM signal','Averaged signal')

x0=0;
y0=0;
width=800;
height=400;
set(gcf,'units','points','position',[x0,y0,width,height]);

hgexport(gcf, 'media\SSDM_vs_PWM_10pct_70pct_sequence.png', hgexport('factorystyle'), 'Format', 'png');
