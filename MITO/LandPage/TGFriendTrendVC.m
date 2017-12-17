//
//  TGFriendTrendVC.m
//  baisibudejie
//
//  Created by targetcloud on 2017/3/5.
//  Copyright © 2017年 targetcloud. All rights reserved.
//

#import "TGFriendTrendVC.h"


@interface TGFriendTrendVC ()

@end

@implementation TGFriendTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
}

- (void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    self.navigationItem.title = @"我的关注";
    
}

- (void)friendsRecomment{
    TGFunc
   
}

- (IBAction)loginRegister:(id)sender {
   
}

@end
