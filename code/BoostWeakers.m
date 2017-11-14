if ~exist('iterations')
    iterations=36;
end
% wm means sample weights
wm=1/num_test*ones(1,num_test);
for i=1:length(weakLearner)

    new_wL{i*2-1}.r=weakLearner{i}.r1;
    new_wL{i*2-1}.r_test=weakLearner{i}.r_test;
    new_wL{i*2-1}.ixx=weakLearner{i}.ixx;
  
    new_wL{i*2}.r=weakLearner{i}.r2;
    new_wL{i*2}.r_test=weakLearner{i}.r_test;
    new_wL{i*2}.ixx=weakLearner{i}.ixx;    
end

for i=1:iterations
    % calculate the error rates
    [ em,best_weak,class_result]=calcu_errors(new_wL,wm,0,rank_threshold);
    %find the best one
    if min(em)>0.5 
        display(['adaboost runs at ',num2str(i-1),' iters']);
        display(['You need raise the threshold']);
        break;
    end
    Em(i)=em;
    id_weak(i)=best_weak;
    %[minerr,id_weak(i)]=min(Em);
    % updata  alpha the weight of weakclassifier
    alpha(i)=0.5*log((1-Em(i))/Em(i));
    %  updata w  the weight of samples
    Zm=wm*exp(-alpha(i)*class_result);
    wm=wm/Zm.*exp(-alpha(i)*class_result)';
    
end
    
%%%%    testing step
% weaklearners id being used;
% learners=unique(id_weak);
% for i=1:length(learners)
%     ith_Lners=find(id_weak==learners(i));
%     alpha_test(i)=sum(alpha(ith_Lners));
%     index=learners(i);
%     ixx{i}=new_wL{index}.ixx;    
% end
id_true_weak=ceil(id_weak/2);
learners=unique(id_true_weak);
 for i=1:length(learners)
    ith_Lners=find(id_true_weak==learners(i));
    alpha_test(i)=sum(alpha(ith_Lners));
    index=learners(i);
    ixx{i}=weakLearner{index}.ixx;    
 end
alpha_test=alpha_test./sum(alpha_test);
%combine ranking
IDs=gID(idx_test);
ix_ref = idx_test_gallery ==1;
ix_prob = idx_test_gallery ==0;
ref_ID = IDs(ix_ref);
prob_ID = IDs(ix_prob);

%ixx 没有问题，横坐标排序，纵坐标第几张图
maprank=zeros(length(learners),num_test);
for i=1:num_test
    mapcomb=zeros(1,num_test);
    for j=1:length(learners)
       ix=ixx{j}(i,:);
       Result{i}.subRes(j,:)=ix;
       for k=1:num_test 
             maprank(j,ix(k))=k;
       end
       %这里maprank的排序是按照1-316的顺序排列的，值是排第几。
       mapcomb=mapcomb+alpha_test(j)*maprank(j,:);                
    end
   % Result{i}.subRes=ixx;
    
    [~, Reix] = sort(mapcomb);  
    %Reix 横坐标排序，纵坐标第几张图
    Result{i}.finRes=Reix;
    rankbase(i) =  find(Reix == i);
end

for index=1:100;
 rank(index)=length(find(rankbase<=index))/length(rankbase)*100;
end

rankfold(round,:)=rank;
% display(['when beta is ' num2str(rank_threshold)]);
display(['rank1: ' num2str(rank(1)) ' rank5: ' num2str(rank(5)) ' rank10: ' num2str(rank(10)) ' rank20: ' num2str(rank(20))]);





