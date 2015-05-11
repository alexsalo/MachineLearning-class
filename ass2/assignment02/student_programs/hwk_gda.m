% CSI 5325 -- Machine Learning
% Assignment 2
% Prof. Greg Hamerly, Baylor University
%
% Implement Gaussian Discriminant Analysis for the multivariate, multiclass
% setting for vowel identification. Train on the vowel training data, and then
% test on the vowel testing data, and report the overall accuracies.
function hwk_gda()
    train_data = load('vowel.train');

    % extract the target and the predictor variables for all the data
    x = train_data(:,2:11);
    y = train_data(:,1);

    [m,n] = size(x);

    % find out the number of classes
    unique_classes = unique(y);
    num_classes = length(unique_classes);

    % estimate the probability of each class
    phi = zeros(num_classes, 1);
    for i = 1:num_classes
        class = unique_classes(i);
        % YOUR CODE HERE -- CALCULATE PHI(I)
        phi(i) = length(y(y==class)) / m;
    end

    % estimate the mean for each class
    mu = zeros(num_classes, n);
    for i = 1:length(unique_classes)
        class = unique_classes(i);
        x_in_class = x(y == class,:);
        % YOUR CODE HERE -- CALCULATE MU(I,:)
        mu(i, :) = mean(x_in_class);
    end

    % estimate the common covariance matrix for the data centered on its
    % respective means
    sigma = eye(n, n);
    for i = 1:length(unique_classes)
        class = unique_classes(i);
        x_in_class = x(y == class,:);
        % YOUR CODE HERE -- UPDATE SIGMA
        diff = x_in_class - repmat(mu(i, :), length(x_in_class(:,1)), 1);
        sigma = sigma + diff'*diff;
    end
    % YOUR CODE HERE -- NORMALIZE SIGMA BY DIVIDING BY M
    sigma = sigma / m;
    % display what you have calculated
    phi
    mu
    sigma


    % make predictions on the train data
    train_confusion = hwk_gda_predict(x, y, mu, sigma, phi);
    disp('confusion matrix report for training set')
    analyze_confusion_matrix(train_confusion);

    % make predictions on the test data
    test_data = load('vowel.test');
    x_test = test_data(:,2:11);
    y_test = test_data(:,1);
    test_confusion = hwk_gda_predict(x_test, y_test, mu, sigma, phi);
    disp('confusion matrix report for test set')
    analyze_confusion_matrix(test_confusion);


