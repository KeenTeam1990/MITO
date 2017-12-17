//
//  PeoperModel.m
//  MITO
//
//  Created by keenteam on 2017/12/16.
//  Copyright © 2017年 keenteam. All rights reserved.
//

#import "PeoperModel.h"

@implementation PeoperModel

+ ( NSDictionary*)modelContainerPropertyGenericClass {
    return @{@"data":[Peoper_dataModel class]};
}

@end
