%a function use Single Continuous Perceptron Training Algorithm (SCPTA)
%parameter "data" is a matrix with input and real output
%data = [i1 i2 i3 ; i1 i2 i3 ; o1 o2 o3]
%return single layer weight "w"
%w = [w1 w2 w3]

function w = SCPTA(data) % data = 7*64
[dimension, pattern_num] = size(data); % 從 data 得知 rol 與 col

term_error = 0.00001;
max_iter = 10000;
max_constant = 1000;
train_para = 1; % 所謂的 learning rate
%{
+ + + - + -|-
- - - + - +|+
+ + + - + -|-
- - - + - +|-
+ + + - + -|+
- - - + - +|-
%}
wtemp = 2*rand(1, dimension)-1; %產生 (0~2)-1 -> (-1~1)的rand 共 1 * 7(dim) 組
% 1, -1, 0.5, ..., 0.1 共 7 個
w = wtemp;

real_output = data(dimension, :); % 取出每個 col 的第 7 row，也就是 label
data(dimension, :) = 1; % 將 label 全設定為 1 -> 其實是當作 constant(或所謂 bias)輸入

error_num = pattern_num; % error = 64 ???
error = 1;
iter = 1;
const_iter = 0;
myCounter = 0;
% 迴圈限制； error 大小； error_num != 0 (= 0 就代表解光了)； 
while (iter <= max_iter) & (error > term_error) & (error_num ~= 0) & (const_iter <= max_constant)
   error = 0;
   for i = 1 : pattern_num % 走訪 1~64
      output = bipolar_con_fun(wtemp*data(:,i)); %第 i 個 col(第 i 筆資料)乘上 weight
      % 並丟入 2 / (1 + exp(-net)) - 1; 
      % 就是一個 sigmoid，但 sigmoid 0~1，所以 *2 -1 位移到 -1~1 (所謂的 output range)
      % '是transpose operator
      % wtemp = wtemp + train_para*0.5*(real_output(i)-output)*(1-output^2)*data(:, i)';
       wtemp = wtemp + train_para*0.5*(real_output(i)-output)*(1-output^2)*data(:, i)'; % 嘗試拔掉 0~1
      % wtemp 會 = wtemp + 1 * 0.5 * (-2~2) * (0~1 越邊界愈小) * (原始資料)
      %{
      if myCounter == 0
          disp("counter!");
          disp(output);
          disp(wtemp);
          myCounter = myCounter + 1;
      end
      %}
      error = error + 0.5*((real_output(i) - output)^2);
      % 累計 error (Mean Squared Error)
   end
   
   %pocket algorithm
   
   output = sign(wtemp*data); % return -1, 0, +1 代表符號
   % http://matlab.izmiran.ru/help/techdoc/ref/arithmeticoperators.html
   % wtemp: 7 個 weight
   % data: 7 * size(64)
   % 這邊是內積，(.*) 才會 element-wise 相乘
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
   output(find(output==0)) = -1; % find 會 return 非 0 的位置，把所有 == 0 的輸出變成 -1
   count = sum(abs(output-real_output))/2; % 計算所有不正確的結果
   if count < error_num % 錯誤有降低就紀錄並更新 weight
      w = wtemp;
      error_num = count;
      const_iter = 0;
   else
      const_iter = const_iter + 1; % 在超過 max 代表收斂，就 break 更新
   end
   
   iter = iter + 1; % 整體的疊代次數限制
end
      
      
      
   




