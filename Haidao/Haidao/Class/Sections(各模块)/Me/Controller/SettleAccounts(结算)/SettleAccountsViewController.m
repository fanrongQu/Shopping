//
//  SettleAccountsViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "SettleAccountsViewController.h"
#import "HotboomView.h"
#import "SettleAccountsView.h"
#import "MakeSureSettleAccountsView.h"

@interface SettleAccountsViewController ()<MakeSureSettleAccountsViewDelegate>

/**  滚动视图  */
@property (nonatomic, strong) UIScrollView *scrollView;
/**  可结算总额  */
@property (nonatomic, strong) HotboomView *canSettleView;
/**  结算类型  */
@property (nonatomic, strong) HotboomView *settleTypeView;
/**  结算额  */
@property (nonatomic, strong) HotboomView *settleNumberView;
/**  结算银行  */
@property (nonatomic, strong) SettleAccountsView *settleBankView;
/**  支付密码  */
@property (nonatomic, strong) HotboomView *passwordView;
/**  确认按钮  */
@property (nonatomic, strong) UIButton *nextStepButton;
/**  确认信息视图  */
@property (nonatomic, strong) MakeSureSettleAccountsView *makeSureSettleAccounts;

@end

@implementation SettleAccountsViewController

+ (void)showSettleAccountsViewController:(UIViewController *)controller {
    
    SettleAccountsViewController *settleAccountsViewVC = [[SettleAccountsViewController alloc]init];
    [controller.navigationController pushViewController:settleAccountsViewVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算";
    
    [self addEvent];
}

- (void)dealloc {
    
    if (_scrollView != nil) _scrollView = nil;
    
    if (_canSettleView != nil) _canSettleView = nil;
    
    if (_settleTypeView != nil) _settleTypeView = nil;
    
    if (_settleNumberView != nil) _settleNumberView = nil;
    
    if (_settleBankView != nil) _settleBankView = nil;
    
    if (_passwordView != nil) _passwordView = nil;
    
    if (_nextStepButton != nil) _nextStepButton = nil;
}

/**
 *  添加点击事件
 */
- (void)addEvent {
    
    UITapGestureRecognizer *settleTypeViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSettleType)];
    [self.settleTypeView addGestureRecognizer:settleTypeViewTapGesture];
    
    UITapGestureRecognizer *settleBankViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSettleBank)];
    [self.settleBankView addGestureRecognizer:settleBankViewTapGesture];
    
    //下一步
    [[self.nextStepButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.makeSureSettleAccounts setMakeSureSettleAccountsViewWithBusinessName:@"波司登专卖店" telephone:@"15888888888" clearingMoney:@"10000" clearingType:@"消费" clearingTime:@"2016-08-20  12:00"];
//        [self makeSureSettleAccounts];
    }];
}

/**
 *  选择结算类型
 */
- (void)changeSettleType {
    NSLog(@"选择结算类型");
}

/**
 *  选择结算银行卡
 */
- (void)changeSettleBank {
    NSLog(@"选择结算银行卡");
}

#pragma mark - MakeSureSettleAccounts delegate
- (void)makeSureSettleAccounts:(BOOL)settleAccounts {
    [self.makeSureSettleAccounts removeFromSuperview];
    self.makeSureSettleAccounts = nil;
    if (settleAccounts) {
        NSLog(@"点击是按钮");
        
    }else {
        NSLog(@"点击否按钮");
   
    }
}


#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    return _scrollView;
}

- (HotboomView *)canSettleView {
    if (!_canSettleView) {
        _canSettleView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_canSettleView];
        [_canSettleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 45));
        }];
        _canSettleView.detailLabel.font = kFontSize(16);
        _canSettleView.detailLabel.textColor = kRedColor;
        
        _canSettleView.titleLabel.text = @"可结算总额";
        _canSettleView.detailLabel.text = @"121111";
    }
    return _canSettleView;
}

- (HotboomView *)settleTypeView {
    if (!_settleTypeView) {
        _settleTypeView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_settleTypeView];
        __weak typeof(self) weakSelf = self;
        [_settleTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.canSettleView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.canSettleView);
            make.size.mas_equalTo(weakSelf.canSettleView);
        }];
        _settleTypeView.detailLabel.textAlignment = NSTextAlignmentRight;
        _settleTypeView.titleLabel.text = @"结算类型";
        _settleTypeView.detailLabel.text = @"保证金结算";
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [_settleTypeView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [imageView setImage:[UIImage imageNamed:@"导向"]];
    }
    return _settleTypeView;
}

- (HotboomView *)settleNumberView {
    if (!_settleNumberView) {
        _settleNumberView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_settleNumberView];
        __weak typeof(self) weakSelf = self;
        [_settleNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.settleTypeView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.canSettleView);
            make.size.mas_equalTo(weakSelf.canSettleView);
        }];
        _settleNumberView.titleLabel.text = @"结算金额";
        _settleNumberView.textFiled.placeholder = @"请输入结算金额";
    }
    return _settleNumberView;
}

- (SettleAccountsView *)settleBankView {
    if (!_settleBankView) {
        _settleBankView = [[SettleAccountsView alloc]init];
        [self.scrollView addSubview:_settleBankView];
        __weak typeof(self) weakSelf = self;
        [_settleBankView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.settleNumberView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.canSettleView);
            make.size.mas_equalTo(weakSelf.canSettleView);
        }];
        _settleBankView.titleLabel.text = @"工商银行";
        _settleBankView.detailLabel.text = @"尾号0416";
    }
    return _settleBankView;
}

- (HotboomView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_passwordView];
        __weak typeof(self) weakSelf = self;
        [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.settleBankView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.canSettleView);
            make.size.mas_equalTo(weakSelf.canSettleView);
        }];
        _passwordView.titleLabel.text = @"支付密码";
        _passwordView.textFiled.placeholder = @"请输入支付密码";
    }
    return _passwordView;
}

- (UIButton *)nextStepButton {
    if (!_nextStepButton) {
        _nextStepButton = [[UIButton alloc]init];
        [self.scrollView addSubview:_nextStepButton];
        __weak typeof(self) weakSelf = self;
        [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.passwordView.mas_bottom).offset(20);
            make.width.mas_equalTo(kScreenWidth - 60);
            make.height.mas_equalTo(40);
            make.centerX.mas_equalTo(weakSelf.passwordView);
            make.bottom.mas_equalTo(-60);
        }];
        _nextStepButton.titleLabel.font = kFontSize(14);
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _nextStepButton.backgroundColor = kRedColor;
    }
    return _nextStepButton;
}

- (MakeSureSettleAccountsView *)makeSureSettleAccounts {
    if (!_makeSureSettleAccounts) {
        _makeSureSettleAccounts = [[MakeSureSettleAccountsView alloc]init];
        [self.view addSubview:_makeSureSettleAccounts];
        [_makeSureSettleAccounts mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _makeSureSettleAccounts.delegate = self;
    }
    return _makeSureSettleAccounts;
}

@end
