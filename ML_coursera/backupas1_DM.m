%assigment 1 Apriory and CHARM algorithm, Aleksandr Salo, by 14 Sept 2012.
%1.txt assumed 1 = up, 0 = down;
%X assumed: 101 - Colon, 202 - Breast (either 1 or 0)

supmin = 30; %minimum support
confmin = 50; %minimum confidence
N = 100; %num of traing set
Nitems = 202;
X = zeros(N, Nitems); %training set
conf = zeros(100,1); %confidence
%---end of constants declaration

m = dlmread("1.txt"); %itemsets
X = [m(:, 2:102), 1-m(:,2:102)]; %gene sets 100x202, 1 - exist, 0 - not, 1-m - reversing matrix 0->1 and 1->0 	
%-----end of loading step

%---Apriory algorithm
%preparation step
k = 1; 
if (sum(X(:,1))>=supmin) freqsets = 1; else freqsets = 0; endif
for i=2:Nitems
	if (sum(X(:,i))>=supmin) freqsets = [freqsets, i];
	%else printf('this is infrequent %d\n', i);
	endif
end
%---
k=k+1;
%---candidates generation
candidates = [freqsets(1); freqsets(2)]; 
for i=2:size(freqsets,2)
for j=i+1:size(freqsets,2)
	candidates = [candidates, [freqsets(i); freqsets(j)]];
end
end
%---- apriori pruning
freqsets = candidates(:,1); %---silly one, just to shape freqsets size
for i=2:size(candidates,2) %look through all candidates
	sup=0; 
	for j=1:N %look through all 100 patients 
		fl = 1;
		for t=1:k
			if (X(j,candidates(t,i))!=1)
				fl=0;endif%&& X(j,candidates(2,i))==1)
		end
		if (fl == 1)
			sup++; endif
	end
	printf('step i= %d , sup = %d \n', i, sup);
	if (sup>=supmin) %if good support ->include to pruned freqsets
		freqsets = [freqsets,candidates(:,i)];
	endif
end
%---end of apriori pruning

%---find all freqsets realated to diseases


fprintf('\nTraining Set Accuracy: \n');

