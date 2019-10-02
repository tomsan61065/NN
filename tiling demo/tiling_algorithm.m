%the tiling algorithm
%parameter "pattern" is a matrix with input and real output
%pattern = [i1 i2 i3 ; i1 i2 i3 ; o1 o2 o3]
%return "layer" is the node number of every layer
%example: [5 4 1], it means that the fist hidden layer has 5 nodes
%the second hidden layer has 4 nodes
%and final the network has one ouput node
%return "W" is the set of all weights
%the "W" is a "Cell Arrays"(see the help of matlab)
%in one layer

%�ŧi function: return �� = �W��(��J)
function [layer, W] = tiling_algorithm(pattern)

pattern_num = size(pattern, 2); % size �^�� [row, col] -> [1, 2]
%fprintf('%d.\n',pattern_num);
%disp()
%randomize �ΨӬ~�P data
for i = 1 : pattern_num %���X 1 ~ 64
	index1 = fix((pattern_num - 1) * rand(1)) + 1; % fix �L����˥h�����
	index2 = fix((pattern_num - 1) * rand(1)) + 1; % 63 * (0~1) + 1 �קK�� 0
    % �H�U���洫��m
	temp = pattern(:, index1); % �N�O�Y�@ col �� 7 �� row -> (:) �� python �@��
	pattern(:, index1) = pattern(:, index2); 
	pattern(:, index2) = temp;
end

error = pattern_num; % =64
pre_error = error; % =64
layer = [];
W = {};
while error ~= 0 % ~= �N�O !=
	[dimension, pattern_num] = size(pattern);% rol, col
   
	%find the master node
	master_node = SCPTA(pattern);
    % master_node �� node �� 7 �� weight
	real_output = pattern(dimension, :); % ��X label
	pattern(dimension, :) = 1; % �]�� 0 ��@ costant(bias)
	output = master_node * pattern; % �H���v���h���n
	output(find(abs(output)<0.0001))=-1; % �N < 0.0001 ��@ -1
	output = sign(output); %�D�X -1, 0 ,1
	error = sum(abs(output-real_output))/2; % �p�� error �ƥ�

	if error > pre_error-1 % error �S���U��
        error_index = find(abs(pattern(1, :) - real_output)~= 0);   	
        if ~isempty(error_index)
            error_index = error_index(1);
            master_node = (1/(dimension-2))*real_output(error_index)*pattern(:, error_index);
            master_node = master_node';
            master_node(1) = 1;
          
            output = master_node * pattern;
            output(find(abs(output)<0.0001))=-1;
            output = sign(output);
            error = sum(abs(output-real_output))/2;
        end
	end   

   
	pre_error = error;
	pattern(dimension, :) = real_output;
   
	data1 = pattern(:, find(output == 1));
	data2 = pattern(:, find(output == -1));
   
	node1 = [];
	node2 = [];

	if ~isempty(find(data1(dimension, :) ~= 1))
   	node1 = node_generate(data1); %���X�Ӫ��٦����~���ܡA���ͤ@�ӷs�� node �~���
	end
	if ~isempty(find(data2(dimension, :) ~= -1))
   	node2 = node_generate(data2);
	end

	%conquer
	nodes = [master_node; node1; node2];
  
	%find the prototype
	[dimension, pattern_num] = size(pattern);
	real_output = pattern(dimension, :);
	pattern(dimension, :) = 1;
   
	data = nodes * pattern;
	data(find(abs(data)<0.0001)) = -1;
	data = sign(data);
      
	data = [data ; real_output];
	pattern = data;
   
	%delete the same pattern
	[dimension, number] = size(pattern);
	i = 1;
	while i <= number
        k = i+1;
        while k <= number
            if sum(abs(pattern(:, i)+pattern(:, k))) == 2*dimension
                pattern(:, k) = [];
                number = number - 1;            
            else
                k = k+1;
            end
        end
        i = i+1;
    end
   
   
	nodes_num = size(nodes, 1);
	layer = [layer nodes_num];   
   
	W{size(layer, 2)} = nodes;
         
end

      
   
