%Term Project: Beat Detection Algorithm
%Cosi177a. Scientific Process in Matlab
%Team member: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu

%This code implements the Sound Energy Algorithm

%Import the audio file as sampled data and sample rate in hertz
filename = input('Music Name: ', 's');
[track,Fs] = audioread(filename);
track = track';
info = audioinfo(filename);

%-------------------------------------------------------------------------%
%Declare some universal variables / preallocate the memory space

%Imports 1024 sampled data each time
%sample_size being a power of 2 is recommended for the use of FFT
sample_size = 1024;
[r samples] = size(track);
sample_num = floor(samples/sample_size);

%Buffer for each sampled data of the corresponding size
sample_buffer = zeros(2,sample_size);

%Buffer for the sampled data after fft algorithm processing
energy_buffer = zeros(1,sample_size);

%Number of the subbands to divide the imported data
subband = 32;

%History buffer of energy for each subband i
history_energy = zeros(43,subband);

%Number of samples on the each subband in total
num_subband = sample_size / subband;

%Define the sensitivity parameter
C = 19;

%The count of beats
beat_count = 0;

%BPM
bpm=0.0;

%Compute the energy on each subband and put the result energy into
for i = 1:sample_num 
    sample_buffer(1,:) = track(1,(i-1)*sample_size+1:i*sample_size); %take in the sample data
    sample_buffer(2,:) = track(2,(i-1)*sample_size+1:i*sample_size); %from the left and right channel
    energy_buffer = myFFT(sample_buffer,sample_size);%process the data using Fast Frontier Transform to obtain a 1024 frequency spectrum
    energy_buffer = abs(energy_buffer); %calculate the module of those complex numbers
    energy_buffer = energy_buffer.^2; %then compute the squares of the modules
    Es = energy_per_subband(energy_buffer,subband,sample_size); %compute the energy on each subband i
    
    
    %For each index of the subband, compare the energy with its history
    %buffer
    for j = 1:length(Es)
        avgE = mean(history_energy(:,j));
        if Es(j) > C*avgE
            beat_count = beat_count+1;
        end
    end
    
    %Pile in the new energy on each subband i and take out the oldest
    history_energy = [Es;history_energy];
    history_energy(43,:)=[];
end

%Convert duration into minutes and calculate the bpm
mins = info.Duration/60;
bpm = beat_count / mins;

%Print out the result
fprintf('The total number of beats counted is %d.\n',beat_count);
fprintf('The BPM of the song is %.2f.\n',bpm);



