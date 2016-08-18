//
//  OrderManageViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "OrderManageViewController.h"
#import "OrderManageCell.h"
#import "MXPullDownMenu.h"

@interface OrderManageViewController ()<UITableViewDelegate,UITableViewDataSource,MXPullDownMenuDelegate>

/**  数据表  */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OrderManageViewController


+ (void)showOrderManageViewController:(UIViewController *)controller {
    OrderManageViewController *OrderManageVC = [[OrderManageViewController alloc]init];
    [controller.navigationController pushViewController:OrderManageVC animated:YES];
}

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单管理";
    
    
    CGRect menuF = CGRectMake(0, 64, kScreenWidth, 44);
    NSArray *testArray = @[@[@"类别",@"状态"],@[@"类别",@"状态"],@[@"类别",@"状态"],@[@"类别",@"状态"]];
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:kSubjectColor backgroundColor:[UIColor whiteColor] Frame:menuF];
    menu.alpha = 0.8;
    menu.delegate = self;
    [self.view addSubview:menu];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)dealloc {
    if (_tableView != nil) _tableView = nil;
}


#pragma mark - 点击悬浮按钮进行分类选择  MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    //    self.page = 1;
    //    NSLog(@"%@",self.detailTypeId[row]);
    //    if (self.cid == self.detailTypeId[row]) return;
    //    self.cid = self.detailTypeId[row];
    //    self.items = nil;
    //    self.items = [NSMutableArray array];
    //    [self getNetworking];
    
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderManageCell *cell = [OrderManageCell cellWithTableView:tableView];
    
    [cell setOrderManageOfSerialNumber:@"123432121" type:@"现金购买" consumerName:@"刘德华" commodity:@"纯净水" expendMoney:@"￥1000.00" cuttingProfits:@"100.00" time:@"2016-8-2 11:34" status:YES];
    
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
            make.edges.mas_equalTo(UIEdgeInsetsMake(108, 0, 0, 0));
        }];
        _tableView.tableFooterView = [UIView new];
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}



@end
