% Read original sources
source1 = audioread('harris.wav')
source2 = audioread('swift.wav')
figure; plot(source1,source2, '.')
%sound(source1)
%sound(source2)

signal = [source1, source2]';

% Mix the sources - imitation of microphones
A = [0.55, 0.45; 0.4, 0.6]
X = A * signal; 
    % inv(A) * X gives the solutionm but we will try 
    % to learn it with W
mix1 = X(1, :);
mix2 = X(2, :);
figure; plot(mix1, mix2, '.')
%sound(mix1)
%sound(mix2)

% ICA (Independent Component Analysis)
[n, m] = size(x)
chunk = 100 % to avoid huge matrix
W = eye(n); % guess W
alpha = 0.0005; % learning rate

for iter = 1:10 % could be smarter condition of convergence
    X = X(:, randperm(m)); % to learn differently - avoid local minimum
    for i=1:floor(m/chunk) % for each chunk of data
        Xc = X(:, (i-1)*chunk+1 : i*chunk); % just selecting that chunk of X
        % log-likelihood function is sum(log(|W| prod(p_s(W'*x))) - model
        % Take the derivative with respect to W
        dW = (1 - 2./(1 + exp(-W * Xc)))*Xc' + chunk * inv(W');
        W = W + alpha * dW;
    end
end

signal_derived = W' * x;

s1 = signal_derived(1, :);
s2 = signal_derived(2, :);
figure; plot(s1, s2, '.')
% Play derived signal
%sound(s1)
%sound(s2)