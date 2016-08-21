//
//  AccountsSettingViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/5.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "AccountsSettingViewController.h"
#import "AccountsSettingCell.h"
#import "PersonalIconViewController.h"
#import "PersonalNameViewController.h"
#import "PersonalPhoneViewController.h"
#import "PersonalBankCardViewController.h"
#import "ShippingAddressViewController.h"

@interface AccountsSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  管理表  */
@property (nonatomic, strong) UITableView *tableView;

/**  设置数据  */
@property (nonatomic, strong) NSArray *settingArray;

@end

@implementation AccountsSettingViewController

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户管理";
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
    
    if (_settingArray != nil) _settingArray = nil;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.settingArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = self.settingArray[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    AccountsSettingCell *cell = [AccountsSettingCell cellWithTableView:tableView];
    
    NSArray *sectionArray = self.settingArray[indexPath.section];
    cell.textLabel.text = sectionArray[indexPath.row];
    if (section == 0&&row == 0) {
        
        [cell setAccountsSettingCellIconImage:nil];
    }else if (section == 0&&row == 1) {
        cell.detailTextLabel.text = @"阳春白雪";
    }else if (section == 0&&row == 2){
        cell.detailTextLabel.text = @"158****2321";
    }else {
        cell.detailTextLabel.text = nil;
    }
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        switch (row) {
            case 0:{//头像
                PersonalIconViewController *personalIconVC = [[PersonalIconViewController alloc]init];
                [self.navigationController pushViewController:personalIconVC animated:YES];
            }
                break;
            case 1:{//用户名
                PersonalNameViewController *personalNameVC = [[PersonalNameViewController alloc]init];
                [self.navigationController pushViewController:personalNameVC animated:YES];
            }
                break;
            case 2:{//手机号
                PersonalPhoneViewController *personalPhoneVC = [[PersonalPhoneViewController alloc]init];
                [self.navigationController pushViewController:personalPhoneVC animated:YES];
                
            }
                break;
            case 3:{//银行卡
                PersonalBankCardViewController *personalBankCardVC = [[PersonalBankCardViewController alloc]init];
                [self.navigationController pushViewController:personalBankCardVC animated:YES];
            }
                break;
            case 4:{//收货地址
                ShippingAddressViewController *shippingAddressVC = [[ShippingAddressViewController alloc]init];
                [self.navigationController pushViewController:shippingAddressVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    
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
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)settingArray {
    if (!_settingArray) {
        _settingArray = @[@[@"头像",@"用户名",@"手机号",@"银行卡管理",@"收货地址管理"],@[@"登录密码",@"支付密码"]];
    }
    return _settingArray;
}

@end
