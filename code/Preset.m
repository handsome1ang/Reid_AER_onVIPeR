%%% This is a script of adaboost of metrics

resultDir='../exp_results/';

addpath(genpath('Assistant Code'));

%%%%%% 
rank_threshold=5;
reduction_line=4000;
pcadim=600;
iterations=36;
littleFeat=0;
Partition;

metrics= {'XQDA','kLFDA','svmml'};
%metrics= {'kLFDA'};

if littleFeat
       featname={'feat1','feat2'};
    featureDir = '../Features/newset/';
    addpath(featureDir);
    load('feats_6s.mat');
else
  featname={'feat1','feat2','feat3','feat4','feat5','feat6'};
%    featname={'feat1'};
    featureDir = '../Features/';
    addpath(featureDir);
 %load features
    for i=1:length(featname)
        load([featname{i} '.mat']);
    end
end

for i=1:num_person
    gID(i)=i;
end
for i=1:num_person
    gID(i+num_person)=i;
end

