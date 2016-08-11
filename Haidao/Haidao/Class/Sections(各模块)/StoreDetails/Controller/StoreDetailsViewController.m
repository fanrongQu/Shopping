//
//  StoreDetailsViewController.m
//  Haidao
//
//  Created by 1860 on 16/7/29.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  店铺详情

#import "StoreDetailsViewController.h"
#import "StoreDetailHeaderView.h"

@interface StoreDetailsViewController ()<StoreDetailHeaderViewDelegate>

/**  商家信息列表  */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation StoreDetailsViewController

+ (void)showStoreDetailsViewController:(UIViewController *)controller {
    StoreDetailsViewController *storeDetailsVC = [[StoreDetailsViewController alloc]init];
    storeDetailsVC.title = @"店铺详情";
    [controller.navigationController pushViewController:storeDetailsVC animated:YES];
}

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStoreDetailHeaderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)dealloc {
    
    if (_tableView != nil) _tableView = nil;
}

/**
 *  设置商家信息顶部栏
 */
- (void)setStoreDetailHeaderView {
    StoreDetailHeaderView *storeDetailHeaderView = [[StoreDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 175)];
    
    storeDetailHeaderView.delegate = self;
   
    self.tableView.tableHeaderView = storeDetailHeaderView;
}
#pragma mark - StoreDetailHeaderView delegate
/**
 *  点击量StoreDetailHeaderView的内部按钮
 *
 *  @param type 按钮的类型
 */
- (void)clickStoreDetailHeaderViewButtonWithType:(StoreDetailHeaderViewButtonType)type {
    switch (type) {
            
        case StoreDetailHeaderViewButtonAttentionType://点击了关注按钮
            NSLog(@"点击了关注按钮");
            
            break;
        case StoreDetailHeaderViewButtonStoreHomeType://点击了店铺首页按钮
            NSLog(@"点击了店铺首页按钮");
            
            break;
        case StoreDetailHeaderViewButtonHotsCommodityType://点击了热销商品按钮
            NSLog(@"点击了热销商品按钮");
            
            break;
        case StoreDetailHeaderViewButtonAllCommodityType://点击了全部商品按钮
            NSLog(@"点击了全部商品按钮");
            
            break;
        case StoreDetailHeaderViewButtonNewsCommodityType://点击了最新上架商品按钮
            NSLog(@"点击了最新上架商品按钮");
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}


@end
