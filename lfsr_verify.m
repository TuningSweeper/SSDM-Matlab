% verifies that the LFSR is operating correctly for lengths 2-24 bits.
%
% Not really bullet proof, but makes sure that there aren't any stupid
% programming issues.
%
% Juho Vesanen, 2017, MIT license



for len=2:24

val = 1; % initial LFSR seed.
taps = lfsr(len); % initialize lfsr

nums = [];
    for n=1:2^len-1
        val = lfsr(taps, val);
        nums = [nums val];
    end

    % here we sort the list of random numbers, and make sure that
    % concecutive numbers are infact not the same :)
    ok = double(1);
    nums = sort(nums);
    for n=1:2^len-2
        if nums(n)>=nums(n+1)
            ok = 0;
        end
    end

    
    X = ['Length ',num2str(len), '     pass state ', num2str(ok)];
    disp(X);
    if ok == 0
        break;
    end
end