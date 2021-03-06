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

@interface PersonalBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,PersonalBankCardCellDelegate>

/**  银行卡列表  */
@property (nonatomic, strong) UITableView *tableView;

/**  选中的indexPath  */
@property (nonatomic, strong) NSIndexPath *defaultBankIndexPath;

@end

@implementation PersonalBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡管理";
    
    [self setBottomView];
}

- (void)dealloc {
    
    if (_tableView != nil) _tableView = nil;
}

/**
 *  设置tableView的footerView
 */
- (void)setBottomView {
    
    UIButton *addButton = [[UIButton alloc]init];
    [addButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
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
        NSLog(@"添加银行卡");
        AddBankCardViewController *addBankCardVC = [[AddBankCardViewController alloc]init];
        [weakSelf.navigationController pushViewController:addBankCardVC animated:YES];
    }];
}

#pragma mark - tableview dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonalBankCardCell *cell = [PersonalBankCardCell cellWithTableView:tableView];
    cell.delegate = self;
    [cell setPersonalbankCardIcon:nil bankName:@"中国农业银行" bankNumber:@"622712343342123" indexPath:indexPath];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - PersonalBankCardCell delegate
- (void)setDefaultBankCardAtIndexPath:(NSIndexPath *)indexPath {
    self.defaultBankIndexPath = indexPath;
    [self.tableView reloadData];
}

- (void)removeBankCardAtIndexPath:(NSIndexPath *)indexPath {
    
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
