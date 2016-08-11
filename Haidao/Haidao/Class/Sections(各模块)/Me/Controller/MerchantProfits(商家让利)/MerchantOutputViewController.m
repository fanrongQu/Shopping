//
//  MerchantOutputViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/2.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MerchantOutputViewController.h"
#import "MerchantOutputCell.h"

@interface MerchantOutputViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  滚动视图  */
@property (nonatomic, strong) UITableView *tableView;
/**  顶部视图  */
@property (nonatomic, strong) UIView *tableHeaderView;
/**  顶部背景  */
@property (nonatomic, strong) UIImageView *bgImageView;
/**  图标  */
@property (nonatomic, strong) UIImageView *iconImageView;
/**  当前积分  */
@property (nonatomic, strong) UILabel *currentIntegralLabel;
/**  当前积分文字  */
@property (nonatomic, strong) UILabel *currentIntegralText;

@end

@implementation MerchantOutputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"送出让利额";
    [self currentIntegralText];
    self.currentIntegralLabel.text = @"1200.00";
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
    
    if (_tableHeaderView != nil) _tableHeaderView = nil;
    
    if (_bgImageView != nil) _bgImageView = nil;
    
    if (_iconImageView != nil) _iconImageView = nil;
    
    if (_currentIntegralText != nil) _currentIntegralText = nil;
    
    if (_currentIntegralLabel != nil) _currentIntegralLabel = nil;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantOutputCell *cell = [MerchantOutputCell cellWithTableView:tableView];
    
    [cell setSerialNumber:@"1000000020" presentName:@"习大大" money:@"100" remarks:@"消费送积分" time:@"2016-8-2 22:01"];
    
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
        _currentIntegralText.text = @"送出让利额";
        _currentIntegralText.textColor = [UIColor whiteColor];
    }
    return _currentIntegralText;
}


@end
