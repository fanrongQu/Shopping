//
//  RootTabBarViewController.m
//  NetEase Home
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "RootNavigationController.h"
#import "HomeViewController.h"
#import "ClassifyViewController.h"
#import "NearViewController.h"
#import "ShoppingCartViewController.h"
#import "MeViewController.h"

@interface RootTabBarViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *normalImages;
@property (nonatomic, strong) NSArray *selectedImages;

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
}

- (void)addChildViewControllers {
    
//    //设置item的颜色
    [self setTabBarItemNormalColor:kUIColor_RGB(38, 38, 38, 1) selectedColor:kSubjectColor];
    
    NSString *HomeNormalIcon = [@"home" stringByAppendingString:@"_normal"];
    NSString *HomeSelectIcon = [@"home" stringByAppendingString:@"_selected"];
    
    NSString *ClassifyNormalIcon = [@"classify" stringByAppendingString:@"_normal"];
    NSString *ClassifySelectIcon = [@"classify" stringByAppendingString:@"_selected"];
    
    NSString *AllianceNormalIcon = [@"find" stringByAppendingString:@"_normal"];
    NSString *AllianceSelectIcon = [@"find" stringByAppendingString:@"_selected"];
    
    NSString *ShoppingCartNormalIcon = [@"shoppingCart" stringByAppendingString:@"_normal"];
    NSString *ShoppingCartSelectIcon = [@"shoppingCart" stringByAppendingString:@"_selected"];
    
    NSString *meNormalIcon = [@"me" stringByAppendingString:@"_normal"];
    NSString *meSelectIcon = [@"me" stringByAppendingString:@"_selected"];
    
    
    //设置tabBarVC的子控制器
    HomeViewController *HomeVC = [[HomeViewController alloc]init];
    RootNavigationController *HomeNav = [[RootNavigationController alloc] initWithRootViewController:HomeVC];
    HomeNav.delegate = self;
    [self addChildNavigationController:HomeNav title:@"首页" image:HomeNormalIcon selectedImage:HomeSelectIcon];
    
    ClassifyViewController *ClassifyVC = [[ClassifyViewController alloc]init];
    RootNavigationController *ClassifyNav = [[RootNavigationController alloc] initWithRootViewController:ClassifyVC];
    ClassifyNav.delegate = self;
    [self addChildNavigationController:ClassifyNav title:@"分类" image:ClassifyNormalIcon selectedImage:ClassifySelectIcon];
    
    NearViewController *AllianceVC = [[NearViewController alloc]init];
    RootNavigationController *AllianceNav = [[RootNavigationController alloc] initWithRootViewController:AllianceVC];
    AllianceNav.delegate = self;
    [self addChildNavigationController:AllianceNav title:@"附近" image:AllianceNormalIcon selectedImage:AllianceSelectIcon];
    
    ShoppingCartViewController *ShoppingCartVC = [[ShoppingCartViewController alloc]init];
    RootNavigationController *ShoppingCartNav = [[RootNavigationController alloc] initWithRootViewController:ShoppingCartVC];
    ShoppingCartNav.delegate = self;
    [self addChildNavigationController:ShoppingCartNav title:@"购物车" image:ShoppingCartNormalIcon selectedImage:ShoppingCartSelectIcon];
    
    MeViewController *meVC = [[MeViewController alloc]init];
    RootNavigationController *meNav = [[RootNavigationController alloc] initWithRootViewController:meVC];
    meNav.delegate = self;
    [self addChildNavigationController:meNav title:@"我的" image:meNormalIcon selectedImage:meSelectIcon];
}

@end
