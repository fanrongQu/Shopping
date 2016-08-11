//
//  ShoppingCartButton.m
//  Haidao
//
//  Created by 1860 on 16/7/12.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingCartButton.h"

@implementation ShoppingCartButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imageY = 5;
    CGFloat imageWH = contentRect.size.height - 28;
    CGFloat imageX = (contentRect.size.width - imageWH) * 0.5;
    ;
    return CGRectMake(imageX, imageY, imageWH, imageWH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = 20;
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height - titleH - 3;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (instancetype)init {
    if (self = [super init]) {
        UILabel *alertLabel = [[UILabel alloc]init];
        [self addSubview:alertLabel];
        [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(20, 14));
        }];
        alertLabel.backgroundColor = kSubjectColor;
        [alertLabel.layer setMasksToBounds:YES];
        [alertLabel.layer setCornerRadius:7.0];
        alertLabel.font = kFontSize(12);
        alertLabel.textColor = [UIColor whiteColor];
        alertLabel.textAlignment = NSTextAlignmentCenter;
        alertLabel.hidden = YES;
        self.alertLabel = alertLabel;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return self;
}

@end
