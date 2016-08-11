//
//  BusinessMemberViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BusinessMemberViewController.h"
#import "HotboomView.h"
#import "MemberRecordViewController.h"

@interface BusinessMemberViewController ()

/**  手机号  */
@property (nonatomic, strong) HotboomView *telphoneView;
/**  真实姓名  */
@property (nonatomic, strong) HotboomView *trueNameView;
/**  确认按钮  */
@property (nonatomic, strong) UIButton *nextStepButton;
@end

@implementation BusinessMemberViewController


+ (void)showBusinessMemberViewController:(UIViewController *)controller {
    BusinessMemberViewController *businessMemberVC = [[BusinessMemberViewController alloc]init];
    [controller.navigationController pushViewController:businessMemberVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"会员开户";
    
    [[self.nextStepButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
}

- (void)dealloc {
    
    if (_telphoneView != nil) _telphoneView = nil;
    
    if (_trueNameView != nil) _trueNameView = nil;
    
    if (_nextStepButton != nil) _nextStepButton = nil;
}

/**
 *  点击记录按钮
 */
- (void)rightBarButtonItemClick {
    MemberRecordViewController *memberRecordVC = [[MemberRecordViewController alloc]init];
    [self.navigationController pushViewController:memberRecordVC animated:YES];
}

#pragma mark - 懒加载
- (HotboomView *)telphoneView {
    if (!_telphoneView) {
        _telphoneView = [[HotboomView alloc]init];
        [self.view addSubview:_telphoneView];
        [_telphoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 45));
        }];
        _telphoneView.titleLabel.text = @"手机号";
        _telphoneView.textFiled.placeholder = @"请输入手机号";
    }
    return _telphoneView;
}

- (HotboomView *)trueNameView {
    if (!_trueNameView) {
        _trueNameView = [[HotboomView alloc]init];
        [self.view addSubview:_trueNameView];
        __weak typeof(self) weakSelf = self;
        [_trueNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.telphoneView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.telphoneView);
            make.size.mas_equalTo(weakSelf.telphoneView);
        }];
        _trueNameView.titleLabel.text = @"真实姓名";
        _trueNameView.textFiled.placeholder = @"请输入真实姓名";
    }
    return _trueNameView;
}


- (UIButton *)nextStepButton {
    if (!_nextStepButton) {
        _nextStepButton = [[UIButton alloc]init];
        [self.view addSubview:_nextStepButton];
        __weak typeof(self) weakSelf = self;
        [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.trueNameView.mas_bottom).offset(35);
            make.width.mas_equalTo(kScreenWidth - 60);
            make.height.mas_equalTo(40);
            make.centerX.mas_equalTo(0);
        }];
        _nextStepButton.titleLabel.font = kFontSize(14);
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _nextStepButton.backgroundColor = kRedColor;
    }
    return _nextStepButton;
}



@end
