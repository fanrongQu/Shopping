//
//  CommodityCollectionViewCell.m
//  Haidao
//
//  Created by 1860 on 16/7/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "CommodityCollectionViewCell.h"

@interface CommodityCollectionViewCell ()

@property (nonatomic, strong) UIImageView *ADImageView;

@property (nonatomic, strong) UILabel *describeLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation CommodityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self ADImageView];
        [self describeLabel];
        [self priceLabel];
    }
    return self;
}


- (void)setADImage:(NSString *)image ADtitle:(NSString *)title {
    //    [self.ADImageView setImage:[UIImage imageNamed:image]];
    self.describeLabel.text = title;
}

- (UIImageView *)ADImageView {
    if (!_ADImageView) {
        _ADImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_ADImageView];
        [_ADImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(_ADImageView.mas_width).multipliedBy(0.85);
        }];
        _ADImageView.backgroundColor = [UIColor yellowColor];
    }
    return _ADImageView;
}


- (UILabel *)describeLabel {
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.font = kFontSize(14);
        _describeLabel.textColor = [UIColor blackColor];
        _describeLabel.text = @"让你帅到爆的男装,能够出去无限的装逼";
        _describeLabel.numberOfLines = 2;
        [self.contentView addSubview:_describeLabel];
        __weak typeof(self) weakSelf = self;
        [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.ADImageView.mas_bottom);
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(35);
        }];
    }
    return _describeLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = kFontSize(14);
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.text = @"￥100";
        [self.contentView addSubview:_priceLabel];
        __weak typeof(self) weakSelf = self;
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.describeLabel.mas_bottom);
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(30);
        }];
    }
    return _priceLabel;
}

@end
