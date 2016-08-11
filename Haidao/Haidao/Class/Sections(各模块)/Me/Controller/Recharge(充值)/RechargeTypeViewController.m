//
//  RechargeTypeViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "RechargeTypeViewController.h"
#import "RechargeTypeCell.h"

@interface RechargeTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  支付列表  */
@property (nonatomic, strong) UITableView *tableView;
/**  支付方式  */
@property (nonatomic, strong) NSArray *rechargeTypes;
/**  选中的cell  */
@property (nonatomic, assign) NSIndexPath *selectedIndexpath;

@end

@implementation RechargeTypeViewController

+ (RechargeTypeViewController *)showRechargeTypeViewController:(UIViewController *)controller {
    RechargeTypeViewController *rechargetypeVC = [[RechargeTypeViewController alloc]init];
    [controller.navigationController pushViewController:rechargetypeVC animated:YES];
    return rechargetypeVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付方式";
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
    
    
    NSString *rechargeType = self.rechargeTypes[_selectedIndexpath.row];
    if (self.block) {
        self.block(rechargeType);
    }
}

- (void)dealloc {
    
    if (_tableView != nil) _tableView = nil;
    
    if (_rechargeTypes != nil) _rechargeTypes = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.rechargeTypes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RechargeTypeCell *cell = [RechargeTypeCell cellWithTableview:tableView];
    cell.textLabel.text = self.rechargeTypes[indexPath.row];
    if (_selectedIndexpath == indexPath) {
        cell.selectedRecharge = YES;
    }else {
        cell.selectedRecharge = NO;
    }
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndexpath = indexPath;
    [self.tableView reloadData];
}


#pragma mark - 懒加载 
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.tableFooterView = [UITableView new];
    }
    return _tableView;
}


- (NSArray *)rechargeTypes {
    if (!_rechargeTypes) {
        _rechargeTypes = @[@"支付宝支付",@"微信支付"];
    }
    return _rechargeTypes;
}


@end
