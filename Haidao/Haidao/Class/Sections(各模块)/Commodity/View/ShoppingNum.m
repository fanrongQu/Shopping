//
//  ShoppingNum.m
//  Haidao
//
//  Created by 1860 on 16/7/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingNum.h"

@interface ShoppingNum ()

/**  减号  */
@property (nonatomic, strong) UIButton *minusBtn;
/**  加号  */
@property (nonatomic, strong) UIButton *plusBtn;

@end

@implementation ShoppingNum

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self numField];
        [[self.minusBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSInteger number = [self.numField.text integerValue];
            if (number < 2) {//当商品数量少于1时弹出警告
                if ([self.delegate respondsToSelector:@selector(actionMessage:)]) {
                    [self.delegate actionMessage:@"受不了了，宝贝不能再少了"];
                }
            }else {
                self.numField.text = [NSString stringWithFormat:@"%ld",number - 1];
            }
        }];
        
        [[self.plusBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSInteger number = [self.numField.text integerValue];
            self.numField.text = [NSString stringWithFormat:@"%ld",number + 1];
        }];
    }
    return self;
}

- (UIButton *)minusBtn {
    if (!_minusBtn) {
        _minusBtn = [[UIButton alloc]init];
        [self addSubview:_minusBtn];
        [_minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(30);
        }];
        [_minusBtn setImage:[UIImage imageNamed:@"minus_normal"] forState:UIControlStateNormal];
        [_minusBtn setImage:[UIImage imageNamed:@"minus_highlight"] forState:UIControlStateHighlighted];
    }
    return _minusBtn;
}

- (UIButton *)plusBtn {
    if (!_plusBtn) {
        _plusBtn = [[UIButton alloc]init];
        [self addSubview:_plusBtn];
        [_plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(30);
        }];
        [_plusBtn setImage:[UIImage imageNamed:@"plus_normal"] forState:UIControlStateNormal];
        [_plusBtn setImage:[UIImage imageNamed:@"plus_highlight"] forState:UIControlStateHighlighted];
    }
    return _plusBtn;
}

- (UITextField *)numField {
    if (!_numField) {
        _numField = [[UITextField alloc]init];
        [self addSubview:_numField];
        __weak typeof(self) weakSelf = self;
        [_numField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(weakSelf.minusBtn.mas_right);
            make.right.mas_equalTo(weakSelf.plusBtn.mas_left);
        }];
        
        _numField.leftViewMode = UITextFieldViewModeAlways;//一直显示UITextField的leftView
        _numField.keyboardType = UIKeyboardTypeNumberPad;
        _numField.textAlignment = NSTextAlignmentCenter;
        _numField.font = kFontSize(15);
        _numField.text = @"1";
    }
    return _numField;
}

- (void)setShowBorder:(BOOL)showBorder {
    if (showBorder) {
        
        [self.minusBtn.layer setMasksToBounds:YES];
        [self.minusBtn.layer setBorderWidth:1];
        [self.minusBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        
        [self.plusBtn.layer setMasksToBounds:YES];
        [self.plusBtn.layer setBorderWidth:1];
        [self.plusBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:1];
        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
}

@end
