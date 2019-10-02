%bipolar continues function

function output = bipolar_con_fun(net)
output = (2 ./ (ones(size(net))+exp(-1*net))) - ones(size(net));
%output = 2 / (1 + exp(-net)) - 1;
