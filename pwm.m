function [ signal ] = pwm( ratio, bits, F, Fs, T )
%pwm Create PWM signal with desired parameters
%
% ratio 0..1 sets the pulse width ratio
% bits  sets the PWM resolution
% F  defines the frequency at which the internal counter runs
% Fs is the sampling frequency of the produced signal in Hz
% T  is signal duration in seconds
%
% Juho Vesanen, 2017, MIT license

% Usually PWM signal is generated by having a sawtooth wave and a comparator.
% As this code mimics a microcontroller creating the PWM, this is a bit different.



% create a counter sequence, and make it run for F*T samples.
seq = 0:2^bits-1;
seq = repmat(seq, 1, ceil((F*T)/length(seq)));
seq = seq(1:(F*T));

% apply the comparator
seq = seq <= (ratio*2^bits-1);

% Resample it to Fs
seq = seq*2 -1;
seq = resample(seq, Fs, F);
seq = seq >= 0;
signal = double(seq);


end %function

