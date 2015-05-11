% CSI 5325 -- Machine Learning
% Assignment 1
% Prof. Greg Hamerly, Baylor University
%
% Implement maximum likelihood regression for a simple linear model without an
% intercept. Read the code below and make changes to estimate ml_theta,
% according to the maximum likelihood solution you derived by hand.
function hwk_mllr()
    m = 100;                      % the number of examples
    x = rand(m, 1);               % create some random input points
    y = x * 3;                    % the true theta is 3
    epsilon = randn(m, 1) * 0.1;  % create random Gaussian noise with sigma = 0.1
    y = y + epsilon;              % corrupt the outputs

    ml_theta = 0; % YOUR CODE HERE -- ESTIMATE THETA USING MAXIMUM LIKELIHOOD
    ml_theta = y'*x*inv(x'*x)
    
    % plot the data (scatterplot) and the regression line
    xplot = [min(x), max(x)]; % create two endpoints to plot the line
    plot(x, y, 'x', xplot, xplot * ml_theta, '-', 'linewidth', 4);
    legend('training data', 'maximum likelihood fit');
    xlabel('x');
    ylabel('y');
    return;
