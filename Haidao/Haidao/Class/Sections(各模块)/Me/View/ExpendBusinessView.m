//
//  ExpendBusinessView.m
//  Haidao
//
//  Created by 1860 on 16/8/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ExpendBusinessView.h"

@interface ExpendBusinessView ()

/**  赠送积分  */
@property (nonatomic, strong) ExpendButton *presentIntegralBtn;
/**  消费让利  */
@property (nonatomic, strong) ExpendButton *expendProfitsBtn;
/**  商家让利  */
@property (nonatomic, strong) ExpendButton *merchantProfitsBtn;
/**  分割线  */
@property (nonatomic, strong) UIView *cuttingLineView;
/**  商家货款  */
@property (nonatomic, strong) UIButton *businessPayment;
/**  保证金  */
@property (nonatomic, strong) UIButton *refundableMoney;

@end

@implementation ExpendBusinessView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setMessage];
        //赠送积分
        [self addTouchUpInside:self.presentIntegralBtn expendBusinessViewType:ExpendBusinessViewPresentIntegralType];
        
        //消费让利
        [self addTouchUpInside:self.expendProfitsBtn expendBusinessViewType:ExpendBusinessViewExpendProfitsType];
        
        //商家让利
        [self addTouchUpInside:self.merchantProfitsBtn expendBusinessViewType:ExpendBusinessViewMerchantProfitsType];
        
        //商家货款
        [self addTouchUpInside:self.businessPayment expendBusinessViewType:ExpendBusinessViewBusinessPaymentType];
        
        //保证金
        [self addTouchUpInside:self.refundableMoney expendBusinessViewType:ExpendBusinessViewRefundableMoneyType];
    }
    return self;
}

/**
 *  为按钮添加点击事件
 *
 *  @param button 点击的按钮
 *  @param type   按钮的类型
 */
- (void)addTouchUpInside:(UIButton *)button expendBusinessViewType:(ExpendBusinessViewType)type {
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([self.delegate respondsToSelector:@selector(clickExpendBusinessViewButtonWithType:)]) {
            [self.delegate clickExpendBusinessViewButtonWithType:type];
        }
    }];
}

- (void)setMessage {
    
    [self.presentIntegralBtn setExpendButtonWithExpendNum:@"10000" expendType:ExpendButtonPresentIntegralType todayExpendNum:@"100.00" totalExpendNum:@"300.00"];
    [self.expendProfitsBtn setExpendButtonWithExpendNum:@"199999" expendType:ExpendButtonExpendProfitsType todayExpendNum:@"109.00" totalExpendNum:@"330.00"];
    [self.merchantProfitsBtn setExpendButtonWithExpendNum:@"1086" expendType:ExpendButtonMerchantProfitsType todayExpendNum:@"50.00" totalExpendNum:@"500.00"];
}

#pragma mark - 懒加载
- (ExpendButton *)presentIntegralBtn {
    if (!_presentIntegralBtn) {
        _presentIntegralBtn = [[ExpendButton alloc]init];
        [self addSubview:_presentIntegralBtn];
        [_presentIntegralBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth / 3);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        [_presentIntegralBtn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _presentIntegralBtn;
}

- (ExpendButton *)expendProfitsBtn {
    if (!_expendProfitsBtn) {
        _expendProfitsBtn = [[ExpendButton alloc]init];
        [self addSubview:_expendProfitsBtn];
        __weak typeof(self) weakSelf = self;
        [_expendProfitsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(weakSelf.presentIntegralBtn.mas_right);
            make.width.mas_equalTo(weakSelf.presentIntegralBtn);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        [_expendProfitsBtn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _expendProfitsBtn;
}

- (ExpendButton *)merchantProfitsBtn {
    if (!_merchantProfitsBtn) {
        _merchantProfitsBtn = [[ExpendButton alloc]init];
        [self addSubview:_merchantProfitsBtn];
        __weak typeof(self) weakSelf = self;
        [_merchantProfitsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(weakSelf.expendProfitsBtn.mas_right);
            make.width.mas_equalTo(weakSelf.presentIntegralBtn);
        }];
    }
    return _merchantProfitsBtn;
}

- (UIView *)cuttingLineView {
    if (!_cuttingLineView) {
        _cuttingLineView = [[UIView alloc]init];
        [self addSubview:_cuttingLineView];
        __weak typeof(self) weakSelf = self;
        [_cuttingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.presentIntegralBtn);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0.7);
        }];
        _cuttingLineView.backgroundColor = KLineViewColor;
    }
    return _cuttingLineView;
}

- (UIButton *)businessPayment {
    if (!_businessPayment) {
        _businessPayment = [[UIButton alloc]init];
        [self addSubview:_businessPayment];
        __weak typeof(self) weakSelf = self;
        [_businessPayment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.cuttingLineView.mas_bottom);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.5, 60));
            make.bottom.mas_equalTo(0);
        }];
        _businessPayment.titleLabel.font = kFontSize(14);
        [_businessPayment setTitle:@"\t\t商家货款" forState:UIControlStateNormal];
        [_businessPayment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_businessPayment setImage:[UIImage imageNamed:@"商家货款"] forState:UIControlStateNormal];
        UIView *lineView = [[UIView alloc]init];
        [_businessPayment addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _businessPayment;
}

- (UIButton *)refundableMoney {
    if (!_refundableMoney) {
        _refundableMoney = [[UIButton alloc]init];
        [self addSubview:_refundableMoney];
        __weak typeof(self) weakSelf = self;
        [_refundableMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.businessPayment);
            make.left.mas_equalTo(weakSelf.businessPayment.mas_right);
            make.size.mas_equalTo(weakSelf.businessPayment);
        }];
        _refundableMoney.titleLabel.font = kFontSize(14);
        [_refundableMoney setTitle:@"\t\t保证金额" forState:UIControlStateNormal];
        [_refundableMoney setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_refundableMoney setImage:[UIImage imageNamed:@"保证金额"] forState:UIControlStateNormal];
    }
    return _refundableMoney;
}

@end
