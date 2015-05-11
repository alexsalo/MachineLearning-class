% CSI 5325 -- Machine Learning
% Assignment 1
% Prof. Greg Hamerly, Baylor University
%
% Create some random data, fit a locally-weighted least-squares linear
% regression model, and plot the results. This problem uses 1-dimensional data.
function hwk_wls()
    m = 500;                             % the number of examples

    x = rand(m, 1) * 20;                 % create and scale random 1-dimensional input values
    X = [ones(m, 1), x];                 % the design matrix, including intercept term

    y = sin(x) ./ x;                     % an interesting target function
    epsilon = randn(m, 1) * std(y) / 5;  % create and scale Gaussian noise
    y = y + epsilon;                     % corrupt the outputs with noise

    tau = 1;                           % bandwidth -- play around with this

    % Create a vector of values that span the space of the inputs. We'll make
    % predictions on each value so we can see the shape of the regression model.
    xpredict = linspace(min(x), max(x));
    ypredict = zeros(size(xpredict));

    % loop and make a prediction for each value
    for i = 1:length(xpredict)
        % pull out the one value for convenience
        xval = xpredict(i);

        % initialize correct sizes of wts & theta
        wts = zeros(m); %!was mistake should me matrix!
        theta = zeros(2, 1);

        % YOUR CODE HERE:
        %   - FIND THE WEIGHTS
        for j = 1:length(wts)
            wts(j, j) = exp(-(norm(x(j)-xval))^2 / 2*tau^2);
        end

        %   - LEARN THETA WITH THESE WEIGHTS
        theta = inv(X'*wts*X) * (X'*(wts*y));
        
        % make the prediction (with the intercept term)
        ypredict(i) = [1 xval] * theta;
    end
    
    % plot the original data (scatterplot x's) and the regression line
    plot(x, y, 'x', xpredict, ypredict, '-', 'linewidth', 4);
    legend('training data', ['weighted least squares linear fit, tau = ', num2str(tau)]);
    xlabel('x');
    ylabel('y');
    return;
