% This makes the audio file for comparing SSDM against PWM.
%
% Juho Vesanen, 2017, MIT license

ratio = 0.92;
bits = 8;
F_fundamental=2000;
Fs_calc = 5e6;
Fs_sound = 44100;
length = 3; % in seconds

pwm_signal = pwm(ratio, bits, F_fundamental*2^bits, Fs_calc, length);
ssdm_signal = ssdm(ratio, bits, F_fundamental*2^bits, Fs_calc, length);

a = resample(pwm_signal,Fs_sound,Fs_calc);
b = resample(ssdm_signal,Fs_sound,Fs_calc);
c = [a b];
sound(c, 44100, 8);
audiowrite('media\SSDMvsPWM.wav', c, Fs_sound);

