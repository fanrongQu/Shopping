//
//  StoreSettingViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "StoreSettingViewController.h"
#import "StoreSettingCell.h"
#import "StoreDetailSettingViewController.h"
#import "StoreIntroSettingViewController.h"
#import "StoreAddressSettingViewController.h"

@interface StoreSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  设置表格  */
@property (nonatomic, strong) UITableView *tableView;
/**  设置内容  */
@property (nonatomic, strong) NSArray *storeSettings;

@end

@implementation StoreSettingViewController

+ (void)showStoreSettingViewController:(UIViewController *)controller {
    StoreSettingViewController *storeSettingVC = [[StoreSettingViewController alloc]init];
    [controller.navigationController pushViewController:storeSettingVC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺设置";
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

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storeSettings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    StoreSettingCell *cell = [StoreSettingCell cellWithTableView:tableView];
    cell.titleLabel.text = self.storeSettings[row];
    
    switch (row) {
        case 0:
            cell.detailLabel.text = @"波司登旗舰店";
            break;
        case 1:
            cell.iconImageView.backgroundColor = [UIColor yellowColor];
            break;
        case 2:
            cell.detailLabel.text = @"河南省 南阳市";
            break;
        case 3:
            cell.detailLabel.text = @"15839999999";
            break;
        case 4:
            cell.detailLabel.text = @"666666";
            break;
        case 5:
            cell.detailLabel.text = @"238782778";
            break;
        case 6:
            cell.describeLabel.attributedText = [NSAttributedString attributedStringWithString:@"波司登旗舰店,专注、专业为您服务波司登旗舰店,专注、专业为您服务波司登旗舰店,专注、专业为您服务波司登旗舰店,专注、专业为您服务"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case 0: {//店铺名称
            
            StoreDetailSettingViewController *storeDetailSettingVC = [StoreDetailSettingViewController showStoreDetailSettingViewController:self title:@"店铺名称"];
            storeDetailSettingVC.block = ^(NSString *str){
                NSLog(@"店铺名称   %@",str);
                
            };
        }
            break;
        case 1: {
            
        }
            break;
            
        case 2: {
             
            StoreAddressSettingViewController *storeAddressSettingVC = [StoreAddressSettingViewController showStoreAddressSettingViewController:self];
            storeAddressSettingVC.block = ^(NSString *str){
                NSLog(@"店铺地址   %@",str);
                
            };
        }
            break;
            
        case 3: {
            
            StoreDetailSettingViewController *storeDetailSettingVC = [StoreDetailSettingViewController showStoreDetailSettingViewController:self title:@"联系电话"];
            storeDetailSettingVC.block = ^(NSString *str){
                NSLog(@"联系电话   %@",str);
                
            };
        }
            break;
            
        case 4: {
            
            StoreDetailSettingViewController *storeDetailSettingVC = [StoreDetailSettingViewController showStoreDetailSettingViewController:self title:@"联系QQ"];
            storeDetailSettingVC.block = ^(NSString *str){
                NSLog(@"联系QQ   %@",str);
                
            };
        }
            break;
            
        case 5: {
            StoreDetailSettingViewController *storeDetailSettingVC = [StoreDetailSettingViewController showStoreDetailSettingViewController:self title:@"阿里旺旺"];
            storeDetailSettingVC.block = ^(NSString *str){
                NSLog(@"阿里旺旺   %@",str);
                
            };
        }
            break;
            
        case 6: {
            StoreIntroSettingViewController *storeIntroSettingVC = [StoreIntroSettingViewController showStoreIntroSettingViewController:self];
            storeIntroSettingVC.block = ^(NSString *str){
                NSLog(@"店铺简介   %@",str);
                
            };
        }
            break;
        
        default:
            break;
    }
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

- (NSArray *)storeSettings {
    if (!_storeSettings) {
        _storeSettings = @[@"店铺名称",@"头像",@"店铺地址",@"联系电话",@"联系QQ",@"阿里旺旺",@"店铺简介"];
    }
    return _storeSettings;
}


@end
