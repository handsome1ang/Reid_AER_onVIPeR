%%%%%%%%%%%%%partitioning data into training set and test set;
% seed = 20150835;
% rng(seed);

num_person=632;
num_train=num_person/2;
num_test =num_person/2;
num_trn1=158;
num_trn2=158;
idxtemp=randperm(num_person);
idx_test=idxtemp(1:num_test);
idx_train=idxtemp(num_test+1:end);
%mpair_ID_train=[unique(idx_train),unique(idx_train)];
idx_Trnpart1=idx_train(1:num_trn1);
idx_Trnpart2=idx_train(num_trn1+1:end);

mpair_ID_Trnpart1=[unique(idx_Trnpart1),unique(idx_Trnpart1)];
mpair_ID_Trnpart2=[unique(idx_Trnpart2),unique(idx_Trnpart1)];

idx_test=[idx_test,idx_test+num_person];
idx_train=[idx_train,idx_train+num_person];
idx_Trnpart1=[idx_Trnpart1,idx_Trnpart1+num_person];
idx_Trnpart2=[idx_Trnpart2,idx_Trnpart2+num_person];



% progalrand=logical(ceil(2*rand(1,num_test/2))-1);
% idx_trn_gallery=[progalrand,~progalrand];
% progalrand=logical(ceil(2*rand(1,num_test))-1);
% idx_test_gallery=[progalrand,~progalrand];

%ȥ�������õ��������gallery��prob�Ĳ��裬ֱ��ǰ�벿��gal����벿��prob
idx_trn_gallery=logical(zeros(1,num_test));
idx_trn_gallery(1:num_test/2)=1;
idx_test_gallery=logical(zeros(1,num_person));
idx_test_gallery(1:num_test)=1;
idx_train_gallery=logical(zeros(1,num_train*2));
idx_train_gallery(1:num_train)=1;
