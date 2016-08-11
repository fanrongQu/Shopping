//
//  StoreIntroSettingViewController.h
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^ablock)(NSString *str);

@interface StoreIntroSettingViewController : BaseViewController

@property (nonatomic, copy) ablock block;

+ (StoreIntroSettingViewController *)showStoreIntroSettingViewController:(UIViewController *)controller;

@end
