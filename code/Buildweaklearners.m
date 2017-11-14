%clear;
            
%parpool local;

num_wLearners=length(featname)*length(metrics);

num_itr =10; 
np_ratio =10; % The ratio of number of negative and positive pairs. Used in PCCA
% default algorithm option setting
%AlgoOption.name = algoname;
%AlgoOption.func = algoname; % note 'rPCCA' use PCCA function also.
AlgoOption.npratio = np_ratio; % negative to positive pair ratio
AlgoOption.beta =3;  % different algorithm have different meaning, refer to PCCA and LFDA paper.
%AlgoOption.d =40; % projection dimension
AlgoOption.epsilon =1e-4;
%AlgoOption.lambda =0;
AlgoOption.w = [];
%AlgoOption.dataname = fname;
%AlgoOption.partitionname = partition_name;
AlgoOption.num_itr=num_itr;
tic;
count=0;
%%
for i=1:length(featname)
    for j=1:length(metrics)
        index=(i-1)*length(metrics)+j;
        weakLearner{index}.featName   =featname{i}; 
        feat=double(eval(featname{i})); 
        
        traindata=feat(idx_train,:);
        Trnpart1=feat(idx_Trnpart1,:);
        Trnpart2=feat(idx_Trnpart2,:);
        testdata =feat(idx_test,:);
        weakLearner{index}.metricName =metrics{j};
      %%   metric choice
        switch  weakLearner{index}.metricName
            case {'XQDA'}
                AlgoOption.verbose=0;
                AlgoOption.lambda = 0.001;
                galFea1 = Trnpart1(1 : num_train/2, :);
                probFea1 = Trnpart1(num_train/2 + 1 : end, :);
                galFea2 = Trnpart2(1 : num_train/2, :);
                probFea2 = Trnpart2(num_train/2 + 1 : end, :);
                galTest = testdata(1 : num_test, :);
                probTest = testdata(num_test + 1 : end, :);               
                
 
                [weakLearner{index}.W1,weakLearner{index}.M1] = XQDA(galFea1, probFea1, (1:num_train/2)', (1:num_train/2)',AlgoOption);                
                [weakLearner{index}.W2,weakLearner{index}.M2] = XQDA(galFea2, probFea2, (1:num_train/2)', (1:num_train/2)',AlgoOption);

                [ weakLearner{index}.r1,weakLearner{index}.subixx1] = predict_XQDA( weakLearner{index}.W1,weakLearner{index}.M1,[galFea1;galFea2],[probFea1;probFea2],1:num_train,1:num_train);
                [ weakLearner{index}.r2,weakLearner{index}.subixx2] = predict_XQDA( weakLearner{index}.W2,weakLearner{index}.M2,[galFea1;galFea2],[probFea1;probFea2],1:num_train,1:num_train);
 
                [weakLearner{index}.Wa,weakLearner{index}.Ma] = XQDA([galFea1;galFea2], [probFea1;probFea2], (1:num_train)', (1:num_train)',AlgoOption);
               [ weakLearner{index}.r_test,weakLearner{index}.ixx] = predict_XQDA( weakLearner{index}.Wa,weakLearner{index}.Ma,galTest,probTest,1:num_test,1:num_test);
            case {'kLFDA'}
                
                %set the kernel fof LFDA
                AlgoOption.kernel='chi2';
                AlgoOption.dataname = weakLearner{index}.featName;
                AlgoOption.name=weakLearner{index}.metricName;
                AlgoOption.npratio =0; % npratio is not required.
                AlgoOption.beta =0.01;
                AlgoOption.d =40;
                AlgoOption.LocalScalingNeighbor =7; % local scaling affinity matrix parameter.
                AlgoOption.num_itr= 10;
                
                [algo1, V]= LFDA(double(Trnpart1),gID(idx_Trnpart1)' ,AlgoOption);
                [algo2, V]= LFDA(double(Trnpart2),gID(idx_Trnpart2)' ,AlgoOption);
                
                [weakLearner{index}.r1,weakLearner{index}.subixx1]=train_result_LFDA({algo1},{Trnpart1},{traindata},idx_test_gallery,gID(idx_train));                               
                [weakLearner{index}.r2,weakLearner{index}.subixx2]=train_result_LFDA({algo2},{Trnpart2},{traindata},idx_test_gallery,gID(idx_train));
                
                [algoa, V]= LFDA(double(traindata),gID(idx_train)' ,AlgoOption);
                 [weakLearner{index}.r_test,weakLearner{index}.ixx] = ...
                                  train_result_LFDA({algoa},{traindata},{testdata},idx_test_gallery,gID(idx_test));               


            case {'svmml'}
                %%%%%%  do pca

                AlgoOption.dataname = weakLearner{index}.featName;
                AlgoOption.name=weakLearner{index}.metricName;
                if(size(traindata,2)>reduction_line)                   
                    [~,pc] = princomp(Trnpart1);
                    Trnpart1 = pc(:, 1:pcadim);
                    [~,pc] = princomp(Trnpart2);
                    Trnpart2 = pc(:, 1:pcadim);
                    [~,pc] = princomp(testdata);
                    testdata= pc(:, 1:pcadim);
                    [~,pc] = princomp(traindata);
                    traindata= pc(:, 1:pcadim);
                    AlgoOption.doPCA = 1;
                end
                
                AlgoOption.p = []; % learn full rank projection matrix
                AlgoOption.lambda1 = 1e-8;
                AlgoOption.lambda2 = 1e-6;
                AlgoOption.maxit = 300;
                AlgoOption.verbose = 0;
                AlgoOption.kernel  = 'chi2';
             
                
                algo1 = svmml_learn_full_final(double(Trnpart1),gID(idx_Trnpart1)' ,AlgoOption);
                [weakLearner{index}.r1,weakLearner{index}.subixx1] = predict_svmml({algo1},{Trnpart1},{traindata},idx_test_gallery,gID(idx_train));
                algo2 = svmml_learn_full_final(double(Trnpart2),gID(idx_Trnpart2)' ,AlgoOption);
                [weakLearner{index}.r2,weakLearner{index}.subixx2] = predict_svmml({algo2},{Trnpart2},{traindata},idx_test_gallery,gID(idx_train));
                
                algoa = svmml_learn_full_final(double(traindata),gID(idx_train)' ,AlgoOption);
                [weakLearner{index}.r_test,weakLearner{index}.ixx] = predict_svmml({algoa},{traindata},{testdata},idx_test_gallery,gID(idx_test));

            
        end
        %% time consuming part
        count=count+1
        tpoint(index)=toc;
        if(index==1)
            eti=toc; 
        else
            eti=toc-tpoint(index-1);                    
        end
        display(['No.' num2str(index) 'th metric ' weakLearner{index}.metricName ' costs time ' num2str(eti) 's']);

    end
end
if ~exist('average')
    delete(gcp);
end


