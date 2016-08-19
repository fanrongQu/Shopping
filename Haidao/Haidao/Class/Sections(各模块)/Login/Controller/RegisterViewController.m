//
//  RegisterViewController.m
//  Haidao
//
//  Created by 1860 on 16/7/12.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "RegisterViewController.h"
#import "FRTextField.h"

@interface RegisterViewController ()

/**  手机号  */
@property (nonatomic, strong) UILabel *phoneLabel;
/**  手机号输入框  */
@property (nonatomic, strong) FRTextField *phoneFiled;
/**  验证码  */
@property (nonatomic, strong) UILabel *CAPTCHALabel;
/**  验证码  */
@property (nonatomic, strong) FRTextField *CAPTCHAField;
/**  发送验证码  */
@property (nonatomic, strong) UIButton *sendCAPTCHABtn;
/**  下一步按钮  */
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    
    [self buttonClick];
}

- (void)dealloc {
    
    if (_phoneLabel != nil) _phoneLabel = nil;
    if (_phoneLabel != nil) _phoneLabel = nil;
    
    if (_CAPTCHALabel != nil) _CAPTCHALabel = nil;
    if (_CAPTCHAField != nil) _CAPTCHAField = nil;
    
    if (_sendCAPTCHABtn != nil) _sendCAPTCHABtn = nil;
    if (_nextBtn != nil) _nextBtn = nil;
    
}

- (void)buttonClick {
    //发送验证码
    [[self.sendCAPTCHABtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self getCAPTCHAWithBtn:_sendCAPTCHABtn];
    }];
    
    //点击下一步按钮，设置密码
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

/**
 *  验证码倒计时
 */
- (void)getCAPTCHAWithBtn:(UIButton *)button
{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:@"发送验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                [button setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                button.titleLabel.font = kFontSize(13);
                button.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}


#pragma mark - 懒加载
- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        [self.view addSubview:_phoneLabel];
        
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(85);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(42, 20));
        }];
        _phoneLabel.text = @"手机号";
        _phoneLabel.font = kFontSize(14);
    }
    return _phoneLabel;
}

- (FRTextField *)phoneFiled {
    if (!_phoneFiled) {
        _phoneFiled = [[FRTextField alloc]init];
        _phoneFiled.placeholder = @"请输入手机号";
        [self.view addSubview:_phoneFiled];
        __weak typeof(self) weakSelf = self;
        [_phoneFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(weakSelf.phoneLabel);
            make.left.mas_equalTo(weakSelf.phoneLabel.mas_right).offset(12);
            make.right.mas_equalTo(-15);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        [self.view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.phoneLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.phoneLabel);
            make.right.mas_equalTo(weakSelf.phoneFiled);
            make.height.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _phoneFiled;
}

- (UILabel *)CAPTCHALabel{
    if (!_CAPTCHALabel) {
        _CAPTCHALabel = [[UILabel alloc]init];
        [self.view addSubview:_CAPTCHALabel];
        __weak typeof(self) weakSelf = self;
        [_CAPTCHALabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.phoneLabel.mas_bottom).offset(25);
            make.left.right.height.mas_equalTo(weakSelf.phoneLabel);
        }];
        _CAPTCHALabel.text = @"校验码";
        _CAPTCHALabel.font = kFontSize(14);
    }
    return _CAPTCHALabel;
}

- (FRTextField *)CAPTCHAField {
    if (!_CAPTCHAField) {
        _CAPTCHAField = [[FRTextField alloc]init];
        _CAPTCHAField.placeholder = @"请输入短信校验码";
        _CAPTCHAField.clearButtonMode = UITextFieldViewModeNever;
        [self.view addSubview:_CAPTCHAField];
        
        __weak typeof(self) weakSelf = self;
        [_CAPTCHAField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.CAPTCHALabel);
            make.left.right.height.mas_equalTo(weakSelf.phoneFiled);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        [self.view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.CAPTCHALabel.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.phoneLabel);
            make.right.mas_equalTo(weakSelf.phoneFiled);
            make.height.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _CAPTCHAField;
}


- (UIButton *)sendCAPTCHABtn {
    if (!_sendCAPTCHABtn) {
        _sendCAPTCHABtn = [[UIButton alloc]init];
        [self.view insertSubview:_sendCAPTCHABtn aboveSubview:self.CAPTCHAField];
        _sendCAPTCHABtn.titleLabel.font = kFontSize(14);
        _sendCAPTCHABtn.backgroundColor = kSubjectColor;
        [_sendCAPTCHABtn setTitle:@"发送校验码" forState:UIControlStateNormal];
        [_sendCAPTCHABtn.layer setMasksToBounds:YES];
        [_sendCAPTCHABtn.layer setCornerRadius:5.0];
        
        __weak typeof(self) weakSelf = self;
        [_sendCAPTCHABtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.mas_equalTo(weakSelf.CAPTCHAField);
            make.size.mas_equalTo(CGSizeMake(100, 35));
        }];
    }
    return _sendCAPTCHABtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc]init];
        [self.view addSubview:_nextBtn];
        _nextBtn.titleLabel.font = kFontSize(15);
        _nextBtn.backgroundColor = kSubjectColor;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn.layer setMasksToBounds:YES];
        [_nextBtn.layer setCornerRadius:5.0];
        
        __weak typeof(self) weakSelf = self;
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.CAPTCHAField.mas_bottom).offset(35);
            make.left.mas_equalTo(weakSelf.phoneLabel);
            make.right.mas_equalTo(weakSelf.phoneFiled);
            make.height.mas_equalTo(35);
        }];
    }
    return _nextBtn;
}

@end
