%a function use Single Continuous Perceptron Training Algorithm (SCPTA)
%parameter "data" is a matrix with input and real output
%data = [i1 i2 i3 ; i1 i2 i3 ; o1 o2 o3]
%return single layer weight "w"
%w = [w1 w2 w3]

function w = SCPTA(data) % data = 7*64
[dimension, pattern_num] = size(data); % �q data �o�� rol �P col

term_error = 0.00001;
max_iter = 10000;
max_constant = 1000;
train_para = 1; % �ҿת� learning rate
%{
+ + + - + -|-
- - - + - +|+
+ + + - + -|-
- - - + - +|-
+ + + - + -|+
- - - + - +|-
%}
wtemp = 2*rand(1, dimension)-1; %���� (0~2)-1 -> (-1~1)��rand �@ 1 * 7(dim) ��
% 1, -1, 0.5, ..., 0.1 �@ 7 ��
w = wtemp;

real_output = data(dimension, :); % ���X�C�� col ���� 7 row�A�]�N�O label
data(dimension, :) = 1; % �N label ���]�w�� 1 -> ���O��@ constant(�Ωҿ� bias)��J

error_num = pattern_num; % error = 64 ???
error = 1;
iter = 1;
const_iter = 0;
myCounter = 0;
% �j�魭��F error �j�p�F error_num != 0 (= 0 �N�N��ѥ��F)�F 
while (iter <= max_iter) & (error > term_error) & (error_num ~= 0) & (const_iter <= max_constant)
   error = 0;
   for i = 1 : pattern_num % ���X 1~64
      output = bipolar_con_fun(wtemp*data(:,i)); %�� i �� col(�� i �����)���W weight
      % �å�J 2 / (1 + exp(-net)) - 1; 
      % �N�O�@�� sigmoid�A�� sigmoid 0~1�A�ҥH *2 -1 �첾�� -1~1 (�ҿת� output range)
      % '�Otranspose operator
      % wtemp = wtemp + train_para*0.5*(real_output(i)-output)*(1-output^2)*data(:, i)';
       wtemp = wtemp + train_para*0.5*(real_output(i)-output)*(1-output^2)*data(:, i)'; % ���թޱ� 0~1
      % wtemp �| = wtemp + 1 * 0.5 * (-2~2) * (0~1 �V��ɷU�p) * (��l���)
      %{
      if myCounter == 0
          disp("counter!");
          disp(output);
          disp(wtemp);
          myCounter = myCounter + 1;
      end
      %}
      error = error + 0.5*((real_output(i) - output)^2);
      % �֭p error (Mean Squared Error)
   end
   
   %pocket algorithm
   
   output = sign(wtemp*data); % return -1, 0, +1 �N��Ÿ�
   % http://matlab.izmiran.ru/help/techdoc/ref/arithmeticoperators.html
   % wtemp: 7 �� weight
   % data: 7 * size(64)
   % �o��O���n�A(.*) �~�| element-wise �ۭ�
   %{
   if myCounter == 0
       disp("output!");
       disp(output);
       disp(wtemp);
       disp(size(data));
       disp(data);
       disp(wtemp*data);
       myCounter = myCounter + 1;
   end
   %}
   output(find(output==0)) = -1; % find �| return �D 0 ����m�A��Ҧ� == 0 ����X�ܦ� -1
   count = sum(abs(output-real_output))/2; % �p��Ҧ������T�����G
   if count < error_num % ���~�����C�N�����ç�s weight
      w = wtemp;
      error_num = count;
      const_iter = 0;
   else
      const_iter = const_iter + 1; % �b�W�L max �N���ġA�N break ��s
   end
   
   iter = iter + 1; % ���骺�|�N���ƭ���
end
      
      
      
   




