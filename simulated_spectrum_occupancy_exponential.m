% Generates simulated spectrum occupancy data for a single channel

% Exponential distribution

% Number of channels
channels = 20;
% Number of samples
samples = 1000;

% Number of columns in channel matrix
n = 5000;

% Randomly generating mu
offset = 0.12;
mu = 2*(rand + offset);

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
G = zeros(channels, n);
G( 1 , : ) = [ T , zeros(1, n-size(T, 2)) ]; 
for i = 2:channels
    mu = 2*(rand + offset);
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

G =42.*G;
figure
image(G)
colormap hot