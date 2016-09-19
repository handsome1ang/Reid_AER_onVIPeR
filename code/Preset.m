%%% This is a script of adaboost of metrics

resultDir='../exp_results/';

addpath(genpath('Assistant Code'));

%%%%%% 
rank_threshold=5;
reduction_line=4000;
pcadim=600;
iterations=36;
Partition;

metrics= {'XQDA','kLFDA','svmml'};
%metrics= {'kLFDA'};

  featname={'feat1','feat2','feat3','feat4','feat5','feat6'};
%    featname={'feat1'};
    featureDir = '../Features/';
    addpath(featureDir);
 %load features
    for i=1:length(featname)
        load([featname{i} '.mat']);
    end


for i=1:num_person
    gID(i)=i;
end
for i=1:num_person
    gID(i+num_person)=i;
end

