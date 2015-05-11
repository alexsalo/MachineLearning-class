function [y_norm] = normy(y)
y_norm = y;
mu = zeros(1);
sigma = zeros(1);
     
mu = mean(y); 
sigma = std(y); 
y_norm = (y.-mu)/sigma;

end