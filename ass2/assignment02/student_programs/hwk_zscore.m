% CSI 5325 -- Machine Learning
% Assignment 2
% Prof. Greg Hamerly, Baylor University
%
% Z-score a dataset. Return a matrix of the same size where each column has been
% normalized to have mean 0 and standard deviation 1. Use the functions "mean",
% "std", "repmat", and element-wise division (./) to help you do this in one
% line.
%
% Parameters:
%   x -- a matrix or vector of values
%
% Return value:
%   x -- the same size as input, but each column has zero-mean and variance 1
function x = zscore(x)
    % YOUR CODE HERE -- MODIFY X SO THAT EACH COLUMN HAS MEAN OF ZERO AND
    % STANDARD DEVIATION OF ONE
    m = size(x, 1);
    x = (x - repmat(mean(x),m,1))./repmat(sqrt(var(x)),m,1);
    return