function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% Add ones to the X data matrix
X = [ones(m, 1) X];

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%

predic = X*Theta1'; % make prediction on our training set -- 5000 x 25 (Theta1 25 x 401)
predicSigm = sigmoid(predic); %sigmoid first, THEN BIAS!!! EXTREMLY IMPORTANT
predicBias = [ones(size(predicSigm,1),1) predicSigm]; % 5000 x 26
predic2 = predicBias*Theta2'; % 5000 x 10 (Theta2 10 x 26)
predicSigm = sigmoid(predic2); % non obligatory step since just looking for max
[c, indeces] = max(predicSigm, [], 2); %looking for max elements and keep their index
p = indeces;

% =========================================================================


end
