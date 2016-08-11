//
//  BusinessPaymentViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/2.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BusinessPaymentViewController.h"
#import "PresentButton.h"

#import "BusinessCanClearingViewController.h"
#import "BusinessIsClearingViewController.h"

@interface BusinessPaymentViewController ()

/**  scrollView  */
@property (nonatomic, strong) UIScrollView *scrollView;
/**  顶部背景  */
@property (nonatomic, strong) UIImageView *bgImageView;
/**  图标  */
@property (nonatomic, strong) UIImageView *iconImageView;
/**  可结算货款文字  */
@property (nonatomic, strong) UILabel *canClearingPaymentText;
/**  可结算货款  */
@property (nonatomic, strong) UILabel *canClearingPaymentLabel;
/**  总货款文字  */
@property (nonatomic, strong) UILabel *allPaymentText;
/**  总货款  */
@property (nonatomic, strong) UILabel *allPaymentLabel;
/**  已结算货款  */
@property (nonatomic, strong) PresentButton *isClearingButton;
/**  货款收入  */
@property (nonatomic, strong) PresentButton *canClearingButton;
/**  结算货款按钮  */
@property (nonatomic, strong) UIButton *clearingPaymentButton;

@end

@implementation BusinessPaymentViewController

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"货款";
    [self bgImageView];
    [self clearingPaymentButton];
    
    [self setCanClearingPayment:@"10000" allPayment:@"1200000" canClearingIntegral:@"2300" BusinessPayment:@"400"];
}


- (void)dealloc {
    if (_scrollView != nil) _scrollView = nil;
    
    if (_bgImageView != nil) _bgImageView = nil;
    
    if (_iconImageView != nil) _iconImageView = nil;
    
    if (_canClearingPaymentText != nil) _canClearingPaymentText = nil;
    
    if (_canClearingPaymentLabel != nil) _canClearingPaymentLabel = nil;
    
    if (_allPaymentText != nil) _allPaymentText = nil;
    
    if (_allPaymentLabel != nil) _allPaymentLabel = nil;
    
    if (_isClearingButton != nil) _isClearingButton = nil;
    
    if (_canClearingButton != nil) _canClearingButton = nil;
    
    if (_clearingPaymentButton != nil) _clearingPaymentButton = nil;
}


- (void)setCanClearingPayment:(NSString *)canClearingPayment allPayment:(NSString *)allPayment canClearingIntegral:(NSString *)canClearingIntegral BusinessPayment:(NSString *)BusinessPayment {
    
    self.canClearingPaymentLabel.text = canClearingPayment;
    self.allPaymentLabel.text = allPayment;
    [self.isClearingButton setPresentNumber:canClearingPayment type:@"已结算货款"];
    [self.canClearingButton setPresentNumber:BusinessPayment type:@"货款收入"];
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

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        [self.scrollView addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 140));
        }];
        [_bgImageView setImage:[UIImage imageNamed:@"bg"]];
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        [self.bgImageView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.size.mas_equalTo(50);
            make.centerY.mas_equalTo(0);
        }];
        [_iconImageView setImage:[UIImage imageNamed:@"refundable"]];
    }
    return _iconImageView;
}

- (UILabel *)canClearingPaymentText {
    if (!_canClearingPaymentText) {
        _canClearingPaymentText = [[UILabel alloc]init];
        [self.scrollView addSubview:_canClearingPaymentText];
        __weak typeof(self) weakSelf = self;
        [_canClearingPaymentText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.iconImageView).offset(10);
            make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(12);
        }];
        _canClearingPaymentText.font = kFontSize(12);
        _canClearingPaymentText.text = @"可结算";
        _canClearingPaymentText.textColor = [UIColor whiteColor];
    }
    return _canClearingPaymentText;
}

- (UILabel *)canClearingPaymentLabel {
    if (!_canClearingPaymentLabel) {
        _canClearingPaymentLabel = [[UILabel alloc]init];
        [self.scrollView addSubview:_canClearingPaymentLabel];
        __weak typeof(self) weakSelf = self;
        [_canClearingPaymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.canClearingPaymentText);
            make.left.mas_equalTo(weakSelf.canClearingPaymentText.mas_right).offset(10);
        }];
        _canClearingPaymentLabel.font = kFontSize(20);
        _canClearingPaymentLabel.textColor = [UIColor whiteColor];
    }
    return _canClearingPaymentLabel;
}



- (UILabel *)allPaymentText {
    if (!_allPaymentText) {
        _allPaymentText = [[UILabel alloc]init];
        [self.scrollView addSubview:_allPaymentText];
        __weak typeof(self) weakSelf = self;
        [_allPaymentText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.iconImageView);
            make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(12);
        }];
        _allPaymentText.font = kFontSize(12);
        _allPaymentText.text = @"货款总额";
        _allPaymentText.textColor = [UIColor whiteColor];
    }
    return _allPaymentText;
}


- (UILabel *)allPaymentLabel {
    if (!_allPaymentLabel) {
        _allPaymentLabel = [[UILabel alloc]init];
        [self.scrollView addSubview:_allPaymentLabel];
        __weak typeof(self) weakSelf = self;
        [_allPaymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.allPaymentText);
            make.left.mas_equalTo(weakSelf.allPaymentText.mas_right).offset(10);
        }];
        _allPaymentLabel.font = kFontSize(12);
        _allPaymentLabel.textColor = [UIColor whiteColor];
    }
    return _allPaymentLabel;
}

/**
 *  已结算货款
 */
- (PresentButton *)isClearingButton {
    if (!_isClearingButton) {
        _isClearingButton = [[PresentButton alloc]init];
        [self.scrollView addSubview:_isClearingButton];
        __weak typeof(self) weakSelf = self;
        [_isClearingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.bgImageView.mas_bottom);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.5, 120));
            make.bottom.mas_equalTo(0);
        }];
        _isClearingButton.backgroundColor = [UIColor whiteColor];
        
        [[_isClearingButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            BusinessIsClearingViewController *businessIsClearingVC = [[BusinessIsClearingViewController alloc]init];
            [self.navigationController pushViewController:businessIsClearingVC animated:YES];
        }];
    }
    return _isClearingButton;
}

/**
 *  货款收入
 */
- (PresentButton *)canClearingButton {
    if (!_canClearingButton) {
        _canClearingButton = [[PresentButton alloc]init];
        [self.scrollView addSubview:_canClearingButton];
        __weak typeof(self) weakSelf = self;
        [_canClearingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.isClearingButton);
            make.left.mas_equalTo(weakSelf.isClearingButton.mas_right).offset(1.0);
            make.size.mas_equalTo(weakSelf.isClearingButton);
        }];
        _canClearingButton.backgroundColor = [UIColor whiteColor];
        
        [[_canClearingButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            BusinessCanClearingViewController *businessCanClearingVC = [[BusinessCanClearingViewController alloc]init];
            [self.navigationController pushViewController:businessCanClearingVC animated:YES];
        }];
    }
    return _canClearingButton;
}

- (UIButton *)clearingPaymentButton {
    if (!_clearingPaymentButton) {
        _clearingPaymentButton = [[UIButton alloc]init];
        [self.scrollView addSubview:_clearingPaymentButton];
        __weak typeof(self) weakSelf = self;
        [_clearingPaymentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(weakSelf.view).offset(-20);
            make.bottom.mas_equalTo(weakSelf.view).offset(-30);
            make.height.mas_equalTo(36);
        }];
        _clearingPaymentButton.titleLabel.font = kFontSize(14);
        [_clearingPaymentButton setTitle:@"结算货款" forState:UIControlStateNormal];
        [_clearingPaymentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _clearingPaymentButton.backgroundColor = kRedColor;
    }
    return _clearingPaymentButton;
}

@end
