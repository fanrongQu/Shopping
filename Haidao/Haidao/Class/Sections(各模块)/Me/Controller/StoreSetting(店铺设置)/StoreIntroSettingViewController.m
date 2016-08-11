//
//  StoreIntroSettingViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "StoreIntroSettingViewController.h"

@interface StoreIntroSettingViewController ()

/**  背景  */
@property (nonatomic, strong) UIView *bgView;
/**  文本输入框  */
@property (nonatomic, strong) UITextView *textView;

@end

@implementation StoreIntroSettingViewController


+ (StoreIntroSettingViewController *)showStoreIntroSettingViewController:(UIViewController *)controller {
    StoreIntroSettingViewController *storeIntroSettingVC = [[StoreIntroSettingViewController alloc]init];
    [controller.navigationController pushViewController:storeIntroSettingVC animated:YES];
    
    return storeIntroSettingVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺简介";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self.textView resignFirstResponder];
    
    //解决使用系统导航栏，UITextView编辑光标默认是显示在左边居中的位置
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)dealloc {
    
    if (_bgView != nil) _bgView = nil;
    
    if (_textView != nil) _textView = nil;
}

- (void)rightBarButtonItemClick {
    NSString *string = self.textView.text;
    
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
            make.height.mas_equalTo(200);
        }];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        [self.bgView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 15, 10, 15));
        }];
        _textView.font = kFontSize(14);
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
    }
    return _textView;
}


@end
