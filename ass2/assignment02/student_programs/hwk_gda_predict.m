% CSI 5325 -- Machine Learning
% Assignment 2
% Prof. Greg Hamerly, Baylor University
%
% Predict the labels for each example in x, compare those labels with the ones
% given in y.
%
% Parameters:
%   x -- an m*n design matrix of examples to make predictions on
%   y -- an m*1 vector with a class label for each example
%   mu -- a k*n matrix of the mean vector for each class
%   sigma -- a n*n matrix which is the shared covariance
%   phi -- a k*1 vector which is the prior probability of each class
%
% Output:
%   conf -- the confusion matrix of the predictions for this set of data
function conf = hwk_gda_predict(x, y, mu, sigma, phi)
    [m, n] = size(x);
    k = size(mu, 1);

    % intialize conf -- the k*k confusion matrix, where entry conf(i,j) is the
    % number of times the true class i was predicted as class j
    conf = zeros(k, k);

    % precompute the inverse of sigma for later use
    sigma_inv = inv(sigma);

    % We use a doubly nested loop to go over all examples and all classes. We
    % could make this far more efficient (for Matlab) using vectorization, but
    % it would make the code less clear.
    coef = 1/((2*pi)^(n/2) * sqrt(det(sigma)));
    for i = 1:m
        p = zeros(k, 1);
        for class = 1:k
            % YOUR CODE HERE -- CALCULATE p(x|y=class) * p(y=class)
            diff = x(i, :) - mu(class, :);
            pxy = coef * exp( -1/2 * diff * sigma_inv * diff');
            py = phi(class);
            p(class) = pxy * py;         
            % Note that we could calculate p(x|y=class) * p(y=class) / p(x), but
            % we don't use p(x) here. Computing p(x) (the denominator) requires
            % computing and summing all the numerator terms first, and we are
            % keeping each of them in p, so we normalize after the loop is over.
        end

        % apply the p(x) correction -- not necessary, but nice to do anyway --
        % however, this will cause an error if sum(p) = 0
        p = p / sum(p);

        % find the most probable class
        [max_prob, predicted_class] = max(p);

        % update the confusion matrix for this example's prediction
        conf(y(i), predicted_class) = conf(y(i), predicted_class) + 1;
    end


