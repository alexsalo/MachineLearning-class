% CSI 5325 -- Machine Learning
% Assignment 4
% Prof. Greg Hamerly, Baylor University
%
% Implements the k-means algorithm. Your code should initialize the centers, and
% then perform the k-means updates (assign points to centers, move centroids)
% until convergence.
%
% Parameters:
%   X: the m*n matrix of m examples having n features each
%   k: the number of clusters
%
% Return values:
%   clusters: the m*1 vector of which cluster each example has gone to
%   centroids: the k*n matrix indicating the positions of the k centroids
function [J, step, clusters, centroids] = hwk_kmeans(X, k, isWaitForPlot, isSmartInit)
    % Read params
    %k = 3; %number of clusters
    m = size(X, 1); % number of examples
    n = size(X, 2); % number of features

    % Init centroids and clusters
    clusters = zeros(m, 1);
    centroids = zeros(k, n);

    % Guess centroids
    if isSmartInit
        centroids = centroids_farthest_first(X, m, k, centroids);
    else
        centroids = guess_centroids_randomly(X, m, k, centroids);
    end    
    
    % EM-optimize
    step = 0;
    prev_J = sum(sum(X.^2)); %init prev_J
    epsilon_convergence = 0.1;
    while(true) 
        step = step + 1

        % Distortion Function
        J = 0;

        % M-step:
        % Assign points to the clothest clusters
        for i = 1:m
            closest_cluster = 1;
            min_dist = sum((X(i, :) - centroids(closest_cluster, :)).^2);

            for j=2:k
                dist = sum((X(i, :) - centroids(j, :)).^2);
                if dist < min_dist
                    min_dist = dist;
                    closest_cluster = j;
                end
            end

            clusters(i) = closest_cluster;
            J = J + min_dist;
        end
        draw_clusters(X, clusters, centroids)

        % E-step:
        % Move centroids to the average location
        for i = 1:k    
            centroids(i, :) = sum(X(clusters == i, :)) / sum(clusters==i);    
        end
        
        % Stop to see current step's plot
        if isWaitForPlot
            waitforbuttonpress 
        end
        
        draw_clusters(X, clusters, centroids)

        [num2str(prev_J,5) ' -> ' num2str(J,5)]        
        
        % Convergence condition
        if J > prev_J - epsilon_convergence
            break;
        end        
        
        % Update prev_J
        prev_J = J;
    end
end



    
