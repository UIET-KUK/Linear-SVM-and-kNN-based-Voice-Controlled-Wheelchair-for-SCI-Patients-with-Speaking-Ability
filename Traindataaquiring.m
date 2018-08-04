
clc;
clear all;
close all;
%%
addpath(genpath('C:\Users\Bhupi\Desktop\Main Pragram For Wheelchair Control')) %%%add Data Folder to Matlab path %%%

trainingdata=[];
nnLabel=[];
fs=8000; %sampling Frequency

%%Read Data%%
SpFile=dir('C:\Users\Bhupi\Desktop\Main Pragram For Wheelchair Control\datasets\Run'); %folder where Run data is placed
[n1,~]=size(SpFile);
for i=3:n1
ss = audioread(SpFile(i).name); %Read the audio File
[VMFCC, sp] = featuremfcc(ss,fs); %Feauture Extraction Function
%%%Define Label%%%
[~,n]= size(VMFCC);
VMFCC = [VMFCC; ones(1,n)*1];
trainingdata = [trainingdata; VMFCC'];
%Label for Neural Network Tool Box%
for d2=1:n
d=[1 0 0 0 0 0 0];
nnLabel=[nnLabel; d];  
end
end
SpFile=dir('C:\Users\Bhupi\Desktop\Main Pragram For Wheelchair Control\datasets\Stop');
[n1,~]=size(SpFile);
for i=3:n1
ss = audioread(SpFile(i).name);
[VMFCC,sp] = featuremfcc(ss,fs);
[~,n]= size(VMFCC);
VMFCC = [VMFCC; ones(1,n)*2];
trainingdata = [trainingdata; VMFCC'];
for d2=1:n
d=[0 1 0 0 0 0 0];
nnLabel=[nnLabel; d];
end
end

SpFile=dir('C:\Users\Bhupi\Desktop\Main Pragram For Wheelchair Control\datasets\Back');
[n1,~]=size(SpFile);
for i=3:n1
ss = audioread(SpFile(i).name);
VMFCC = featuremfcc(ss,fs);
[~,n]= size(VMFCC);
VMFCC = [VMFCC; ones(1,n)*3];
trainingdata = [trainingdata; VMFCC'];
for d2=1:n
d=[0 0 1 0 0 0 0];
nnLabel=[nnLabel; d];
end
end
SpFile=dir('C:\Users\Bhupi\Desktop\Main Pragram For Wheelchair Control\datasets\Left');
[n1,~]=size(SpFile);
for i=3:n1
ss = audioread(SpFile(i).name);
VMFCC = featuremfcc(ss,fs);
[~,n]= size(VMFCC);
VMFCC = [VMFCC; ones(1,n)*4];
trainingdata = [trainingdata; VMFCC'];
for d2=1:n
d=[0 0 0 1 0 0 0];
nnLabel=[nnLabel; d];
end
end
SpFile=dir('C:\Users\Bhupi\Desktop\Main Pragram For Wheelchair Control\datasets\Right');
[n1,~]=size(SpFile);
for i=3:n1
ss = audioread(SpFile(i).name);
VMFCC = featuremfcc(ss,fs);
[~,n]= size(VMFCC);
VMFCC = [VMFCC; ones(1,n)*5];
trainingdata = [trainingdata; VMFCC'];
for d2=1:n
d=[0 0 0 0 1 0 0];
nnLabel=[nnLabel; d];
end
end
SpFile=dir('C:\Users\Bhupi\Desktop\Main Pragram For Wheelchair Control\datasets\Fast');
[n1,~]=size(SpFile);
for i=3:n1
ss = audioread(SpFile(i).name);
VMFCC = featuremfcc(ss,fs);
[~,n]= size(VMFCC);
VMFCC = [VMFCC; ones(1,n)*6];
trainingdata = [trainingdata; VMFCC'];
for d2=1:n
d=[0 0 0 0 0 1 0];
nnLabel=[nnLabel; d];
end
end
SpFile=dir('C:\Users\Bhupi\Desktop\Main Pragram For Wheelchair Control\datasets\Slow');
[n1,~]=size(SpFile);
for i=3:n1
ss = audioread(SpFile(i).name);
VMFCC = featuremfcc(ss,fs);
[~,n]= size(VMFCC);
VMFCC = [VMFCC; ones(1,n)*7];
trainingdata = [trainingdata; VMFCC'];
for d2=1:n
d=[0 0 0 0 0 0 1];
nnLabel=[nnLabel; d];
end
end
% 
% SpFile=dir('C:\Users\Bhupi\Desktop\Main Pragram For Wheelchair Control\null1');
% [n1,~]=size(SpFile);
% for i=3:n1
% ss = audioread(SpFile(i).name);
% VMFCC = featuremfcc(ss,fs);
% [~,n]= size(VMFCC);
% VMFCC = [VMFCC; ones(1,n)*8];
% trainingdata = [trainingdata; VMFCC'];
% for d2=1:n
% d=[0 0 0 0 0 0 1];
% nnLabel=[nnLabel; d];
% end
% end
