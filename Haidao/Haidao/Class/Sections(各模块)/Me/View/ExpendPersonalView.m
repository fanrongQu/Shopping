//
//  ExpendPersonalView.m
//  Haidao
//
//  Created by 1860 on 16/8/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ExpendPersonalView.h"

@interface ExpendPersonalView ()

/**  赠送积分  */
@property (nonatomic, strong) ExpendButton *presentIntegralBtn;
/**  消费让利  */
@property (nonatomic, strong) ExpendButton *expendProfitsBtn;

/**  分割线  */
@property (nonatomic, strong) UIView *cuttingLineView;

@end

@implementation ExpendPersonalView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setMessage];
        
        //赠送积分
        [self addTouchUpInside:self.presentIntegralBtn expendPersonalViewType:ExpendPersonalViewPresentIntegralType];
        
        //消费让利
        [self addTouchUpInside:self.expendProfitsBtn expendPersonalViewType:ExpendPersonalViewExpendProfitsType];
    }
    return self;
}


/**
 *  为按钮添加点击事件
 *
 *  @param button 点击的按钮
 *  @param type   按钮的类型
 */
- (void)addTouchUpInside:(UIButton *)button expendPersonalViewType:(ExpendPersonalViewType)type {
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([self.delegate respondsToSelector:@selector(clickExpendPersonalViewButtonWithType:)]) {
            [self.delegate clickExpendPersonalViewButtonWithType:type];
        }
    }];
}

- (void)setMessage {
    
    [self.presentIntegralBtn setExpendButtonWithExpendNum:@"10000" expendType:ExpendButtonPresentIntegralType todayExpendNum:@"100.00" totalExpendNum:@"300.00"];
    [self.expendProfitsBtn setExpendButtonWithExpendNum:@"199999" expendType:ExpendButtonExpendProfitsType todayExpendNum:@"109.00" totalExpendNum:@"330.00"];
}

#pragma mark - 懒加载
- (ExpendButton *)presentIntegralBtn {
    if (!_presentIntegralBtn) {
        _presentIntegralBtn = [[ExpendButton alloc]init];
        [self addSubview:_presentIntegralBtn];
        [_presentIntegralBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth / 2);
        }];
    }
    
    UIView *lineView = [[UIView alloc]init];
    [_presentIntegralBtn addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(0.7);
    }];
    lineView.backgroundColor = [UIColor lightGrayColor];
    return _presentIntegralBtn;
}

- (ExpendButton *)expendProfitsBtn {
    if (!_expendProfitsBtn) {
        _expendProfitsBtn = [[ExpendButton alloc]init];
        [self addSubview:_expendProfitsBtn];
        __weak typeof(self) weakSelf = self;
        [_expendProfitsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(weakSelf.presentIntegralBtn.mas_right);
            make.width.mas_equalTo(weakSelf.presentIntegralBtn);
        }];
    }
    return _expendProfitsBtn;
}

- (UIView *)cuttingLineView {
    if (!_cuttingLineView) {
        _cuttingLineView = [[UIView alloc]init];
        [self addSubview:_cuttingLineView];
        __weak typeof(self) weakSelf = self;
        [_cuttingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.presentIntegralBtn.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0.6);
        }];
        _cuttingLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _cuttingLineView;
}

@end
