function centroids = guess_centroids_randomly(X, m, k, centroids)
    for i = 1:k
            centroids(i, :) = X(randi(m), :);
    end
end