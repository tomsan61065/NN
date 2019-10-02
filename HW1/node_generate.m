%function for generate master unit and ancillary units
%parameter "data" is a matrix with input and real output
%data = [i1 i2 i3 ; i1 i2 i3 ; o1 o2 o3]
%return "node" is the weights	 = [w1 w1 w1...;w2 w2 w2...;...]
%in one layer

function node = node_generate(data)
[dimension, pattern_num] = size(data);

%find the weight of node
w = SCPTA(data);
   
   
real_output = data(dimension, :);
data(dimension, :) = 1;
output = w * data;
output(find(abs(output)<0.0001))=-1;
output = sign(output);
data(dimension, :) = real_output;

%divide
data1 = data(:, find(output == 1));
data2 = data(:, find(output == -1));

%test if class1 and class2 are faithful
node1 = [];
node2 = [];

if ~isempty(find(data1(dimension, :) ~= 1))
   node1 = node_generate(data1);
end
if ~isempty(find(data2(dimension, :) ~= -1))
   node2 = node_generate(data2);
end

%conquer
node = [w; node1; node2];
