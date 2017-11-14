function [ output_args ] = result_show( Toshow,id_prob )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    close('all');
    top_num=10;
    if id_prob>316
        error('out of range');
    end
    if(length(Toshow.modellist)<5)
        num_subRank=length(Toshow.modellist);
    else
        num_subRank=5;     
    end
   [~,sorted_modellist]=sort(Toshow.alpha_test,'descend');
    %%show true match of prob and gallery images
    im_prob=imread([Toshow.data_dir 'cam_b\' Toshow.namelist_b{Toshow.lookupTable(id_prob)}]);
    im_gal=imread([Toshow.data_dir 'cam_a\' Toshow.namelist_a{Toshow.lookupTable(id_prob)}]);
    im_match=cat(2,im_prob,im_gal);
    im_match=imresize(im_match,3);
    figure('Name','prob image');
    imshow(im_match);
    title(['prob\_ID: ' num2str(id_prob) ' , its real pic id:  \' num2str(Toshow.namelist_b{Toshow.lookupTable(id_prob)})]);
   
    % show result of sub_rank
    for i = 1:num_subRank
       figure('Name',['sub_Rank ' num2str(i)]);
       im_sub=[];
       for j=1:top_num
           id_im=Toshow.lookupTable(Toshow.result{id_prob}.subRes(sorted_modellist(i),j));
           im_temp=imread([Toshow.data_dir 'cam_a\' Toshow.namelist_a{id_im}]);
           im_sub=cat(2,im_sub,im_temp);       
       end
       im_sub=imresize(im_sub,2);
       imshow(im_sub); 
       title(['wLearner: ' Toshow.modellist{sorted_modellist(i)}.name '  weight: ' num2str(Toshow.modellist{sorted_modellist(i)}.weight)]);
    end
    
    % show final rank list
     im_sub=[];
       for j=1:top_num+5
           id_im=Toshow.lookupTable(Toshow.result{id_prob}.finRes(j));
           im_temp=imread([Toshow.data_dir 'cam_a\' Toshow.namelist_a{id_im}]);
           im_sub=cat(2,im_sub,im_temp);       
       end
       figure('Name','final rank');
       im_sub=imresize(im_sub,2);
       imshow(im_sub); 
       title(['final Ranklist:  true match is at ' num2str(find(Toshow.result{id_prob}.finRes==id_prob)) ' th.']);
    
end

