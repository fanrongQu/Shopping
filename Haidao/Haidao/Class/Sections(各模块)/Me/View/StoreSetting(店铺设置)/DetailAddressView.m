//
//  DetailAddressView.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "DetailAddressView.h"

@implementation DetailAddressView

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
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(80);
        }];
        _titleLabel.font = kFontSize(14);
    }
    return _titleLabel;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        [self addSubview:_textView];
        __weak typeof(self) weakSelf = self;
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(6);
            make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-6);
        }];
        _textView.font = kFontSize(14);
    }
    return _textView;
}
@end
