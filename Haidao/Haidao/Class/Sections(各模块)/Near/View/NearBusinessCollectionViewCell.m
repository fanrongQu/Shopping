//
//  NearBusinessCollectionViewCell.m
//  Haidao
//
//  Created by 1860 on 16/8/11.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "NearBusinessCollectionViewCell.h"

@implementation NearBusinessCollectionViewCell

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        [self addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    return _iconImage;
}

@end
