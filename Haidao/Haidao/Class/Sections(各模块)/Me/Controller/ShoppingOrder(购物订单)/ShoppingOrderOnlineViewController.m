//
//  ShoppingOrderOnlineViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/13.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//线上订单

#import "ShoppingOrderOnlineViewController.h"
#import "ShoppingOrderOnlineHeaderView.h"
#import "ShoppingOrderOnlineCell.h"


@interface ShoppingOrderOnlineViewController ()<UITableViewDataSource,UITableViewDelegate,ShoppingOrderOnlineHeaderViewDelegate>

/**  购物订单列表  */
@property (nonatomic, strong) UITableView *tableView;
/**  购物订单数据  */
@property (nonatomic, strong) NSMutableArray *orderArray;

@end

@implementation ShoppingOrderOnlineViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)dealloc {
    
    if (_tableView != nil) _tableView = nil;
    if (_orderArray != nil) _orderArray = nil;
}


#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.orderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = self.orderArray[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShoppingOrderOnlineCell *cell = [ShoppingOrderOnlineCell cellWithTableView:tableView];
    
    
    [cell setCommodityImage:nil name:@"2016新款韩版时尚夏季衬衣新款韩版时尚夏季衬衣" color:@"白色" size:@"XL" price:@"120" oldPrice:@"130" num:@"2"];
    
    return cell;
}


#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ShoppingOrderOnlineHeaderView *headerView = [ShoppingOrderOnlineHeaderView headerViewWithTableView:tableView];
    
    [headerView setShoppingOrderOnlineHeaderViewTitle:@"汇佰硕电子商行" state:@"已付款"];
    headerView.delegate = self;
   
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - ShoppingOrderOnlineHeaderView delegate

/**
 *  店铺名称按钮被点击了
 */
- (void)nameBtnClickedOfHeaderView:(ShoppingOrderOnlineHeaderView *)headerView {
    
}


#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}


- (NSMutableArray *)orderArray {
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
        NSArray *array = @[@[@"1",@"1",@"1"],@[@"1",@"1"],@[@"1",@"1",@"1",@"1"]];
        [_orderArray addObjectsFromArray:array];
    }
    return _orderArray;
}

@end
