//
//  ShoppingOrderViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/13.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingOrderViewController.h"
#import "ShoppingOrderOnlineViewController.h"
#import "ShoppingOrderOflineViewController.h"
#import "ShoppingOrderHotboomViewController.h"

@implementation ShoppingOrderViewController

+ (void)showShoppingOrderViewController:(UIViewController *)controller {
    ShoppingOrderViewController *shoppingOrderVC = [[ShoppingOrderViewController alloc]init];
    [controller.navigationController pushViewController:shoppingOrderVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物订单";
    
    [self setUpAllChildViewControllerWithArray];
    
    [self setMenusView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickMenuTitle:) name:FRSlideMenuClickMenuTitleNote object:nil];
}


// 添加所有子控制器
- (void)setUpAllChildViewControllerWithArray {
    
    ShoppingOrderOnlineViewController *shoppingOrderOnlineVC = [[ShoppingOrderOnlineViewController alloc]init];
    shoppingOrderOnlineVC.title = @"线上订单";
    [self addChildViewController:shoppingOrderOnlineVC];
    
    ShoppingOrderOflineViewController *shoppingOrderOflineVC = [[ShoppingOrderOflineViewController alloc]init];
    shoppingOrderOflineVC.title = @"线下订单";
    [self addChildViewController:shoppingOrderOflineVC];
    
    ShoppingOrderHotboomViewController *shoppingOrderHotboomVC = [[ShoppingOrderHotboomViewController alloc]init];
    shoppingOrderHotboomVC.title = @"代购订单";
    [self addChildViewController:shoppingOrderHotboomVC];

}

- (void)setMenusView{
    
    [self setUpTitleEffect:^(BOOL *isShowAddMenuView, UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *isShowAddMenuView = NO;
        *norColor = [UIColor blackColor];
        *selColor = kSubjectColor;
        *titleHeight = 40;
    }];
    
    // 设置标题渐变
    [self setUpTitleGradient:^(BOOL *isShowTitleGradient, FRTitleColorGradientStyle *titleColorGradientStyle, CGFloat *startR, CGFloat *startG, CGFloat *startB, CGFloat *endR, CGFloat *endG, CGFloat *endB) {
        
        *isShowTitleGradient = YES;
        
        *titleColorGradientStyle = FRTitleColorGradientStyleFill;
        
        *endR = 1;
        
    }];
    
    // 设置下标
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        *isShowUnderLine = YES;
        *underLineColor = kSubjectColor;
    }];
}


- (void)clickMenuTitle:(NSNotification *)not {
//    [self cancleAddMenu:self.cancleBtn];
}


@end
