% Code for Assignment 4 , Problem 1

%Loading input data
clc;
tic
disp 'Loading data'
input_dataset = load('../Data for Assignment 4 (Mini Project 2)/Clustering/seeds.txt');
%Initialize the variables for problem
input_dataset_rows = size(input_dataset,1);
input_dataset_columns = size(input_dataset,2);
k = input('Enter number of clusters:'); % Number of clusters for the problem. This is entered by the user
disp ('Performing k means clustering');
r2 = randi(210,k,1);
A=input_dataset(1,7);
distances=input_dataset(k,1);
centroids = input_dataset(k,input_dataset_columns);
result_table = input_dataset(input_dataset_rows,1);
iteration = 1;
flag = 0;

for i=1:k
for j=1:input_dataset_columns
  centroids(i,j) = input_dataset(r2(i),j);
end
end

SSE = 0;
while iteration <= 100 && flag==0 
sse_temp = SSE; %SSE of previous iteration
SSE = 0;
for i=1:input_dataset_rows
% Load data of columns    
for j=1:input_dataset_columns
A(1,j)=input_dataset(i,j);
end

%Assign points to a centroid
for l=1:k
    distances(l,1) = pdist2(A,centroids(l,:),'euclidean');
end
minimum_distance = (min(distances));
result_table (i,1) = find(distances==minimum_distance,1);
SSE = SSE + (minimum_distance * minimum_distance);
end

centroids_temp = [0 0 0 0 0 0 0];
centroids_temp_counter = 2;
centroids_temp2 = [0 0 0 0 0 0 0];
%Compute new centroids
for l=1:k
temp = input_dataset(input_dataset_rows,input_dataset_columns);
temp_counter =1;
    for m=1:input_dataset_rows
      if result_table(m,1) == l
         for n=1:input_dataset_columns
            temp(temp_counter,n)=input_dataset(m,n);            
         end
         temp_counter = temp_counter +1 ;
      end
    end
    b=mean(temp);
    centroids_temp(centroids_temp_counter,:) =b;
    centroids_temp2 = centroids_temp ([2:end],:);
    centroids_temp_counter = centroids_temp_counter+1;
end

centroids = centroids_temp2;
if abs(SSE - sse_temp) < 0.001 %Check if succesive iterations have SSE > 0.001 or not
flag = 1;
end

iteration = iteration + 1;
end

fprintf('Completed in %i iterations\n',(iteration-1));
disp ('SSE:');
disp (SSE);

toc