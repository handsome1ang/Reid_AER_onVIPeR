function [ Em,id_weak,class_result ] = calcu_errors( classifiers,wm,catagory,rank_threshold)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
   % rank_threshold=10;
    switch catagory
        case 0
            for i=1:length(classifiers)
%               ranks=classifiers{i}.r1;
                ranks=classifiers{i}.r;
                class_result(:,i)=(ranks<=rank_threshold);
%                 class_result(:,i)=2*(ranks<=rank_threshold)-1;
                Em(i)=1-wm*class_result(:,i);
            end
            
        case 1
            for i=1:length(classifiers)
                ranks=classifiers{i}.r2;
                class_result(:,i)=2*(ranks<=rank_threshold)-1;
                Em(i)=1-wm*class_result(:,i);
            end
    end
     [Em,id_weak]=min(Em);       
     class_result=class_result(:,id_weak);
end

