function subband_energy = energy_per_subband(energy_buffer,subband,sample_size)
%Term Project: Beat Detection Algorithm
%Cosi177a. Scientific Process in Matlab
%Team member: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
%This function helps calculate the energy per subband taken in the input

%First check the input argument
if mod(sample_size,subband)~= 0
    error('The input arguments are invalid:not divisible by the number of subband.')
end

%Calculate the size of the subband_energy
size = sample_size/subband;

%Next preallocate the subband buffer of energy
subband_energy = zeros(1,subband);
subband_sector = zeros(1,size);

%Then calculate the value of energy at each subband
for i = 1:subband
    subband_sector = energy_buffer((i-1)*size+1:i*size); %takes sections of the enery_buffer
    subband_energy(i) = sum(subband_sector) / size; %computes the average on the subband
end

