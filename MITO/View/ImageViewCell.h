//
//  ImageViewCell.h
//  MITO
//
//  Created by keenteam on 2017/12/16.
//  Copyright © 2017年 keenteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Peoper_dataModel.h"

@interface ImageViewCell : UICollectionViewCell


@property (nonatomic , strong)UIImageView * imgView;
@property (nonatomic , strong)Peoper_dataModel *model;

@end
