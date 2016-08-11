//
//  SettingViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/6.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountsSettingCell.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  设置表  */
@property (nonatomic, strong) UITableView *tableView;

/**  设置数据  */
@property (nonatomic, strong) NSArray *settingArray;

@end

@implementation SettingViewController

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
//    if (section == 0&&row == 0) {
//        
//        [cell setAccountsSettingCellIconImage:nil];
//    }else if (section == 0&&row == 1) {
//        cell.detailTextLabel.text = @"阳春白雪";
//    }else {
//        cell.detailTextLabel.text = @"121111";
//    }
    cell.detailTextLabel.text = @"121111";
    
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
               
            }
            case 1:{//用户名
               
            }
            case 2:{//手机号
                
            }
            case 3:{//银行卡
                
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
        _settingArray = @[@[@"清理缓存",@"关于",@"版本",@"去评分"]];
    }
    return _settingArray;
}

@end
