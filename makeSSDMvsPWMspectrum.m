% This illustrates the spectrum of SSDM & PWM signals.
%
% Juho Vesanen, 2017, MIT license

ratio = 0.3;
bits = 8;
Fs = 10e6;
F_fundamental = 2000;

ssdm_signal = ssdm(ratio, bits, F_fundamental*2^bits, Fs, 0.5);
pwm_signal = pwm(ratio, bits, F_fundamental*2^bits, Fs, 0.5);


% process the SSDM signal
L = size(ssdm_signal,2);
w = hamming(L)';
ssdm_signal = ssdm_signal .* w;
Y = fft(ssdm_signal);
P2 = mag2db(abs(Y/L));
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
ssdm_signal = P1;

% process the PWM signal
L = size(pwm_signal,2);
w = hamming(L)';
pwm_signal = pwm_signal .* w;
Y = fft(pwm_signal);
P2 = mag2db(abs(Y/L));
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
pwm_signal = P1;



figure;

subplot(2,1,1);
semilogx(f,ssdm_signal,'b','LineWidth',2)
axis([2.9e3 1e6 -100 -40]);
title('SSDM signal amplitude spectrum');
grid on;
xlabel('Frequency (Hz)')
ylabel('Amplitude (dB)')

subplot(2,1,2);
semilogx(f,pwm_signal,'b','LineWidth',2)
axis([2.9e3 1e6 -100 -40]);
title('PWM signal amplitude spectrum');
grid on;
xlabel('Frequency (Hz)')
ylabel('Amplitude (dB)')

x0=0;
y0=0;
width=800;
height=400;
set(gcf,'units','points','position',[x0,y0,width,height]);

hgexport(gcf, 'media\SSDM_vs_PWM_2khz_spectrum.png', hgexport('factorystyle'), 'Format', 'png');
