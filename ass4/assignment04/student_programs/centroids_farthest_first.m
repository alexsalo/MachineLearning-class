function centroids = centroids_farthest_first(X, m, k, centroids)
    % Init first centroid randomly
    centroids(1, :) = X(randi(m), :);
    
    % Init all the following centroids as futherst points
    for i = 2:k
        % Init fathers point
        farthest_point = 1;
        max_dist = sum((X(farthest_point, :) - centroids(i-1, :)).^2);

        % Choose among all the points
        for j=2:m
            dist = 0;
            
            % Find the distance to __ALL__ existing centroids
            for t=1:(i-1)
                dist = dist + sum((X(j, :) - centroids(t, :)).^2);
            end
            
            % If new distance is greater - update 
            if dist > max_dist
                max_dist = dist;
                farthest_point = j;
            end
        end

        centroids(i, :) = X(farthest_point, :);
    end
end