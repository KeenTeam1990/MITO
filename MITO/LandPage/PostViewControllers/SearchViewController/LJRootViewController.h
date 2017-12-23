//
//  LJRootViewController.h
//  FitnessHelper
//
//  Created by 成都千锋 on 15/10/25.
//  Copyright (c) 2015年 成都千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJRootViewController : UIViewController

/*!
 @brief 设置NavigationTitle
 @param NSString *对象
 */
- (void) setNavigationTitle:(NSString *)title;

/*!
 @brief 设置NavigationItem
 @param name 
 @param BackgroundImage
 @param BOOL isLeft
 */
- (void) setNavigationItemName:(NSString *)name addBackgroundImage:(NSString *)imageName addIsLeft:(BOOL)isLeft;

/*!
 @brief 设置navigationBarTintColor
 @param UIColor *
 */
- (void)setNavigationBarTintColor:(UIColor *)color;

@end
