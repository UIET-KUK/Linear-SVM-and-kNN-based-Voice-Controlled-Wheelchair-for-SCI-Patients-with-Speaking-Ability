function [MFCC_D_D , sp] = featuremfcc(ss,fs)
% Inputs:
%       sp      : speech signal
%       fs      : sample rate in Hz

frame_shift_sec= 0.010;  %10ms Overlaping
Frame_size = 240;        %30ms frame size
Frame_overlap = fs*frame_shift_sec; %inter frame distance
delta_win=2;
delta_win_weight = ones(1,2*delta_win+1);
%% Filtering And Smoothening
[b11,a11]=fir1(50,[150 3500]/(fs/2), 'bandpass');
ss=filter(b11,a11,ss);
ss=smooth(ss,'lowess');
%% Noise and Silence removal


%% Normalization
ss=double(ss);
sp=ss/max(abs(ss));

%% Feature Extraction
VMfcc = mfcc(sp, fs,Frame_size,Frame_overlap); 
[~,sd11]=size(VMfcc);
if (sd11<2)
    MFCC_D_D=[];
else
d_fea=slope(VMfcc,delta_win_weight); % in unit of 10ms
dd_fea=slope(d_fea,delta_win_weight); % in unit of 10ms
MFCC_D_D=[VMfcc' d_fea' dd_fea'];
MFCC_D_D=MFCC_D_D';
end
end
% end
