# Matlab-SSDM
Matlab scripts for SSDM (vs PWM) illustration and spectral analysis.

Can be used to create SSDM (or PWM) signals with desired signal density, resolution, frequency, sampling rate and length. See [https://en.wikipedia.org/wiki/Stochastic_Signal_Density_Modulation](https://en.wikipedia.org/wiki/Stochastic_Signal_Density_Modulation) for more details on SSDM.


### ssdm(), pwm()

Create SSDM or PWM signal with desired parameters.

```
function varargout = ssdm( ratio, bits, F, Fs, T )
function [ signal ] = pwm( ratio, bits, F, Fs, T )
```

* ratio 0..1 - the desired average signal density or pulse width ratio
* bits - the SSDM/PWM resolution
* F - the frequency at which the internal counter runs
* Fs - the sampling frequency of the produced signal in Hz
* T - signal duration in seconds

Returns the generated signal.

Note that the ssdm() can also return the generated sequence of pseudo random numbers by returning two parameters: [signal randSeq] = ssdm( ratio, bits, F, Fs, T)

Keep in mind that the pwm() and ssdm() mimic a microcontroller producing the signal. The supplied parameter F actually defines the rate at which the internal counter runs. The fundamental frequency of the generated signal is defined by  F/(2^bits-1).




### lfsr()
Implements a Linear Feedback Shift Register, LFSR. This is used in various applications for creating a sequence of pseudo random numbers.

```
%   taps = lfsr(n);         - initializes the LFSR for n bits
%   val = lfsr(taps, val);  - get value from the LFSR. The first time the val
%                             must be a non-zero seed. For subsequent calls
%							 always use the previous value.
```
Example:
```
>>> taps = lfsr(4);
>>> val = lfsr(taps, 1)
2
>>> val = lfsr(taps, val)
4
>>> val = lfsr(taps, val)
9
>>> val = lfsr(taps, val)
3
>>> val = lfsr(taps, val)
6
```

## Scripts to generate illustrations and audio file
Illustrations originally created for Wikipedia article were created using the following scripts.

### makeSSDMgraph.m
Illustrates the nature of SSDM signal and how the average signal density approaches a desired value. Also, the repetitive nature of the signal is visible.
![SSDM signal with 5-bit resolution and 40% signal density](media/SSDM_6bits_40pct_with_average.png?raw=true "SSDM signal with 5-bit resolution and 40% signal density")

### makeSequenceGraph.m
Demonstrates SSDM signal generation. 5-bit pseudo random number sequence is shown with a desired threshold, and a SSDM signal generated from the sequence. Also the averaged SSDM signal is shown to demonstrate how the density approaches a desired value.
![SSDM Signal with 5-bit resolution and 30% signal density](media/SSDM_5bits_30pct_sequence.png?raw=true "SSDM Signal with 5-bit resolution and 30% signal density")

### makeSSDMvsPWMgraph.m
Illustrates the fundamental differences between SSDM and PWM signals at two different power levels, 10 and 70%.
![SSDM-PWM signal comparison](media/SSDM_vs_PWM_10pct_70pct_sequence.png?raw=true "SSDM-PWM signal comparison")

### makeSSDMvsPWMspectrum.m
Demonstrates the differences in amplitude spectrum of SSDM and PWM signals. It's clear that on SSDM the amplitude on the fundamental frequency is significantly lower than on the PWM. With SSDM the energy is shifted on the higher end of the spectrum.
![SSDM-PWM signal amplitude spectrum comparison](media/SSDM_vs_PWM_2khz_spectrum.png?raw=true "SSDM-PWM signal amplitude spectrum comparison")

### makeSSDMvsPWMaudio.m
Creates and audio file that contains few seconds of PWM signal followed by SSDM signal. This is to demonstrate the reduced amplitude on the fundamental frequency which is set to 2 kHz. [SSDMvsPWM.wav](media/SSDMvsPWM.wav)

## Copyright
Juho Vesanen, 2017.
Released under MIT license.