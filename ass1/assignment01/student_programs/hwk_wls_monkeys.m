% CSI 5325 -- Machine Learning
% Assignment 1
% Prof. Greg Hamerly, Baylor University
%
% Create some random data, fit a locally-weighted least-squares linear
% regression model, and plot the results. This problem uses 1-dimensional data.
function hwk_wls()
    x = load('monkeys_m20_x.txt'); % load the data
    y = load('monkeys_m20_y.txt');
    m = size(x, 1);             % number of examples
    X = [ones(m, 1), x];

    tau = 0.3;                           % bandwidth -- play around with this

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
    
    set (0, "defaultaxesfontname", "Helvetica") % this is the line to add BEFORE plotting
    hold on;
    % plot the original data (scatterplot x's) and the regression line
    plot(x, y, 'x', xpredict, ypredict, '-', 'linewidth', 4);
    legend('training data', ['weighted least squares linear fit, tau = ', num2str(tau)]);
    xlabel('x');
    ylabel('y');
    set(gca,'XMinorTick','on');
    %print -deps m20.eps
    return;
