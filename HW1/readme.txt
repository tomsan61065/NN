tiling_algorithm.m
�o�ӵ{���O�@��matlab function
��Jtarining��patterns
�N�i�H�o��ҭn��weights

training��pattern���w��class 1�Mclass -1��ئӤw

���F��K,�w�g���˦n�Ftraining patterns(pattern.mat)
�� 6 dimension��binary data(-1�M1)
�@��2^6 = 64��data
�p�G�����ƭ�1,output��1,��l��-1

than in matlab environment we can input

>load pattern pattern
>[layer, W] = tiling_algorithm(pattern)

layer ���C�h��node��
W���Ҧ���weight
W���@�Ӳ���x�}
�i�H��
>W{:}
���[�ݥ������e

�o�ӵ{���ϥ�Single Continuous Perceptron Training Algorithm (SCPTA)
��training�C��node��weight
�i�H�ۦ�ק�node_generate.m����
w = SCPTA(data);
    ~~~~~~~~~~~
�Mtiling_algorithm.m����
master_node = SCPTA(pattern);
	      ~~~~~~~~~~~~~~
�Ψ�Ltraining�@��node��function�Ө��N