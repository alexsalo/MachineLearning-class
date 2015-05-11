function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

vals = [.01; .03; .1; .3; 1; 3; 10; 30];
errors = zeros(length(vals), length(vals));

for i = 1:length(vals);
for j = 1:length(vals);
    model = svmTrain(X, y, vals(i), @(x1, x2) gaussianKernel(x1, x2, vals(j))); 
    predictions = svmPredict(model, Xval);
    errors(i, j) = mean(double(predictions ~= yval));
	printf("i = %d, j = %d, error = %f\n",i,j,errors(i,j));
end
end

[ti,in] = min(errors);
[t2,in2] = min(ti);
sigma = vals(in2)
C = vals(in(in2));
printf("C = %f, sigma = %f", C, sigma);
end
