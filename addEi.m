function new_buffer = addEi(energy_buffer,Ei,oldest)
	%Term Project: Beat Detection Algorithm
	%Cosi177a. Scientific Process in Matlab
	%Team member: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    %Date: May 2, 2017
    %Format of Call: addEi(energy_buffer,Ei,oldest)
	%This function performs the renewal of another batch of sample data:
	%1. remove the oldest sampled data block from the energy buffer
	%2. add the new energy into the energy buffer and return the new buffer

	energy_buffer(oldest) =[];
	new_buffer = [Ei energy_buffer];
end