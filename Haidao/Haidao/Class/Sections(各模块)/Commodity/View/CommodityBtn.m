//
//  CommodityBtn.m
//  Haidao
//
//  Created by 1860 on 16/7/17.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "CommodityBtn.h"

@implementation CommodityBtn

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = 20;
    CGFloat titleX = 0;
    CGFloat titleY = 5;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    return self;
}

- (UILabel *)describeLabel {
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        [self addSubview:_describeLabel];
        [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-3);
        }];
        _describeLabel.font = kFontSize(14);
        _describeLabel.textColor = labelColor;
        _describeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _describeLabel;
}

@end
