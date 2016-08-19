//
//  ShoppingOrderOnlineCell.m
//  Haidao
//
//  Created by 1860 on 16/7/26.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#define otherColor kUIColor_RGB(85, 85, 85, 1)

#import "ShoppingOrderOnlineCell.h"

@interface ShoppingOrderOnlineCell ()

/**  图片  */
@property (nonatomic, strong) UIImageView *iconView;
/**  名称  */
@property (nonatomic, strong) UILabel *nameLabel;
/**  颜色  */
@property (nonatomic, strong) UILabel *colorLabel;
/**  尺寸  */
@property (nonatomic, strong) UILabel *sizeLabel;
/**  价格  */
@property (nonatomic, strong) UILabel *priceLabel;
/**  市场价  */
@property (nonatomic, strong) UILabel *oldPriceLabel;
/**  数量  */
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation ShoppingOrderOnlineCell

+ (ShoppingOrderOnlineCell *)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"ShoppingOrderOnlineCell";
    ShoppingOrderOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ShoppingOrderOnlineCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (void)setCommodityImage:(NSString *)imageString name:(NSString *)commodityName color:(NSString *)color size:(NSString *)size price:(NSString *)price oldPrice:(NSString *)oldPrice num:(NSString *)num {
    
    self.nameLabel.text = commodityName;
    
    self.colorLabel.text = [NSString stringWithFormat:@"颜色分类：%@",color];
    
    self.sizeLabel.text = [NSString stringWithFormat:@"尺码：%@",size];
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
    //为以前价格添加删除线
    oldPrice = [NSString stringWithFormat:@" ￥%@ ",oldPrice];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:otherColor range:NSMakeRange(0, length)];
    [self.oldPriceLabel setAttributedText:attri];
    
    self.numLabel.text = [NSString stringWithFormat:@"×%@",num];
}

#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(70);
        }];
        _iconView.backgroundColor = [UIColor redColor];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = kFontSize(14);
        _nameLabel.numberOfLines = 2;
        
        [self.contentView addSubview:_nameLabel];
        __weak typeof(self) weakSelf = self;
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.iconView);
            make.left.mas_equalTo(weakSelf.iconView.mas_right).with.offset(10);
            make.right.mas_equalTo(-65);
        }];
    }
    return _nameLabel;
}

- (UILabel *)colorLabel {
    if (!_colorLabel) {
        _colorLabel = [[UILabel alloc]init];
        _colorLabel.textColor = otherColor;
        _colorLabel.font = kFontSize(13);
        
        [self.contentView addSubview:_colorLabel];
        __weak typeof(self) weakSelf = self;
        [_colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(weakSelf.nameLabel);
        }];
    }
    return _colorLabel;
}

- (UILabel *)sizeLabel {
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc]init];
        _sizeLabel.textColor = otherColor;
        _sizeLabel.font = kFontSize(13);
        
        [self.contentView addSubview:_sizeLabel];
        __weak typeof(self) weakSelf = self;
        [_sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.colorLabel);
            make.left.mas_equalTo(weakSelf.colorLabel.mas_right).with.offset(20);
        }];
    }
    return _sizeLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = kUIColor_RGB(0, 132, 134, 1);
        _priceLabel.font = kFontSize(15);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_priceLabel];
        __weak typeof(self) weakSelf = self;
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel);
            make.right.mas_equalTo(-10);
        }];
    }
    return _priceLabel;
}

- (UILabel *)oldPriceLabel {
    if (!_oldPriceLabel) {
        _oldPriceLabel = [[UILabel alloc]init];
        _oldPriceLabel.textColor = otherColor;
        _oldPriceLabel.font = kFontSize(12);
        _oldPriceLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_oldPriceLabel];
        __weak typeof(self) weakSelf = self;
        [_oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.priceLabel.mas_bottom).offset(5);
            make.right.mas_equalTo(-10);
        }];
    }
    return _oldPriceLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.textColor = otherColor;
        _numLabel.font = kFontSize(13);
        
        [self.contentView addSubview:_numLabel];
        __weak typeof(self) weakSelf = self;
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(weakSelf.iconView);
        }];
    }
    return _numLabel;
}

@end
