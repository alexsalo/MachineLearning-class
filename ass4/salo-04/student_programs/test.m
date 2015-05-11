% Test
% Parameters:
%   X: the m*n matrix of m examples having n features each
%   clusters: the m*1 vector of cluster assignments, from 1 to k
%   centroids: the k*n matrix of the cluster centroid positions

X = load('X.dat');

% Test initialization methods
k = 3;
hwk_kmeans(X, k, true, false);
hwk_kmeans(X, k, true, true);

% Find the optimal k
num_clusters = 6;
num_runs = 15;
kmeans_result = zeros(num_runs, num_clusters);
kmeans_convergence = zeros(num_runs, num_clusters);

for i = 1:num_clusters
    for j = 1:num_runs    
        [J, step, ~, ~] = hwk_kmeans(X, i, false, false);
        kmeans_result(j, i) = J;
        kmeans_convergence(j, i) = step;
    end
end


x = [1:num_clusters];

% Cost function results
figure;
means = mean(kmeans_result);
sd = std(kmeans_result);
errorbar(x, means, sd)
    
% Convergence - number of steps results
figure;
means_steps = mean(kmeans_convergence);
sd_steps = std(kmeans_convergence);
errorbar(x, means_steps, sd_steps)