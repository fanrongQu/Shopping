//
//  LoginViewController.m
//  Haidao
//
//  Created by 1860 on 16/7/12.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "LoginViewController.h"
#import "FRTextField.h"

#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"

@interface LoginViewController ()

/**  用户名  */
@property (nonatomic, strong) UILabel *nameLabel;
/**  用户名输入框  */
@property (nonatomic, strong) FRTextField *nameField;
/**  密码  */
@property (nonatomic, strong) UILabel *pwdLabel;
/**  密码输入框  */
@property (nonatomic, strong) FRTextField *pwdField;
/**  登录按钮  */
@property (nonatomic, strong) UIButton *loginBtn;
/**  注册按钮  */
@property (nonatomic, strong) UIButton *registerBtn;
/**  忘记密码  */
@property (nonatomic, strong) UIButton *forgetPwdBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self forgetPwdBtn];
    
    [self buttonClick];
    
}

- (void)dealloc {
    
    if (_nameLabel != nil) _nameLabel = nil;
    if (_nameField != nil) _nameField = nil;
    
    if (_pwdLabel != nil) _pwdLabel = nil;
    if (_pwdField != nil) _pwdField = nil;
    
    if (_loginBtn != nil) _loginBtn = nil;
    if (_registerBtn != nil) _registerBtn = nil;
    if (_forgetPwdBtn != nil) _forgetPwdBtn = nil;
    
}

/**
 *  按钮点击事件
 */
- (void)buttonClick {
    //点击注册按钮，跳转到注册界面
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        RegisterViewController *registerVC = [[RegisterViewController alloc]init];
        [self.navigationController pushViewController:registerVC animated:YES];
    }];
    
    //忘记密码
    [[self.forgetPwdBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ForgetPwdViewController *forgetVC = [[ForgetPwdViewController alloc]init];
        [self.navigationController pushViewController:forgetVC animated:YES];
    }];
}



#pragma mark - 懒加载
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        [self.view addSubview:_nameLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(85);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(30, 20));
        }];
        _nameLabel.text = @"账号";
        _nameLabel.font = kFontSize(14);
    }
    return _nameLabel;
}

- (FRTextField *)nameField {
    if (!_nameField) {
        _nameField = [[FRTextField alloc]init];
        _nameField.placeholder = @"请输入用户名/手机号";
        [self.view addSubview:_nameField];
        __weak typeof(self) weakSelf = self;
        [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(weakSelf.nameLabel);
            make.left.mas_equalTo(weakSelf.nameLabel.mas_right).offset(12);
            make.right.mas_equalTo(-15);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        [self.view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.nameLabel);
            make.right.mas_equalTo(weakSelf.nameField);
            make.height.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _nameField;
}

- (UILabel *)pwdLabel{
    if (!_pwdLabel) {
        _pwdLabel = [[UILabel alloc]init];
        [self.view addSubview:_pwdLabel];
        __weak typeof(self) weakSelf = self;
        [_pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(25);
            make.left.right.height.mas_equalTo(weakSelf.nameLabel);
        }];
        _pwdLabel.text = @"密码";
        _pwdLabel.font = kFontSize(14);
    }
    return _pwdLabel;
}

- (FRTextField *)pwdField {
    if (!_pwdField) {
        _pwdField = [[FRTextField alloc]init];
        _pwdField.placeholder = @"请输入密码";
        [self.view addSubview:_pwdField];
        
        __weak typeof(self) weakSelf = self;
        [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.pwdLabel);
            make.left.right.height.mas_equalTo(weakSelf.nameField);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        [self.view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.pwdLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.nameLabel);
            make.right.mas_equalTo(weakSelf.nameField);
            make.height.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _pwdField;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        [self.view addSubview:_loginBtn];
        _loginBtn.titleLabel.font = kFontSize(15);
        _loginBtn.backgroundColor = [UIColor redColor];
        [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginBtn.layer setMasksToBounds:YES];
        [_loginBtn.layer setCornerRadius:5.0];
        
        __weak typeof(self) weakSelf = self;
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.pwdField.mas_bottom).offset(30);
            make.left.mas_equalTo(weakSelf.nameLabel);
            make.right.mas_equalTo(weakSelf.nameField);
            make.height.mas_equalTo(35);
        }];
    }
    return _loginBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc]init];
        [self.view addSubview:_registerBtn];
        _registerBtn.titleLabel.font = kFontSize(14);
        [_registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.loginBtn.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.loginBtn).offset(5);
            make.height.mas_equalTo(25);
        }];
    }
    return _registerBtn;
}

- (UIButton *)forgetPwdBtn {
    if (!_forgetPwdBtn) {
        _forgetPwdBtn = [[UIButton alloc]init];
        [self.view addSubview:_forgetPwdBtn];
        _forgetPwdBtn.titleLabel.font = kFontSize(14);
        [_forgetPwdBtn setTitle:@"找回密码" forState:UIControlStateNormal];
        [_forgetPwdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        [_forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.loginBtn.mas_bottom).offset(10);
            make.right.mas_equalTo(weakSelf.nameField).offset(-5);
            make.height.mas_equalTo(25);
        }];
    }
    return _forgetPwdBtn;
}

@end
