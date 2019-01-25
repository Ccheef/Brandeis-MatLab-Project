function E = energy_per_block(block_vec)
	%Term Project: Beat Detection Algorithm
	%Cosi177a. Scientific Process in Matlab
	%Team members: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    %Date: May 2, 2017
    %Format of Call: energy_per_block(block_vec)
	%This function calculates the total energy of a block of sampled data and
    %returns it

	block_vec = block_vec .^ 2;
	E = sum(sum(block_vec));
end