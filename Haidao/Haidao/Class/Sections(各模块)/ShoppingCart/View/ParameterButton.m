//
//  ParameterButton.m
//  Haidao
//
//  Created by 1860 on 16/7/28.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#define imageWH 20

#import "ParameterButton.h"

@implementation ParameterButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    contentRect.size.width = contentRect.size.width - imageWH;
    return contentRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    contentRect.origin.x = contentRect.size.width - imageWH;
    contentRect.origin.y = (contentRect.size.height - imageWH) * 0.5;
    contentRect.size = CGSizeMake(imageWH, imageWH);
    return contentRect;
}

@end
