//
//  PersonalNameViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/6.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "PersonalNameViewController.h"
#import "FRTextField.h"

@interface PersonalNameViewController ()

/**  昵称背景  */
@property (nonatomic, strong) UIView *bgView;
/**  昵称  */
@property (nonatomic, strong) FRTextField *nameFiled;

@end

@implementation PersonalNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    
    [self nameFiled];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
}

- (void)dealloc {
    if (_bgView != nil) _bgView = nil;
    
    if (_nameFiled != nil) _nameFiled = nil;
}

- (void)rightBarButtonItemClick {
    NSString *name = self.nameFiled.text;
    NSLog(@"%@",name);
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        [self.view addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(80);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (FRTextField *)nameFiled {
    if (!_nameFiled) {
        _nameFiled = [[FRTextField alloc]init];
        _nameFiled.placeholder = @"请输入新的昵称";
        [self.bgView addSubview:_nameFiled];
        __weak typeof(self) weakSelf = self;
        [_nameFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(35);
            make.centerY.mas_equalTo(weakSelf.bgView);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        [self.bgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameFiled.mas_bottom);
            make.left.right.mas_equalTo(_nameFiled);
            make.height.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _nameFiled;
}

@end
