% CSI 5325 -- Machine Learning
% Assignment 1
% Prof. Greg Hamerly, Baylor University
%
% Implement the sigmoid function, g(z) = 1 / (1 + e^-z), in matlab.
%
% Your code should work correctly for z whether z is a scalar, vector, or a
% matrix. That is, the value returned, g, should be the same size and shape as
% z, with each entry of g being the sigmoid applied to the respective entry of
% z. If you use matrix notation, you don't need loops to do this.
function g = hwk_sigmoid(z)
    g = 1 ./ (1 + exp(-z)); 
end