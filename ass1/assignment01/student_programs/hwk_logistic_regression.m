% CSI 5325 -- Machine Learning
% Assignment 1
% Prof. Greg Hamerly, Baylor University
%
% Implement logistic regression learning using gradient ascent and Newton's
% method. The parameter 'method' should be either 'gradient_ascent' or 'newton',
% to select the appropriate algorithm.
function hwk_logistic_regression(method)
    if (nargin < 1)
        method = 'gradient_ascent';
    end  
    x = load('logistic_data_x.txt'); % load the data
    y = load('logistic_data_y.txt');
    m = size(x, 1);             % number of examples
    
    %test
    testx1 = rand(m, 1) * 20 - 10; %gen some rand x
    testx2 = rand(m, 1) * 50 - 25;
    testy = zeros(m, 1);
    testx1((testx2 + testx1) < 10 & (testx2 + testx1) > 7) = 0; %clear separation
    testx2((testx2 + testx1) < 10 & (testx2 + testx1) > 7) = 0;
    testy((testx2 + testx1) > 10) = 1; % arbitrary classification 
    %testx2(testx2 < 10 & testx2 > 8) = -2;
    %testy(testx2 > 10) = 1;    
    testx = [testx1, testx2];
    x = testx; % testx
    y = testy; % testy
    
    X = [ones(m, 1), x];        % create the design matrix
    n = size(X, 2);             % number of features

    theta = zeros(n, 1);        % initialize theta

    % grad and H are the gradient vector and the Hessian matrix
    grad = ones(n, 1);          % initialize grad and H so that
    H = ones(n, n);             % the first iteration will execute
    alpha = 0.001;               % learning rate for gradient ascent -- play with this

    % the classification accuracy -- how well the thresholded value of the
    % hypothesis matches the given y.
    accuracy = 0;
    treshold = 0.5;

    iteration = 0;
    % several stopping criteria on the magnitude of the adjustments to theta
    % (or if we are perfectly classifying everything)
    while norm(H) > 1e-10 && norm(grad) > 1e-10 %&& accuracy < 1 
        iteration = iteration + 1

        % YOUR CODE HERE:
        %   - compute the accuracy
        pred = hwk_sigmoid(X * theta);
        pred(pred > treshold) = 1;
        pred(pred <= treshold) = 0;
        diff = sum(abs(y - pred));        
        accuracy = 1 - diff./length(y)
        
        %   - compute the gradient, grad
        for i = 1:length(theta)
            grad(i) = (y - hwk_sigmoid(X * theta))' * X(:, i);
        end
        
        %   - compute the Hessian, H       
        I = eye(m);
        G = zeros(m, m);
        for i = 1:m
            G(i, i) = hwk_sigmoid(X(i, :) * theta);
        end
        H = -X' * G * (I - G) * X;
        
        % Here, you should be calling sigmoid() (see below) to get the
        % hypothesis values for various computations.  You can compute H and
        % grad using triply nested loops (over all examples and pairs of
        % features), but see if you can reduce the number of loops using matrix
        % operations.
        


        % display the current value of H and grad
        H
        grad

        % take either a Newton-Raphson step or a gradient ascent step, and
        % display theta
        if (strcmp(method, 'newton'))
            theta = theta - inv(H) * grad
        elseif (strcmp(method, 'gradient_ascent'))
            theta = theta + alpha * grad
        else
            error('unknown learning algorithm')
        end

        plot_logistic_regression(X, y, theta);
        pause % wait for keystroke
        alpha = alpha * 0.995;
    end
    return

