function Band = spectrum_occ_exp( channels, samples, m, b )
%Spectrum Occupancy, Exponential Distribution
%   Returns matrix of randomly generated binary values simulating spectrum
%   occupancy.
%       channels = # of rows
%       samples = minimum # of columns
%       b = offset for generating mu
%       m = random number multiplier for generating mu

% Number of columns in channel matrix
n = 6*samples;

% Randomly generating mu
mu = m*rand + b;

% Generating single channel occupancy data
T = randi([0 1]);
for i = 1:samples
    del = exprnd(mu);
    if del < 1
        T = [T , 0];
    elseif del >= 1
        T = [T , ones(1, round(del))];
    end
end

% Generating band occupancy data
if channels < 2
    Band = T( 1 , 1:samples );
else    
    G = zeros(channels, n);
    G( 1 , : ) = [ T , zeros(1, n-size(T, 2)) ]; 
    for i = 2:channels
        mu = m*rand + b;
        T = randi([0 1]);
        for j = 1:samples
            del = exprnd(mu);
            if del < 1
                T = [T , 0];
            elseif del >= 1
                T = [T , ones(1, round(del))];
            end
        end
        G( i , : ) = [ T , zeros(1, n - size(T,2)) ];
    end
    Band = G( 1:channels , 1:samples );
end

end

