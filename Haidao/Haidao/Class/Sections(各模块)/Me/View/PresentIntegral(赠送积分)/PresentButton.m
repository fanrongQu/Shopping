//
//  PresentButton.m
//  Haidao
//
//  Created by 1860 on 16/8/2.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "PresentButton.h"

@interface PresentButton ()

/**  积分数量  */
@property (nonatomic, strong) UILabel *presentNumLabel;
/**  积分类型  */
@property (nonatomic, strong) UILabel *presentTypeLabel;

@end

@implementation PresentButton


- (void)setPresentNumber:(NSString *)number type:(NSString *)type {
    self.presentNumLabel.text = number;
    self.presentTypeLabel.text = type;
}

- (UILabel *)presentNumLabel {
    if (!_presentNumLabel) {
        _presentNumLabel = [[UILabel alloc]init];
        [self addSubview:_presentNumLabel];
        [_presentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-10);
        }];
        _presentNumLabel.font = kFontSize(14);
    }
    return _presentNumLabel;
}

- (UILabel *)presentTypeLabel {
    if (!_presentTypeLabel) {
        _presentTypeLabel = [[UILabel alloc]init];
        [self addSubview:_presentTypeLabel];
        [_presentTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(10);
        }];
        _presentTypeLabel.font = kFontSize(14);
    }
    return _presentTypeLabel;
}

@end
