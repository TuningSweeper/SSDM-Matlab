function varargout = ssdm( ratio, bits, F, Fs, T )
%ssdm Create SSDM signal with desired parameters
%
% ratio 0..1 sets the desired average signal density
% bits  sets the SSDM resolution
% F  defines the frequency at which the internal counter runs
% Fs is the sampling frequency of the produced signal in Hz
% T  is signal duration in seconds
%
% Returns the SSDM signal.
% If used like this: [signal randSeq] = ssdm(0.3, 8, 1, 1, 10)
% returns also the sequence of the random numbers.
%
% Juho Vesanen, 2017, MIT license


%initialize the LFSR used for the SSDM
val = 1; %seed
taps = lfsr(bits);

% create stream of random numbers using LFSR
for n = 1:1:T*F;
    val = lfsr(taps, val);
    randomSeq(:,n) = val;
end

% interpolate to desired length
randomSeq = interp1(randomSeq, linspace(1, T*F,T*F*(Fs/F)));

% do the actual modulation here
% note that the randomSeq contains numbers from 1 to 2^n-1 !!!

signal = randomSeq <= ((ratio * (2^bits-1) ));

varargout{1} = double(signal);
varargout{2} = randomSeq;


end %function

