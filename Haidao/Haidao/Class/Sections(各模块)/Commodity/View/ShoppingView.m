//
//  ShoppingView.m
//  Haidao
//
//  Created by 1860 on 16/7/12.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingView.h"

@interface ShoppingView ()

/**  白色背景  */
@property (nonatomic, strong) UIView *backView;
/**  商品图  */
@property (nonatomic, strong) UIImageView *shoppingIcon;
/**  名称  */
@property (nonatomic, strong) UILabel *commodityName;
/**  价格  */
@property (nonatomic, strong) UILabel *priceLabel;
/**  取消按钮  */
@property (nonatomic, strong) UIButton *cancleBtn;
/**  数量label  */
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation ShoppingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kUIColor_RGB(100, 100, 100, 0.6);
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    [self backView];
    [self shoppingIcon];
    [self priceLabel];
    [self shoppingNum];
    
    [[self.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"取消");
        [self hiddenSelfView];
    }];
    
    [[self.makeSureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self hiddenSelfView];
        if ([_delegate respondsToSelector:@selector(selectSize: color: number:)]) {
            [_delegate selectSize:nil color:nil number:self.shoppingNum.numField.text];
        }

    }];
}

/**
 *  隐藏当前视图
 */
- (void)hiddenSelfView {
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.backgroundColor = kUIColor_RGB(100, 100, 100, 0.0);
        [weakSelf mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kScreenHeight);
        }];
        [weakSelf.superview layoutIfNeeded];//masonry动画必须实现layoutIfNeeded
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 懒加载
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(400);
        }];
    }
    return _backView;
}

- (UIImageView *)shoppingIcon {
    if (!_shoppingIcon) {
        _shoppingIcon = [[UIImageView alloc]init];
        [self.backView addSubview:_shoppingIcon];
        [_shoppingIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(80);
        }];
        
        [_shoppingIcon.layer setMasksToBounds:YES];
        [_shoppingIcon.layer setCornerRadius:5.0];
        _shoppingIcon.backgroundColor = [UIColor redColor];
    }
    return _shoppingIcon;
}

- (UILabel *)commodityName {
    if (!_commodityName) {
        _commodityName = [[UILabel alloc]init];
        [self.backView addSubview:_commodityName];
        __weak typeof(self) weakSelf = self;
        [_commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.shoppingIcon);
            make.left.mas_equalTo(weakSelf.shoppingIcon.mas_right).offset(15);
            make.right.mas_equalTo(-50);
        }];
        _commodityName.font = kFontSize(14);
        _commodityName.numberOfLines = 2;
        _commodityName.text = @"2016年韩版新时尚女装优雅外套裙韩版新时尚女装优雅外套裙";
    }
    return _commodityName;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        [self.backView addSubview:_priceLabel];
        __weak typeof(self) weakSelf = self;
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.commodityName.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.commodityName);
        }];
        _priceLabel.font = kFontSize(14);
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.text = @"￥89.00";
    }
    return _priceLabel;
}


- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc]init];
        [self.backView addSubview:_cancleBtn];
        [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(20);
        }];
        
        [_cancleBtn.layer setMasksToBounds:YES];
        [_cancleBtn.layer setCornerRadius:12];
        [_cancleBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    return _cancleBtn;
}

- (UIButton *)makeSureBtn {
    if (!_makeSureBtn) {
        _makeSureBtn = [[UIButton alloc]init];
        [self.backView addSubview:_makeSureBtn];
        [_makeSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-20);
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(90, 36));
        }];
        _makeSureBtn.backgroundColor = kSubjectColor;
        _makeSureBtn.titleLabel.font = kFontSize(16);
        [_makeSureBtn setTitle:@"确认" forState:UIControlStateNormal];
    }
    return _makeSureBtn;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        [self.backView addSubview:_numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-90);
        }];
        _numLabel.font = kFontSize(14);
        _numLabel.text = @"数量";
    }
    return _numLabel;
}

- (ShoppingNum *)shoppingNum {
    if (!_shoppingNum) {
        _shoppingNum = [[ShoppingNum alloc]init];
        [self.backView addSubview:_shoppingNum];
        __weak typeof(self) weakSelf = self;
        [_shoppingNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.numLabel.mas_right).with.offset(20);
            make.centerY.mas_equalTo(weakSelf.numLabel);
            make.size.mas_equalTo(CGSizeMake(105, 30));
        }];
        _shoppingNum.showBorder = YES;
    }
    return _shoppingNum;
}

@end
