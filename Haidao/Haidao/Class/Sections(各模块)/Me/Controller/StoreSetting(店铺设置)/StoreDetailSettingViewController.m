//
//  StoreDetailSettingViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "StoreDetailSettingViewController.h"
#import "FRTextField.h"

@interface StoreDetailSettingViewController ()

/**  背景  */
@property (nonatomic, strong) UIView *bgView;
/**  文本输入框  */
@property (nonatomic, strong) FRTextField *textFiled;

@end

@implementation StoreDetailSettingViewController

+ (StoreDetailSettingViewController *)showStoreDetailSettingViewController:(UIViewController *)controller title:(NSString *)title {
    StoreDetailSettingViewController *storeDetailSettingVC = [[StoreDetailSettingViewController alloc]init];
    storeDetailSettingVC.title = title;
    [controller.navigationController pushViewController:storeDetailSettingVC animated:YES];
    
    return storeDetailSettingVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    NSString *placeholderText = [NSString stringWithFormat:@"请输入%@",self.title];
    self.textFiled.placeholder = placeholderText;
    [self.textFiled resignFirstResponder];
}

- (void)dealloc {
    
    if (_bgView != nil) _bgView = nil;
    
    if (_textFiled != nil) _textFiled = nil;
}

- (void)rightBarButtonItemClick {
    NSString *string = self.textFiled.text;
    
    if (self.block) {
        self.block(string);
    }
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        [self.view addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(84);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (FRTextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[FRTextField alloc]init];
        [self.bgView addSubview:_textFiled];
        [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(0);
        }];
        _textFiled.font = kFontSize(14);
    }
    return _textFiled;
}

@end
