% CSI 5325 -- Machine Learning
% Assignment 2
% Prof. Greg Hamerly, Baylor University
%
% Implement ridge regression for the multivariate setting.  Read the code below
% and make changes to estimate ml_theta, according to the regularized least
% squares solution you derived by hand.
function hwk_ridge()
    data = load('prostate.data');

    % extract the target and the predictor variables for all the data
    x = data(:,1:8); % the last two columns are not predictor features
    y = data(:,9); % training signal is the lpsa column
    n = size(x, 2);

    % shift and re-scale the x & y data. After doing this, the y data should be
    % zero mean, so we don't need an intercept term (ones column in X).
    x = hwk_zscore(x);
    y = hwk_zscore(y);

    % find which examples are used for training (the rest are used for testing,
    % below)
    test = find(data(:,10) == 0);
    train = find(data(:,10) == 1);
    x_train = x(train,:);
    y_train = y(train,:);

    % YOUR CODE HERE -- CHANGE THIS TO EXPLORE VARIOUS VALUES OF LAMBDA
    lambda_values = [0, 0.2, 0.5, 1, 2, 3, 5, 10, 15, 20, 50, 60, 80, 100, 200, 500, 1000, 5000, 10000, 100000, 1000000];
    all_theta_values = [];
    for lambda = lambda_values

        % YOUR CODE HERE -- ESTIMATE THETA ON X_TRAIN USING REGULARIZED
        % LEAST-SQUARES
        theta = zeros(n, 1);
        theta = inv((x'*x + lambda*eye(n))) * x'*y;
        % save this value of theta for later
        all_theta_values(:,end+1) = theta;
    end

    % display what you have calculated
    all_theta_values

    % plot the values of theta as a function of lambda, and label each line
    figure(1)
    semilogx(lambda_values, all_theta_values')
    xlabel('\lambda');
    ylabel('coefficients');

    % this is a cell array, useful for when you want a list of strings of
    % different lengths
    labels = {'lcavol', 'lweight', 'age', 'lbph', 'svi', 'lcp', 'gleason', 'pgg45'};
    for i = 1:size(theta, 1)
        % put a label on the graph
        text(lambda_values(1) + 0.1, all_theta_values(i,1), labels{i});
    end

    % measure the non-regularized squared error on the test data as a function
    % of theta
    x_test = x(test,:);
    y_test = y(test,:);
    err = [];
    for ndx = 1:size(all_theta_values, 2)
        theta = all_theta_values(:,ndx);
        % YOUR CODE HERE -- FIND THE NON-REGULARIZED SUM OF SQUARED ERRORS FOR
        % THIS VALUE OF THETA        
        err(end+1) = (x*theta-y)'*(x*theta-y);
    end
    figure(2)
    plot(lambda_values, err);
    xlabel('\lambda');
    ylabel('sum of squared error on test data');

    % plot the squared length of theta as a function of lambda
    % YOUR CODE HERE -- FIND THE SQUARED LENGTH OF EACH THETA
    theta2 = zeros(1, size(all_theta_values, 2));
    for i = 1:size(all_theta_values, 2)
        theta = all_theta_values(:,i);
        theta2(i) = theta'*theta;
    end
    figure(3)
    plot(lambda_values, theta2);
    xlabel('\lambda');
    ylabel('squared length of \theta');
