//
//  ShoppingOrderHotboomViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/13.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingOrderHotboomViewController.h"
#import "ShoppingOrderHotboomCell.h"

@interface ShoppingOrderHotboomViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  数据表格  */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ShoppingOrderHotboomViewController


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
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShoppingOrderHotboomCell *cell = [ShoppingOrderHotboomCell cellWithTableView:tableView];
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(0);
        }];
        _tableView.allowsSelection = NO;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
