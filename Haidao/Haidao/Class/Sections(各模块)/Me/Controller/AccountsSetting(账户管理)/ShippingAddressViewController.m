//
//  ShippingAddressViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/20.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShippingAddressViewController.h"
#import "ShippingAddressCell.h"
#import "AddShippingAddressViewController.h"

@interface ShippingAddressViewController ()<UITableViewDelegate,UITableViewDataSource,ShippingAddressCellDelegate>

/**  收货地址列表  */
@property (nonatomic, strong) UITableView *tableView;

/**  选中的indexPath  */
@property (nonatomic, strong) NSIndexPath *defaultBankIndexPath;

@end

@implementation ShippingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址管理";
    
    [self setBottomView];
}

- (void)dealloc {
    
    if (_tableView != nil) _tableView = nil;
}

- (void)setBottomView {
    
    UIButton *addButton = [[UIButton alloc]init];
    [addButton setTitle:@"添加收货地址" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.backgroundColor = kSubjectColor;
    addButton.titleLabel.font = kFontSize(14);
    
    [self.view insertSubview:addButton aboveSubview:self.tableView];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    
    __weak typeof(self) weakSelf = self;
    [[addButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"添加收货地址");
        AddShippingAddressViewController *addShippingAddressVC = [[AddShippingAddressViewController alloc]init];
        addShippingAddressVC.title = @"添加新地址";
        [weakSelf.navigationController pushViewController:addShippingAddressVC animated:YES];
    }];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShippingAddressCell *cell = [ShippingAddressCell cellWithTableView:tableView];
    cell.delegate = self;
    [cell setShippingAddressName:@"IOS-RONG" phone:@"15839952321" address:@"河南省南阳市宛城区长江路80号南阳理工学院" indexPath:indexPath];
    
    if (![indexPath isEqual:self.defaultBankIndexPath]) {
        cell.settingDefaultBtn.selected = NO;
    }
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark - ShippingAddressCell delegate
- (void)setDefaultShippingAddressAtIndexPath:(NSIndexPath *)indexPath {
    
    self.defaultBankIndexPath = indexPath;
    [self.tableView reloadData];
}

- (void)removeShippingAddressAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)editShippingAddressAtIndexPath:(NSIndexPath *)indexPath {
    AddShippingAddressViewController *addShippingAddressVC = [[AddShippingAddressViewController alloc]init];
    addShippingAddressVC.title = @"编辑地址";
    
    [addShippingAddressVC setShippingAddressName:@"IOS-RONG" phone:@"158****2321" area:@"河南省 南阳市" address:@"宛城区长江路80号南阳理工学院" defaultAddress:YES];
    
    [self.navigationController pushViewController:addShippingAddressVC animated:YES];
}


#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 49, 0));
        }];
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
