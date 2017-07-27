% Generates simulated spectrum occupancy data for a single channel

% Poisson distribution

% Number of channels
channels = 20;
% Number of samples
samples = 1000;

% Number of columns in channel matrix
n = 5000;

% Randomly generating lambda
offset = 0.1;
m = 0.6;
lambda = m*rand + offset;

% Generating single channel occupancy data
R = randi([0 1]);
for i = 1:samples
    del = poissrnd(lambda);
    if del == 0
        R = [R , del];
    elseif del > 0
        R = [R , ones(1, del)];
    end
end

% Generating band occupancy data
W = zeros(channels, n);
W( 1 , : ) = [ R , zeros(1, n-size(R, 2)) ]; 
for i = 2:channels
    lambda = m*rand + offset;
    R = randi([0 1]);
    for j = 1:samples
        del = exprnd(lambda);
        if del < 1
            R = [R , 0];
        elseif del >= 1
            R = [R , ones(1, round(del))];
        end
    end
    W( i , : ) = [ R , zeros(1, n - size(R,2)) ];
end

W =40.*W;
figure
image(W)
colormap hot