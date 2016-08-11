//
//  StoreAddressSettingViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "StoreAddressSettingViewController.h"
#import "HotboomView.h"
#import "DetailAddressView.h"

@interface StoreAddressSettingViewController ()

/**  选择地区  */
@property (nonatomic, strong) HotboomView *changeAreaView;
/**  详细地址  */
@property (nonatomic, strong) DetailAddressView *detailView;

@end

@implementation StoreAddressSettingViewController


+ (StoreAddressSettingViewController *)showStoreAddressSettingViewController:(UIViewController *)controller {
    StoreAddressSettingViewController *StoreAddressSettingVC = [[StoreAddressSettingViewController alloc]init];
    [controller.navigationController pushViewController:StoreAddressSettingVC animated:YES];
    
    return StoreAddressSettingVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    //解决使用系统导航栏，UITextView编辑光标默认是显示在左边居中的位置
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self detailView];
}

- (void)dealloc {
    
}

- (void)rightBarButtonItemClick {
    NSString *string = self.changeAreaView.textFiled.text;
    
    if (self.block) {
        self.block(string);
    }
}

#pragma mark - 懒加载
- (HotboomView *)changeAreaView {
    if (!_changeAreaView) {
        _changeAreaView = [[HotboomView alloc]init];
        [self.view addSubview:_changeAreaView];
        [_changeAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 45));
        }];
        _changeAreaView.titleLabel.text = @"选择地区";
        _changeAreaView.textFiled.placeholder = @"地区信息";
    }
    return _changeAreaView;
}

- (DetailAddressView *)detailView {
    if (!_detailView) {
        _detailView = [[DetailAddressView alloc]init];
        [self.view addSubview:_detailView];
        __weak typeof(self) weakSelf = self;
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.changeAreaView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.changeAreaView);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 65));
        }];
        _detailView.titleLabel.text = @"详细地址";
        [_detailView textView];
//        _detailView.textView.placeholder = @"街道门牌信息";
    }
    return _detailView;
}



@end
