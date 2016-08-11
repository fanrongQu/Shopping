//
//  HomeSeleteButton.m
//  Haidao
//
//  Created by 1860 on 16/7/29.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "HomeSeleteButton.h"

@implementation HomeSeleteButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imageY = 5;
    CGFloat imageWH = contentRect.size.height - 35;
    CGFloat imageX = (contentRect.size.width - imageWH) * 0.5;
    ;
    return CGRectMake(imageX, imageY, imageWH, imageWH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = 20;
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height - titleH - 2;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (instancetype)init {
    if (self = [super init]) {
        self.titleLabel.font = kFontSize(13);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return self;
}

@end
