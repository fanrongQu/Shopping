//
//  MakeSureRechargeView.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MakeSureRechargeView.h"

@interface MakeSureRechargeView ()

/**  背景图  */
@property (nonatomic, strong) UIView *backView;
//商家
@property (nonatomic, strong) UILabel *businessNameText;
@property (nonatomic, strong) UILabel *businessNameLabel;
//电话
@property (nonatomic, strong) UILabel *telephoneText;
@property (nonatomic, strong) UILabel *telephoneLabel;
//充值金额
@property (nonatomic, strong) UILabel *rechargeMoneyText;
@property (nonatomic, strong) UILabel *rechargeMoneyLabel;
//获赠积分
@property (nonatomic, strong) UILabel *receiveIntegralText;
@property (nonatomic, strong) UILabel *receiveIntegralLabel;
//确认结算
@property (nonatomic, strong) UILabel *makeSureLabel;
//否认
@property (nonatomic, strong) UIButton *unsureButton;
//是
@property (nonatomic, strong) UIButton *makeSureButton;

@end

@implementation MakeSureRechargeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kUIColor_RGB(200, 200, 200, 0.7);
        [[self.unsureButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([self.delegate respondsToSelector:@selector(makeSureRechargeView:)]) {
                [self.delegate makeSureRechargeView:NO];
            }
        }];
        
        [[self.makeSureButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([self.delegate respondsToSelector:@selector(makeSureRechargeView:)]) {
                [self.delegate makeSureRechargeView:YES];
            }
        }];
    }
    return self;
}

- (void)setMakeSureRechargeViewWithBusinessName:(NSString *)businessName telephone:(NSString *)telephone rechargeMoney:(NSString *)rechargeMoney receiveIntegral:(NSString *)receiveIntegral {
    
    self.businessNameLabel.text = businessName;
    self.telephoneLabel.text = telephone;
    self.rechargeMoneyLabel.text = rechargeMoney;
    self.receiveIntegralLabel.text = receiveIntegral;
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
        _makeSureLabel.text = @"是否确认购买？";
    }
    return _makeSureLabel;
}

- (UILabel *)receiveIntegralText {
    if (!_receiveIntegralText) {
        _receiveIntegralText = [[UILabel alloc]init];
        [self.backView addSubview:_receiveIntegralText];
        __weak typeof(self) weakSelf = self;
        [_receiveIntegralText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.makeSureLabel.mas_top).offset(-15);
            make.left.mas_equalTo(weakSelf.unsureButton);
            make.width.mas_equalTo(60);
        }];
        _receiveIntegralText.font = kFontSize(14);
        _receiveIntegralText.text = @"获赠积分";
    }
    return _receiveIntegralText;
}

- (UILabel *)receiveIntegralLabel {
    if (!_receiveIntegralLabel) {
        _receiveIntegralLabel = [[UILabel alloc]init];
        [self.backView addSubview:_receiveIntegralLabel];
        __weak typeof(self) weakSelf = self;
        [_receiveIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.receiveIntegralText);
            make.left.mas_equalTo(weakSelf.receiveIntegralText.mas_right).offset(10);
            make.right.mas_equalTo(weakSelf.makeSureButton);
        }];
        _receiveIntegralLabel.font = kFontSize(14);
    }
    return _receiveIntegralLabel;
}

- (UILabel *)rechargeMoneyText {
    if (!_rechargeMoneyText) {
        _rechargeMoneyText = [[UILabel alloc]init];
        [self.backView addSubview:_rechargeMoneyText];
        __weak typeof(self) weakSelf = self;
        [_rechargeMoneyText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.receiveIntegralText.mas_top).offset(-10);
            make.left.mas_equalTo(weakSelf.unsureButton);
        }];
        _rechargeMoneyText.font = kFontSize(14);
        _rechargeMoneyText.text = @"充值金额";
    }
    return _rechargeMoneyText;
}

- (UILabel *)rechargeMoneyLabel {
    if (!_rechargeMoneyLabel) {
        _rechargeMoneyLabel = [[UILabel alloc]init];
        [self.backView addSubview:_rechargeMoneyLabel];
        __weak typeof(self) weakSelf = self;
        [_rechargeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.rechargeMoneyText);
            make.left.right.mas_equalTo(weakSelf.receiveIntegralLabel);
        }];
        _rechargeMoneyLabel.font = kFontSize(16);
        _rechargeMoneyLabel.textColor = kRedColor;
    }
    return _rechargeMoneyLabel;
}

- (UILabel *)telephoneText {
    if (!_telephoneText) {
        _telephoneText = [[UILabel alloc]init];
        [self.backView addSubview:_telephoneText];
        __weak typeof(self) weakSelf = self;
        [_telephoneText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.rechargeMoneyText.mas_top).offset(-10);
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
            make.left.right.mas_equalTo(weakSelf.receiveIntegralLabel);
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
            make.left.right.mas_equalTo(weakSelf.receiveIntegralLabel);
        }];
        _businessNameLabel.font = kFontSize(14);
    }
    return _businessNameLabel;
}

@end
