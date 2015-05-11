function plot_logistic_regression(X, y, theta)
    [m, n] = size(X);

    % plot the points and the predicted values
    if (n == 2)
        % do a 2-d plot
        plot(X(:,2), y, 'bx', ...
             X(:,2), hwk_sigmoid(X * theta), 'go' ...
             );
        xlabel('feature 1');
        ylabel('target');
    elseif (n > 2)
        % do a 3-d plot
        hold on
        gridsize = 20;
        for i = 1:n
            xplot(i,:) = linspace(min(X(:,i)), max(X(:,i)), gridsize);
        end
        yplot = zeros(gridsize, gridsize);
        for i = 1:gridsize
            for j = 1:gridsize
                yplot(j, i) = hwk_sigmoid([1, xplot(2,i), xplot(3, j), mean(X(:,4:end))] * theta);
            end
        end
        hold off
        plot3(X(:,2), X(:,3), y, 'bx');
        hold on
        mesh(xplot(2,:), xplot(3,:), yplot);
        hold off
        xlabel('feature 1');
        ylabel('feature 2');
        zlabel('target');
    end

    legend('training data', 'logistic regression curve');
