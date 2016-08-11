//
//  FilterButton.m
//  Haidao
//
//  Created by 1860 on 16/8/3.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FilterButton.h"
#include<objc/runtime.h>

@implementation FilterButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = kFontSize(14);
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:kSubjectColor forState:UIControlStateSelected];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    contentRect.origin.x = 15;
    return contentRect;
}

- (UIImageView *)selectedImage {
    if (!_selectedImage) {
        _selectedImage = [[UIImageView alloc]init];
        [self addSubview:_selectedImage];
        [_selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(25);
            make.centerY.mas_equalTo(0);
        }];
        _selectedImage.backgroundColor = [UIColor redColor];
    }
    return _selectedImage;
}

@end
