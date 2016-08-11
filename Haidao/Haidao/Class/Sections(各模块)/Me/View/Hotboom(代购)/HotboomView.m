//
//  HotboomView.m
//  Haidao
//
//  Created by 1860 on 16/8/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "HotboomView.h"

@implementation HotboomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(80, 40));
            make.centerY.mas_equalTo(0);
        }];
        _titleLabel.font = kFontSize(14);
    }
    return _titleLabel;
}

- (FRTextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[FRTextField alloc]init];
        [self addSubview:_textFiled];
        __weak typeof(self) weakSelf = self;
        [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(35);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _textFiled;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        [self addSubview:_detailLabel];
        __weak typeof(self) weakSelf = self;
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(35);
            make.centerY.mas_equalTo(0);
        }];
        _detailLabel.font = kFontSize(14);
        self.textFiled.hidden = YES;
    }
    return _detailLabel;
}

@end
