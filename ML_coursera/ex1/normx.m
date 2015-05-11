function [X_norm] = normx(X)
X_norm = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));
     
mu = mean(X); mu(1)=0;
sigma = std(X); sigma(1)=1;
for j=1:size(X,1)
	X_norm(j,:) = (X(j,:)-mu)./sigma;
end

end
