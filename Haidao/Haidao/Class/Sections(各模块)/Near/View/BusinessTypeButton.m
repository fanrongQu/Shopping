//
//  BusinessTypeButton.m
//  Haidao
//
//  Created by 1860 on 16/8/11.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BusinessTypeButton.h"

@implementation BusinessTypeButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = kFontSize(12);
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat x = 0;
    CGFloat y = contentRect.size.height - 12;
    CGFloat width = contentRect.size.width;
    CGFloat height = 12;
    CGRect frame = CGRectMake(x, y, width, height);
    return frame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height - 20;
    CGRect frame = CGRectMake(x, y, width, height);
    return frame;
}


@end
