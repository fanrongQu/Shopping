//
//  PersonalBankCardViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/19.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "PersonalBankCardViewController.h"
#import "PersonalBankCardCell.h"
#import "AddBankCardViewController.h"

@interface PersonalBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  银行卡列表  */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PersonalBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡管理";
    
    [self setTableFooterView];
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

/**
 *  设置tableView的footerView
 */
- (void)setTableFooterView {
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    self.tableView.tableFooterView = footerView;
    
    UIButton *addButton = [[UIButton alloc]init];
    [addButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.backgroundColor = kSubjectColor;
    addButton.titleLabel.font = kFontSize(14);
    
    [footerView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(36);
    }];
    
    __weak typeof(self) weakSelf = self;
    [[addButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"添加银行卡");
        AddBankCardViewController *addBankCardVC = [[AddBankCardViewController alloc]init];
        [weakSelf.navigationController pushViewController:addBankCardVC animated:YES];
    }];
}

#pragma mark - tableview dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonalBankCardCell *cell = [PersonalBankCardCell cellWithTableView:tableView];
    
    [cell setPersonalbankCardIcon:nil bankName:@"中国农业银行" bankNumber:@"622712343342123"];
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

@end
