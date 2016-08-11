//
//  SettleAccountsView.m
//  Haidao
//
//  Created by 1860 on 16/8/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "SettleAccountsView.h"

@interface SettleAccountsView ()

@property (nonatomic, strong) UIImageView *accessoryImage;

@end

@implementation SettleAccountsView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self accessoryImage];
    }
    return self;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        [self addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(35);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _iconImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.iconImage.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(75, 40));
            make.centerY.mas_equalTo(0);
        }];
        _titleLabel.font = kFontSize(14);
    }
    return _titleLabel;
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
    }
    return _detailLabel;
}

- (UIImageView *)accessoryImage {
    if (!_accessoryImage) {
        _accessoryImage = [[UIImageView alloc]init];
        [self addSubview:_accessoryImage];
        [_accessoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [_accessoryImage setImage:[UIImage imageNamed:@"导向"]];
    }
    return _accessoryImage;
}

@end
