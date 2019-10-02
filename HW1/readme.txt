tiling_algorithm.m
這個程式是一個matlab function
輸入tarining的patterns
就可以得到所要的weights

training的pattern限定為class 1和class -1兩種而已

為了方便,已經先弄好了training patterns(pattern.mat)
為 6 dimension的binary data(-1和1)
共有2^6 = 64組data
如果有偶數個1,output為1,其餘為-1

than in matlab environment we can input

>load pattern pattern
>[layer, W] = tiling_algorithm(pattern)

layer 為每層的node數
W為所有的weight
W為一個異質矩陣
可以用
>W{:}
來觀看它的內容

這個程式使用Single Continuous Perceptron Training Algorithm (SCPTA)
來training每個node的weight
可以自行修改node_generate.m中的
w = SCPTA(data);
    ~~~~~~~~~~~
和tiling_algorithm.m中的
master_node = SCPTA(pattern);
	      ~~~~~~~~~~~~~~
用其他training一個node的function來取代