function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%
t1 = X*theta; %12x2 * 2x1 = 12x1
t2 = t1 - y; %12x1
t3 = t2.^2; 
t4 = sum(t3); %1x1
ersum = t4/(2*m);
regsum = sum(theta(2:size(theta,1)).^2)*lambda/(2*m);
J = ersum + regsum;
%
grad = X'*(X*theta-y)/m + (lambda*theta)./m;
grad(1) = grad(1) - lambda*theta(1)/m; %exluding bias regulariztion
% =========================================================================

grad = grad(:);

end
