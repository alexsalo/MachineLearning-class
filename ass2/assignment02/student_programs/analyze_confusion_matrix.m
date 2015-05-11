% CSI 5325 -- Machine Learning
% Assignment 2
% Prof. Greg Hamerly, Baylor University
%
% Given a confusion matrix, give a report on things like accuracy, per-class
% accuracy, etc.
%
% Parameters:
%   conf -- a k*k matrix of integer counts. Each row is assumed to be the
%           "true" class, and each column is assumed to be the "predicted"
%           class.
function analyze_confusion_matrix(conf)
    % compute the accuracy of all predictions
    accuracy = sum(diag(conf)) / sum(sum(conf))

    % compute the precision per class
    per_class_precision = diag(conf) ./ sum(conf, 2)

    % compute the base rate accuracy
    base_rate = max(sum(conf, 2)) ./ sum(sum(conf))

    % You may also be interested in other metrics like the per-class recall,
    % etc. We can calculate any such metric directly from the confusion matrix.
