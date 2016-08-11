//
//  MeCollectionViewCell.m
//  Haidao
//
//  Created by 1860 on 16/8/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MeCollectionViewCell.h"

@interface MeCollectionViewCell ()

/**  图片  */
@property (nonatomic, strong) UIImageView *imageView;
/**  标题  */
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MeCollectionViewCell

- (void)setMeCollectionViewCellWithImageName:(NSString *)imageName title:(NSString *)title {
    self.imageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = title;
}

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(30);
            make.centerX.mas_equalTo(0);
        }];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-15);
        }];
        _titleLabel.font = kFontSize(14);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
