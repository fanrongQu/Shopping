//
//  NearListViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/11.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "NearListViewController.h"
#import "NearBusinessCell.h"
#import "NearBusinessViewController.h"

@interface NearListViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  商家列表  */
@property (nonatomic, strong) UITableView *tableview;
/**  商家列表数据  */
@property (nonatomic, strong) NSMutableArray *nearBusinessArray;

@end

@implementation NearListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nearBusinessArray addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@""]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tableview.delegate = nil;
    self.tableview.dataSource = nil;
}

- (void)dealloc {
    
    if (_tableview != nil) _tableview = nil;
    
    if (_nearBusinessArray != nil) _nearBusinessArray = nil;
    
}


#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nearBusinessArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NearBusinessCell *cell = [NearBusinessCell cellWithTableView:tableView];
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NearBusinessViewController *nearBusinessVC =[[NearBusinessViewController alloc]init];
    
    [self.navigationController pushViewController:nearBusinessVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]init];
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}

- (NSMutableArray *)nearBusinessArray {
    if (!_nearBusinessArray) {
        _nearBusinessArray = [NSMutableArray array];
    }
    return _nearBusinessArray;
}


@end
