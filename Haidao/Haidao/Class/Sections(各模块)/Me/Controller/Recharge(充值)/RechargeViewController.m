//
//  RechargeViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "RechargeViewController.h"
#import "HotboomView.h"
#import "MakeSureRechargeView.h"
#import "RechargeTypeViewController.h"

@interface RechargeViewController ()<MakeSureRechargeViewDelegate>

/**  可结算总额  */
@property (nonatomic, strong) HotboomView *rechargeMoneyView;
/**  结算类型  */
@property (nonatomic, strong) HotboomView *rechargeTypeView;
/**  确认按钮  */
@property (nonatomic, strong) UIButton *nextStepButton;
/**  确认信息视图  */
@property (nonatomic, strong) MakeSureRechargeView *makeSureRechargeView;

@end

@implementation RechargeViewController


+ (void)showRechargeViewController:(UIViewController *)controller {
    RechargeViewController *rechargeVC = [[RechargeViewController alloc]init];
    [controller.navigationController pushViewController:rechargeVC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    
    [self addEvent];
}

- (void)dealloc {
    
    if (_rechargeMoneyView != nil) _rechargeMoneyView = nil;
    
    if (_rechargeTypeView != nil) _rechargeTypeView = nil;
    
    if (_nextStepButton != nil) _nextStepButton = nil;
    
    if (_makeSureRechargeView != nil) _makeSureRechargeView = nil;
}


/**
 *  添加点击事件
 */
- (void)addEvent {
    
    UITapGestureRecognizer *rechargeTypeViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changerechargeType)];
    [self.rechargeTypeView addGestureRecognizer:rechargeTypeViewTapGesture];
    
    [[self.nextStepButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.makeSureRechargeView setMakeSureRechargeViewWithBusinessName:@"波司登羽绒服旗舰店" telephone:@"15888888888" rechargeMoney:@"1000" receiveIntegral:@"100"];
    }];
}


/**
 *  选择充值类型
 */
- (void)changerechargeType {
    NSLog(@"选择充值类型");
    
    RechargeTypeViewController *rechargeType = [RechargeTypeViewController showRechargeTypeViewController:self];
    rechargeType.block = ^(NSString *str){
        NSLog(@"充值类型   %@",str);
        
    };
}



#pragma mark - makeSureRechargeView delegate
- (void)makeSureRechargeView:(BOOL)settleAccounts {
    [self.makeSureRechargeView removeFromSuperview];
    self.makeSureRechargeView = nil;
    if (settleAccounts) {
        NSLog(@"点击是按钮");
        
    }else {
        NSLog(@"点击否按钮");
        
    }
}

#pragma mark - 懒加载
- (HotboomView *)rechargeMoneyView {
    if (!_rechargeMoneyView) {
        _rechargeMoneyView = [[HotboomView alloc]init];
        [self.view addSubview:_rechargeMoneyView];
        [_rechargeMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 45));
        }];
        _rechargeMoneyView.titleLabel.text = @"充值金额";
        _rechargeMoneyView.textFiled.placeholder = @"请输入充值金额";
    }
    return _rechargeMoneyView;
}

- (HotboomView *)rechargeTypeView {
    if (!_rechargeTypeView) {
        _rechargeTypeView = [[HotboomView alloc]init];
        [self.view addSubview:_rechargeTypeView];
        __weak typeof(self) weakSelf = self;
        [_rechargeTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.rechargeMoneyView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.rechargeMoneyView);
            make.size.mas_equalTo(weakSelf.rechargeMoneyView);
        }];
        _rechargeTypeView.titleLabel.text = @"支付方式";
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [_rechargeTypeView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [imageView setImage:[UIImage imageNamed:@"导向"]];
    }
    return _rechargeTypeView;
}


- (UIButton *)nextStepButton {
    if (!_nextStepButton) {
        _nextStepButton = [[UIButton alloc]init];
        [self.view addSubview:_nextStepButton];
        __weak typeof(self) weakSelf = self;
        [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.rechargeTypeView.mas_bottom).offset(20);
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



- (MakeSureRechargeView *)makeSureRechargeView {
    if (!_makeSureRechargeView) {
        _makeSureRechargeView = [[MakeSureRechargeView alloc]init];
        [self.view addSubview:_makeSureRechargeView];
        [_makeSureRechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _makeSureRechargeView.delegate = self;
    }
    return _makeSureRechargeView;
}


@end
