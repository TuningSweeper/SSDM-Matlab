function returnValue = lfsr(varargin)
%lfsr Implements a Linear Feedback Shift Register
%
% Usage example:       
%   taps = lfsr(8);         - initializes the LFSR for 8 bits
%   val = lfsr(taps, val);  - get value from the LFSR. The first time
%                             the val must be a non-zero seed.
%
% This is not the only Matlab implementation of LFSR. See:
%    https://se.mathworks.com/matlabcentral/fileexchange/29119-lfsr
%    https://github.com/Nikeshbajaj/LFSR
%
% I decided to make my own, hopefully a bit more readable. Also, this
% implementation has all the taps set for 2-24 and 32b LFSRs.
%
%
% Juho Vesanen, 2017, MIT license


if length(varargin) == 1  % One param only --> init the LFSR
    bits = varargin{1};
    state = [1 zeros(1,bits-1)];
    switch bits
        case 2
            taps = [2 1];
        case 3
            taps = [3 2];
        case 4
            taps = [4 3];
        case 5
            taps = [5 3];
        case 6
            taps = [6 5];
        case 7
            taps = [7 6];
        case 8
            taps = [8 6 5 4];
        case 9
            taps = [9 5];
        case 10
            taps = [10 7];
        case 11
            taps = [11 9];
        case 12
            taps = [12 11 10 4];
        case 13
            taps = [13 12 11 8];
        case 14
            taps = [14 13 12 2];
        case 15
            taps = [15 14];
        case 16
            taps = [16 15 13 4];
        case 17
            taps = [17 14];
        case 18
            taps = [18 11];
        case 19
            taps = [19 18 17 14];
        case 20
            taps = [20 17];
        case 21
            taps = [21 19];
        case 22
            taps = [22 21];
        case 23
            taps = [23 18];
        case 24
            taps = [24 23 22 17];
        case 32
            taps = [32 22 2 1];
    end
    returnValue = taps;

else % Pull one pseudo random number out of the LFSR

    taps = varargin{1};
    state = de2bi(varargin{2}, taps(1));
   
    % the rightmost (MSB) tap.
    temp = state(taps(1));
    % all other taps.
    for i=2:length(taps);
         temp = xor( temp, state(taps(i)) );
    end
        
    % Add bit (temp) on the left. Take rightmost bit out.
    state = [temp state];
    state = state(1:length(state)-1);
    
    % Get the value of the state.
    % note! The LSB is on the right, at higher index!
    value = 0;
    for n=1:length(state);
        index = length(state) - (n-1);
        value = value + state(index) * 2^(index-1);
    end

    returnValue = value;
end


end % function
