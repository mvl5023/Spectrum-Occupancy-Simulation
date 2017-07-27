% Generates simulated spectrum occupancy data for a single channel

% Using built-in pseudorandom number generator

% Number of channels
channels = 20;
% Number of samples
samples = 1000;

% Parameters for determining occupancy densities of band data matrix
m = 10;
threshold = 5;

% Generating 3 individual channels with different occupancy densities
A = randi([0 1] , 1 , 1000);
B = randi([0 3] , 1 , 1000);
C = randi([-1 1] , 1 , 1000);
for i = 1:1000
    if B(i) > 0
        B(i) = 1;
    end
    if C(i) < 1
        C(i) = 0;
    end
end

U = zeros(channels, samples);  % Using uniform distribution
% Generating band occupancy data
for i = 1:channels
    for j = 1:samples
        temp = m * rand;
        if temp >= threshold
            U(i, j) = 1;
        elseif temp < threshold
            U(i, j) = 0;
        end        
    end
end

N = zeros(channels, samples);  % Using normal distribution
for i = 1:channels
    for j = 1:samples
        temp = m * randn;
        if abs(temp) < threshold
            N(i, j) = 1;
        elseif abs(temp) >= threshold
            N(i, j) = 0;
        end        
    end
end


% Plotting simulated occupancy data
m2 = 75;  % Changes color value of occupied regions of plot

% U = m2 .* U;
% figure
% image(V)
% colormap jet

N = m2 .* N;
figure
image(N)
colormap hot