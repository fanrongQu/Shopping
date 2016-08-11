//
//  MakeSureSettleAccountsView.m
//  Haidao
//
//  Created by 1860 on 16/8/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MakeSureSettleAccountsView.h"

@interface MakeSureSettleAccountsView ()

/**  背景图  */
@property (nonatomic, strong) UIView *backView;
//商家
@property (nonatomic, strong) UILabel *businessNameText;
@property (nonatomic, strong) UILabel *businessNameLabel;
//电话
@property (nonatomic, strong) UILabel *telephoneText;
@property (nonatomic, strong) UILabel *telephoneLabel;
//结算金额
@property (nonatomic, strong) UILabel *clearingMoneyText;
@property (nonatomic, strong) UILabel *clearingMoneyLabel;
//结算类型
@property (nonatomic, strong) UILabel *clearingTypeText;
@property (nonatomic, strong) UILabel *clearingTypeLabel;
//时间
@property (nonatomic, strong) UILabel *clearingTimeLabel;
//确认结算
@property (nonatomic, strong) UILabel *makeSureLabel;
//否认
@property (nonatomic, strong) UIButton *unsureButton;
//是
@property (nonatomic, strong) UIButton *makeSureButton;

@end

@implementation MakeSureSettleAccountsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kUIColor_RGB(200, 200, 200, 0.7);
        [[self.unsureButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([self.delegate respondsToSelector:@selector(MakeSureSettleAccountsView:)]) {
                [self.delegate MakeSureSettleAccountsView:NO];
            }
        }];
        
        [[self.makeSureButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([self.delegate respondsToSelector:@selector(MakeSureSettleAccountsView:)]) {
                [self.delegate MakeSureSettleAccountsView:YES];
            }
        }];
    }
    return self;
}

- (void)setMakeSureSettleAccountsViewWithBusinessName:(NSString *)businessName telephone:(NSString *)telephone clearingMoney:(NSString *)clearingMoney clearingType:(NSString *)clearingType clearingTime:(NSString *)clearingTime {
    
    self.businessNameLabel.text = businessName;
    self.telephoneLabel.text = telephone;
    self.clearingMoneyLabel.text = clearingMoney;
    self.clearingTypeLabel.text = clearingType;
    self.clearingTimeLabel.text = clearingTime;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        [self addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView.layer setMasksToBounds:YES];
        [_backView.layer setCornerRadius:5.0];
    }
    return _backView;
}


- (UIButton *)unsureButton {
    if (!_unsureButton) {
        _unsureButton = [[UIButton alloc]init];
        [self.backView addSubview:_unsureButton];
        [_unsureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.bottom.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(120, 40));
        }];
        _unsureButton.titleLabel.font = kFontSize(14);
        [_unsureButton setTitle:@"否" forState:UIControlStateNormal];
        [_unsureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_unsureButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _unsureButton.backgroundColor = kUIColor_RGB(225, 225, 225, 1);
    }
    return _unsureButton;
}

- (UIButton *)makeSureButton {
    if (!_makeSureButton) {
        _makeSureButton = [[UIButton alloc]init];
        [self.backView addSubview:_makeSureButton];
        __weak typeof(self) weakSelf = self;
        [_makeSureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.unsureButton.mas_right);
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(weakSelf.unsureButton);
            make.size.mas_equalTo(weakSelf.unsureButton);
        }];
        
        _makeSureButton.titleLabel.font = kFontSize(14);
        [_makeSureButton setTitle:@"是" forState:UIControlStateNormal];
        [_makeSureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_makeSureButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _makeSureButton.backgroundColor = kRedColor;
    }
    return _makeSureButton;
}

- (UILabel *)makeSureLabel {
    if (!_makeSureLabel) {
        _makeSureLabel = [[UILabel alloc]init];
        [self.backView addSubview:_makeSureLabel];
        __weak typeof(self) weakSelf = self;
        [_makeSureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.unsureButton.mas_top).offset(-10);
            make.left.mas_equalTo(weakSelf.unsureButton);
            make.right.mas_equalTo(weakSelf.makeSureButton);
        }];
        _makeSureLabel.font = kFontSize(14);
        _makeSureLabel.textColor = kRedColor;
        _makeSureLabel.text = @"是否确认提现？";
    }
    return _makeSureLabel;
}

- (UILabel *)clearingTimeLabel {
    if (!_clearingTimeLabel) {
        _clearingTimeLabel = [[UILabel alloc]init];
        [self.backView addSubview:_clearingTimeLabel];
        __weak typeof(self) weakSelf = self;
        [_clearingTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.makeSureLabel.mas_top).offset(-15);
            make.left.mas_equalTo(weakSelf.unsureButton);
            make.right.mas_equalTo(weakSelf.makeSureButton);
        }];
        _clearingTimeLabel.font = kFontSize(14);
    }
    return _clearingTimeLabel;
}


- (UILabel *)clearingTypeText {
    if (!_clearingTypeText) {
        _clearingTypeText = [[UILabel alloc]init];
        [self.backView addSubview:_clearingTypeText];
        __weak typeof(self) weakSelf = self;
        [_clearingTypeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.clearingTimeLabel.mas_top).offset(-10);
            make.left.mas_equalTo(weakSelf.unsureButton);
            make.width.mas_equalTo(60);
        }];
        _clearingTypeText.font = kFontSize(14);
        _clearingTypeText.text = @"结算类型";
    }
    return _clearingTypeText;
}

- (UILabel *)clearingTypeLabel {
    if (!_clearingTypeLabel) {
        _clearingTypeLabel = [[UILabel alloc]init];
        [self.backView addSubview:_clearingTypeLabel];
        __weak typeof(self) weakSelf = self;
        [_clearingTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.clearingTypeText);
            make.left.mas_equalTo(weakSelf.clearingTypeText.mas_right).offset(10);
            make.right.mas_equalTo(weakSelf.makeSureButton);
        }];
        _clearingTypeLabel.font = kFontSize(14);
    }
    return _clearingTypeLabel;
}

- (UILabel *)clearingMoneyText {
    if (!_clearingMoneyText) {
        _clearingMoneyText = [[UILabel alloc]init];
        [self.backView addSubview:_clearingMoneyText];
        __weak typeof(self) weakSelf = self;
        [_clearingMoneyText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.clearingTypeText.mas_top).offset(-10);
            make.left.mas_equalTo(weakSelf.unsureButton);
        }];
        _clearingMoneyText.font = kFontSize(14);
        _clearingMoneyText.text = @"结算金额";
    }
    return _clearingMoneyText;
}

- (UILabel *)clearingMoneyLabel {
    if (!_clearingMoneyLabel) {
        _clearingMoneyLabel = [[UILabel alloc]init];
        [self.backView addSubview:_clearingMoneyLabel];
        __weak typeof(self) weakSelf = self;
        [_clearingMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.clearingMoneyText);
            make.left.right.mas_equalTo(weakSelf.clearingTypeLabel);
        }];
        _clearingMoneyLabel.font = kFontSize(16);
        _clearingMoneyLabel.textColor = kRedColor;
    }
    return _clearingMoneyLabel;
}

- (UILabel *)telephoneText {
    if (!_telephoneText) {
        _telephoneText = [[UILabel alloc]init];
        [self.backView addSubview:_telephoneText];
        __weak typeof(self) weakSelf = self;
        [_telephoneText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.clearingMoneyText.mas_top).offset(-10);
            make.left.mas_equalTo(weakSelf.unsureButton);
        }];
        _telephoneText.font = kFontSize(14);
        _telephoneText.text = @"电话";
    }
    return _telephoneText;
}

- (UILabel *)telephoneLabel {
    if (!_telephoneLabel) {
        _telephoneLabel = [[UILabel alloc]init];
        [self.backView addSubview:_telephoneLabel];
        __weak typeof(self) weakSelf = self;
        [_telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.telephoneText);
            make.left.right.mas_equalTo(weakSelf.clearingTypeLabel);
        }];
        _telephoneLabel.font = kFontSize(14);
    }
    return _telephoneLabel;
}


- (UILabel *)businessNameText {
    if (!_businessNameText) {
        _businessNameText = [[UILabel alloc]init];
        [self.backView addSubview:_businessNameText];
        __weak typeof(self) weakSelf = self;
        [_businessNameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.bottom.mas_equalTo(weakSelf.telephoneText.mas_top).offset(-10);
            make.left.mas_equalTo(weakSelf.unsureButton);
        }];
        _businessNameText.font = kFontSize(14);
        _businessNameText.text = @"商家";
    }
    return _businessNameText;
}

- (UILabel *)businessNameLabel {
    if (!_businessNameLabel) {
        _businessNameLabel = [[UILabel alloc]init];
        [self.backView addSubview:_businessNameLabel];
        __weak typeof(self) weakSelf = self;
        [_businessNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.businessNameText);
            make.left.right.mas_equalTo(weakSelf.clearingTypeLabel);
        }];
        _businessNameLabel.font = kFontSize(14);
    }
    return _businessNameLabel;
}

@end
