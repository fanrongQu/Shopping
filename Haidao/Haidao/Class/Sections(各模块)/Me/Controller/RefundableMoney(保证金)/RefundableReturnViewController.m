//
//  RefundableReturnViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/3.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//  已返还

#import "RefundableReturnViewController.h"
#import "RefundableReturnCell.h"
#import "FilterView.h"

@interface RefundableReturnViewController ()<UITableViewDelegate,UITableViewDataSource,FilterViewDelegate>

/**  滚动视图  */
@property (nonatomic, strong) UITableView *tableView;
/**  顶部视图  */
@property (nonatomic, strong) UIView *tableHeaderView;
/**  顶部背景  */
@property (nonatomic, strong) UIImageView *bgImageView;
/**  图标  */
@property (nonatomic, strong) UIImageView *iconImageView;
/**  当前保证金  */
@property (nonatomic, strong) UILabel *currentIntegralLabel;
/**  当前保证金文字  */
@property (nonatomic, strong) UILabel *currentIntegralText;
/**  筛选视图  */
@property (nonatomic, strong) FilterView *filterView;

@end

@implementation RefundableReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"返还记录";
    [self currentIntegralText];
    self.currentIntegralLabel.text = @"1200.00";
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filterData:)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.filterView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)dealloc {
    if (_tableView != nil) _tableView = nil;
    
    if (_tableHeaderView != nil) _tableHeaderView = nil;
    
    if (_bgImageView != nil) _bgImageView = nil;
    
    if (_iconImageView != nil) _iconImageView = nil;
    
    if (_currentIntegralText != nil) _currentIntegralText = nil;
    
    if (_currentIntegralLabel != nil) _currentIntegralLabel = nil;
    
    if (_filterView != nil) _filterView = nil;
    
}

/**
 *  筛选数据
 */
- (void)filterData:(UIBarButtonItem *)buttonItem {
    NSLog(@"筛选数据");
    self.filterView.hidden = !self.filterView.hidden;
    self.filterView.filterArray = @[@"一个月内",@"三个月内",@"六个月内"];
    if ([buttonItem.title isEqualToString:@"筛选"]) {
        [buttonItem setTitle:@"取消"];
        
    }else {
        [buttonItem setTitle:@"筛选"];
        
    }
}

#pragma mark - FilterView delegate
- (void)filterItemClickWithTitle:(NSString *)title {
    NSLog(@"点击了按钮 - %@",title);
    self.filterView.hidden = YES;
    
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RefundableReturnCell *cell = [RefundableReturnCell cellWithTableView:tableView];
    [cell setSerialNumber:@"1000000020" type:@"返还保证金" money:@"100" remarks:@"赠送积分" time:@"2016-8-2 22:01"];
    
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
            make.edges.mas_equalTo(0);
        }];
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.tableFooterView = [UIView new];
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
    }
    return _tableHeaderView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        [self.tableHeaderView addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        [_bgImageView setImage:[UIImage imageNamed:@"bg"]];
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        [self.bgImageView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.size.mas_equalTo(50);
            make.centerY.mas_equalTo(0);
        }];
        [_iconImageView setImage:[UIImage imageNamed:@"refundable"]];
    }
    return _iconImageView;
}

- (UILabel *)currentIntegralLabel {
    if (!_currentIntegralLabel) {
        _currentIntegralLabel = [[UILabel alloc]init];
        [self.bgImageView addSubview:_currentIntegralLabel];
        __weak typeof(self) weakSelf = self;
        [_currentIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.iconImageView);
            make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(12);
        }];
        _currentIntegralLabel.font = kFontSize(20);
        _currentIntegralLabel.textColor = [UIColor whiteColor];
    }
    return _currentIntegralLabel;
}

- (UILabel *)currentIntegralText {
    if (!_currentIntegralText) {
        _currentIntegralText = [[UILabel alloc]init];
        [self.bgImageView addSubview:_currentIntegralText];
        __weak typeof(self) weakSelf = self;
        [_currentIntegralText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.iconImageView);
            make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(12);
        }];
        _currentIntegralText.font = kFontSize(12);
        _currentIntegralText.text = @"已返还保证金总额";
        _currentIntegralText.textColor = [UIColor whiteColor];
    }
    return _currentIntegralText;
}

- (FilterView *)filterView {
    if (!_filterView) {
        _filterView = [[FilterView alloc]init];
        [self.view addSubview:_filterView];
        [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _filterView.delegate = self;
    }
    return _filterView;
}


@end
