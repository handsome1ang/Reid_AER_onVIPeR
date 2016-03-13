featureDir = '../Features/';
addpath(featureDir);
% for i=1:length(featname)
%     load(['feat' num2str(i) '.mat']);
% end
load('feat1.mat');
load('feat2.mat');
load('feat3.mat');
load('feat4.mat');
load('feat5.mat');
%toysize=40;
for i=1:num_person
    gID(i)=i;
end
for i=1:num_person
    gID(i+num_person)=i;
end
% assert(2*num_person==size(feat1,1));
% assert(2*num_person==size(feat3,1));