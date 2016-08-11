//
//  RefundableMoneyViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/3.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "RefundableMoneyViewController.h"
#import "PresentButton.h"

#import "RefundableClearViewController.h"
#import "RefundableReturnViewController.h"

@interface RefundableMoneyViewController ()

/**  scrollView  */
@property (nonatomic, strong) UIScrollView *scrollView;
/**  顶部背景  */
@property (nonatomic, strong) UIImageView *bgImageView;
/**  图标  */
@property (nonatomic, strong) UIImageView *iconImageView;
/**  可结算保证金文字  */
@property (nonatomic, strong) UILabel *canClearingPaymentText;
/**  可结算保证金  */
@property (nonatomic, strong) UILabel *canClearingPaymentLabel;
/**  今日文字  */
@property (nonatomic, strong) UILabel *todayText;
/**  今日  */
@property (nonatomic, strong) UILabel *todayLabel;
/**  待返文字  */
@property (nonatomic, strong) UILabel *stayText;
/**  待返  */
@property (nonatomic, strong) UILabel *stayLabel;
/**  历史文字  */
@property (nonatomic, strong) UILabel *historyText;
/**  历史  */
@property (nonatomic, strong) UILabel *historyLabel;
/**  已结算保证金  */
@property (nonatomic, strong) PresentButton *isClearingButton;
/**  已返还保证金  */
@property (nonatomic, strong) PresentButton *returnButton;
/**  结算保证金按钮  */
@property (nonatomic, strong) UIButton *clearingPaymentButton;

@end

@implementation RefundableMoneyViewController

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保证金";
    [self bgImageView];
    [self clearingPaymentButton];
    
    [self setCanClearingPayment:@"10000" today:@"1200000"  stay:@"200" history:@"9999999" canClearingIntegral:@"2300" RefundableMoney:@"400"];
}

- (void)dealloc {
    if (_scrollView != nil) _scrollView = nil;
    
    if (_bgImageView != nil) _bgImageView = nil;
    
    if (_iconImageView != nil) _iconImageView = nil;
    
    if (_canClearingPaymentText != nil) _canClearingPaymentText = nil;
    
    if (_canClearingPaymentLabel != nil) _canClearingPaymentLabel = nil;
    
    if (_todayText != nil) _todayText = nil;
    
    if (_todayLabel != nil) _todayLabel = nil;
    
    if (_stayText != nil) _stayLabel = nil;
    
    if (_historyText != nil) _historyText = nil;
    
    if (_historyLabel != nil) _historyLabel = nil;
    
    if (_isClearingButton != nil) _isClearingButton = nil;
    
    if (_returnButton != nil) _returnButton = nil;
    
    if (_clearingPaymentButton != nil) _clearingPaymentButton = nil;
}

- (void)setCanClearingPayment:(NSString *)canClearingPayment today:(NSString *)today stay:(NSString *)stay history:(NSString *)history canClearingIntegral:(NSString *)canClearingIntegral RefundableMoney:(NSString *)RefundableMoney {
    
    self.canClearingPaymentLabel.text = canClearingPayment;
    self.todayLabel.text = today;
    self.stayLabel.text = stay;
    self.historyLabel.text = history;
    [self.isClearingButton setPresentNumber:canClearingPayment type:@"已结算保证金"];
    [self.returnButton setPresentNumber:RefundableMoney type:@"已返还保证金"];
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



- (UILabel *)todayText {
    if (!_todayText) {
        _todayText = [[UILabel alloc]init];
        [self.scrollView addSubview:_todayText];
        __weak typeof(self) weakSelf = self;
        [_todayText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.iconImageView);
            make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(12);
        }];
        _todayText.font = kFontSize(12);
        _todayText.text = @"今日";
        _todayText.textColor = [UIColor whiteColor];
    }
    return _todayText;
}


- (UILabel *)todayLabel {
    if (!_todayLabel) {
        _todayLabel = [[UILabel alloc]init];
        [self.scrollView addSubview:_todayLabel];
        __weak typeof(self) weakSelf = self;
        [_todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.todayText);
            make.left.mas_equalTo(weakSelf.todayText.mas_right).offset(10);
        }];
        _todayLabel.font = kFontSize(12);
        _todayLabel.textColor = [UIColor whiteColor];
    }
    return _todayLabel;
}


- (UILabel *)stayText {
    if (!_stayText) {
        _stayText = [[UILabel alloc]init];
        [self.scrollView addSubview:_stayText];
        __weak typeof(self) weakSelf = self;
        [_stayText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.todayLabel);
            make.left.mas_equalTo(weakSelf.todayLabel.mas_right).offset(30);
        }];
        _stayText.font = kFontSize(12);
        _stayText.text = @"待返";
        _stayText.textColor = [UIColor whiteColor];
    }
    return _stayText;
}


- (UILabel *)stayLabel {
    if (!_stayLabel) {
        _stayLabel = [[UILabel alloc]init];
        [self.scrollView addSubview:_stayLabel];
        __weak typeof(self) weakSelf = self;
        [_stayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.stayText);
            make.left.mas_equalTo(weakSelf.stayText.mas_right).offset(10);
        }];
        _stayLabel.font = kFontSize(12);
        _stayLabel.textColor = [UIColor whiteColor];
    }
    return _stayLabel;
}


- (UILabel *)historyText {
    if (!_historyText) {
        _historyText = [[UILabel alloc]init];
        [self.scrollView addSubview:_historyText];
        __weak typeof(self) weakSelf = self;
        [_historyText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.todayText.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.todayText);
        }];
        _historyText.font = kFontSize(12);
        _historyText.text = @"历史";
        _historyText.textColor = [UIColor whiteColor];
    }
    return _historyText;
}


- (UILabel *)historyLabel {
    if (!_historyLabel) {
        _historyLabel = [[UILabel alloc]init];
        [self.scrollView addSubview:_historyLabel];
        __weak typeof(self) weakSelf = self;
        [_historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.historyText);
            make.left.mas_equalTo(weakSelf.historyText.mas_right).offset(10);
        }];
        _historyLabel.font = kFontSize(12);
        _historyLabel.textColor = [UIColor whiteColor];
    }
    return _historyLabel;
}

/**
 *  已结算保证金
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
            RefundableClearViewController *refundableClearrVC = [[RefundableClearViewController alloc]init];
            [self.navigationController pushViewController:refundableClearrVC animated:YES];
        }];
    }
    return _isClearingButton;
}

/**
 *  保证金收入
 */
- (PresentButton *)returnButton {
    if (!_returnButton) {
        _returnButton = [[PresentButton alloc]init];
        [self.scrollView addSubview:_returnButton];
        __weak typeof(self) weakSelf = self;
        [_returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.isClearingButton);
            make.left.mas_equalTo(weakSelf.isClearingButton.mas_right).offset(1.0);
            make.size.mas_equalTo(weakSelf.isClearingButton);
        }];
        _returnButton.backgroundColor = [UIColor whiteColor];
        
        [[_returnButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            RefundableReturnViewController *refundableReturnVC = [[RefundableReturnViewController alloc]init];
            [self.navigationController pushViewController:refundableReturnVC animated:YES];
        }];
    }
    return _returnButton;
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
        [_clearingPaymentButton setTitle:@"结算保证金" forState:UIControlStateNormal];
        [_clearingPaymentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _clearingPaymentButton.backgroundColor = kRedColor;
    }
    return _clearingPaymentButton;
}

@end

