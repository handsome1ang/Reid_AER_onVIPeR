Reid_AER_onVIPeR
## INFORMATION:
This is the Matlab code of our work 
Zhaoju Li, Zhenjun Han, Qixiang Ye:"Person Re-identification via AdaBoost Ranking Ensemble". In ICIP 2016.
It has been conducted on Windows System, Ubuntu System untested. 
Two demos are provided:
- Ada_demo.m    : single experiment for validation
- Average_ada.m : ten trials of experiments for final evaluation.
In order to run the code, you need to put features into filefolder "../Features/". To re-implement our results, download features in this link: http://pan.baidu.com/s/1minno6k/.


## LICENSE:
Copyright (c) 2016, Zhaoju Li @ Pattern Recognition and Intelligent System Development Laboratory
All rights reserved.
This package is licensed under BSD Licence. 

## CITATION:
If you use this code, please kindly cite our work in your publications if it helps your research:
```bibtex
@inproceedings{li2016person,
  title={Person re-identification via adaboost ranking ensemble},
  author={Li, Zhaoju and Han, Zhenjun and Ye, Qixiang},
  booktitle={2016 IEEE International Conference on Image Processing (ICIP)},
  pages={4269--4273},
  year={2016},
  organization={IEEE}
}
```

If you use oLFDA, kLFDA, LOMO_XQDA, svmml or WHOS in this package, please refer the original paper properly.
- kLFDA
    X. Fei, M. Gou, O. Camps and M. Sznaier: "Person Re-Identification using Kernel-based Metric Learning Methods". In ECCV 2014.
- oLFDA
    Pedagadi, S., Orwell, J., Velastin, S., Boghossian, B.: "Local Fisher discriminant analysis for pedestrian re-identification" In CVPR 2013
- svmml
    Li, Z., Chang, S., Liang, F., Huang, T.S., Cao, L., Smith, J.R.: "Learning locally-adaptive decision functions for person verification" In CVPR 2013
- LOMO_XQDA
    Shengcai Liao, Yang Hu, Xiangyu Zhu, and Stan Z. Li. "Person re-identification by local maximal occurrence representation and metric learning" In CVPR, 2015.
- WHOS
    Lisanti, G. and Masi, I. and Bagdanov, A. and Del Bimbo, A "Person Re-identification by Iterative Re-weighted Sparse Ranking" In PAMI, 2014.

I would like to thank these kind researchers who opened their codes. That helps a lot to those ones like me, especially when I started my research work and built my first framework as a fresh man.


- Date: 2016-02-01

- Author: Zhaoju Li

- Email: lizhaoju13 at mails.ucas.ac.cn
- Project page: http://www.ucassdl.cn/personal/lzj/

## Version: 0.2
- changelog:

v0.0:  raw version 

v0.1:  add README, delete some irrelevant files.

v0.2:  upload features.



