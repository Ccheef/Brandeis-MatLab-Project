function new_buffer = FFT(buffer,sample_size)
%Term Project: Beat Detection Algorithm
%Cosi177a. Scientific Process in Matlab
%Team member: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
%This function takes a buffer of size 2*sample_size, processes the data
%with fft algorithm, and returns the result vector of data

%First check the input
[r c] = size(buffer);
if r ~= 2 || c~= sample_size %r stands for two channels
    error('Dimension mismatches.');
end

%Next declare and preallocate the vectors to store the result after fft
temp_buffer = zeros(1,sample_size);
new_buffer = zeros(1,sample_size);

%Next loops over the buffer and calculate the result sample using fft
%encoded in Matlab function
for i = 1:sample_size
    left = buffer(1,i); %acquire the left channel
    right = buffer(2,i); %acquire the right channel
    temp_buffer(i) = complex(left,right); %make it into left + righti, a complex number
end

%assigns the result of fft to the new buffer and returns
new_buffer = fft(temp_buffer,sample_size);
