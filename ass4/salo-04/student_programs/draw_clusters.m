% CSI 5325 -- Machine Learning
% Assignment 4
% Prof. Greg Hamerly, Baylor University
%
% This function plots the first two dimensions a given set of data, colored
% according to its cluster, and the associated centroids.
%
% Parameters:
%   X: the m*n matrix of m examples having n features each
%   clusters: the m*1 vector of cluster assignments, from 1 to k
%   centroids: the k*n matrix of the cluster centroid positions
function draw_clusters(X, clusters, centroids)
    clf
    hold on

    k = size(centroids, 1);
    colors = ['bgrcmy']; % rotate through the colors in this order

    % plot the points in each cluster one at a time
    for j = 1:k
        in_cluster = clusters == j;
        plot_style = [colors(j), 'o'];
        plot(X(in_cluster, 1), X(in_cluster, 2), plot_style);
    end
    % plot a visible marker for each cluster center with a black background
    for j = 1:k
        in_cluster = clusters == j;
        plot(centroids(j,1), centroids(j,2), 'marker', 'o', 'markersize', 16, 'markerfacecolor', 'k');
        plot(centroids(j,1), centroids(j,2), 'marker', 'o', 'markersize', 10, 'markerfacecolor', colors(j));
    end
    hold off

