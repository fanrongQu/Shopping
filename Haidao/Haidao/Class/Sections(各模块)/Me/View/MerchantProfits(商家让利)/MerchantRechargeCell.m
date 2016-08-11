//
//  MerchantRechargeCell.m
//  Haidao
//
//  Created by 1860 on 16/8/2.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MerchantRechargeCell.h"

@interface MerchantRechargeCell ()

/**  流水号  */
@property (nonatomic, strong) UIImageView *serialNumberImg;
@property (nonatomic, strong) UILabel *serialNumberText;
@property (nonatomic, strong) UILabel *serialNumberLabel;
/**  类型 */
@property (nonatomic, strong) UIImageView *typeImg;
@property (nonatomic, strong) UILabel *typeText;
@property (nonatomic, strong) UILabel *typeLabel;
/**  金额  */
@property (nonatomic, strong) UIImageView *moneyImg;
@property (nonatomic, strong) UILabel *moneyText;
@property (nonatomic, strong) UILabel *moneyLabel;
/**  备注  */
@property (nonatomic, strong) UIImageView *remarksImg;
@property (nonatomic, strong) UILabel *remarksText;
@property (nonatomic, strong) UILabel *remarksLabel;
/**  时间  */
@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UILabel *timeText;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation MerchantRechargeCell

+ (MerchantRechargeCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"MerchantRechargeCell";
    MerchantRechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MerchantRechargeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self typeImg];
    }
    return self;
}

- (void)setSerialNumber:(NSString *)serialNumber type:(NSString *)type money:(NSString *)money remarks:(NSString *)remarks time:(NSString *)time {
    self.serialNumberLabel.text = serialNumber;
    self.typeLabel.text = type;
    self.moneyLabel.text = money;
    self.remarksLabel.text = remarks;
    self.timeLabel.text = time;
}

#pragma mark - 懒加载
- (UIImageView *)serialNumberImg {
    if (!_serialNumberImg) {
        _serialNumberImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_serialNumberImg];
        [_serialNumberImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(20);
        }];
        [_serialNumberImg setImage:[UIImage imageNamed:@"流水号"]];
    }
    return _serialNumberImg;
}

- (UILabel *)serialNumberText {
    if (!_serialNumberText) {
        _serialNumberText = [[UILabel alloc]init];
        [self.contentView addSubview:_serialNumberText];
        __weak typeof(self) weakSelf = self;
        [_serialNumberText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.serialNumberImg);
        }];
        _serialNumberText.font = kFontSize(13);
        _serialNumberText.text = @"流水号";
    }
    return _serialNumberText;
}

- (UILabel *)serialNumberLabel {
    if (!_serialNumberLabel) {
        _serialNumberLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_serialNumberLabel];
        __weak typeof(self) weakSelf = self;
        [_serialNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberText.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.serialNumberImg);
        }];
        _serialNumberLabel.font = kFontSize(13);
    }
    return _serialNumberLabel;
}

- (UIImageView *)typeImg {
    if (!_typeImg) {
        _typeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_typeImg];
        __weak typeof(self) weakSelf = self;
        [_typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.typeText.mas_left).offset(-10);
            make.size.mas_equalTo(20);
            make.centerY.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_typeImg setImage:[UIImage imageNamed:@"类型"]];
    }
    return _typeImg;
}

- (UILabel *)typeText {
    if (!_typeText) {
        _typeText = [[UILabel alloc]init];
        [self.contentView addSubview:_typeText];
        __weak typeof(self) weakSelf = self;
        [_typeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.typeLabel.mas_left).offset(-10);
            make.centerY.mas_equalTo(weakSelf.typeImg);
        }];
        _typeText.font = kFontSize(13);
        _typeText.text = @"类型";
    }
    return _typeText;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_typeLabel];
        __weak typeof(self) weakSelf = self;
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(- 15);
            make.centerY.mas_equalTo(weakSelf.typeImg);
        }];
        _typeLabel.font = kFontSize(13);
    }
    return _typeLabel;
}

- (UIImageView *)moneyImg {
    if (!_moneyImg) {
        _moneyImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_moneyImg];
        __weak typeof(self) weakSelf = self;
        [_moneyImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.serialNumberImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_moneyImg setImage:[UIImage imageNamed:@"金额"]];
    }
    return _moneyImg;
}

- (UILabel *)moneyText {
    if (!_moneyText) {
        _moneyText = [[UILabel alloc]init];
        [self.contentView addSubview:_moneyText];
        __weak typeof(self) weakSelf = self;
        [_moneyText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.moneyImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.moneyImg);
        }];
        _moneyText.font = kFontSize(13);
        _moneyText.text = @"金额";
    }
    return _moneyText;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_moneyLabel];
        __weak typeof(self) weakSelf = self;
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.moneyText.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.moneyImg);
        }];
        _moneyLabel.font = kFontSize(13);
        _moneyLabel.textColor = [UIColor redColor];
    }
    return _moneyLabel;
}


- (UIImageView *)timeImg {
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_timeImg];
        __weak typeof(self) weakSelf = self;
        [_timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.moneyImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_timeImg setImage:[UIImage imageNamed:@"时间"]];
    }
    return _timeImg;
}

- (UILabel *)timeText {
    if (!_timeText) {
        _timeText = [[UILabel alloc]init];
        [self.contentView addSubview:_timeText];
        __weak typeof(self) weakSelf = self;
        [_timeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.timeImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.timeImg);
        }];
        _timeText.font = kFontSize(13);
        _timeText.text = @"时间";
    }
    return _timeText;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_timeLabel];
        __weak typeof(self) weakSelf = self;
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.timeText.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.timeImg);
        }];
        _timeLabel.font = kFontSize(13);
    }
    return _timeLabel;
}


- (UIImageView *)remarksImg {
    if (!_remarksImg) {
        _remarksImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_remarksImg];
        __weak typeof(self) weakSelf = self;
        [_remarksImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.timeLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
            make.bottom.mas_equalTo(-15);
        }];
        [_remarksImg setImage:[UIImage imageNamed:@"备注"]];
    }
    return _remarksImg;
}

- (UILabel *)remarksText {
    if (!_remarksText) {
        _remarksText = [[UILabel alloc]init];
        [self.contentView addSubview:_remarksText];
        __weak typeof(self) weakSelf = self;
        [_remarksText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.remarksImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.remarksImg);
        }];
        _remarksText.font = kFontSize(13);
        _remarksText.text = @"备注";
    }
    return _remarksText;
}

- (UILabel *)remarksLabel {
    if (!_remarksLabel) {
        _remarksLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_remarksLabel];
        __weak typeof(self) weakSelf = self;
        [_remarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.remarksText.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.remarksImg);
        }];
        _remarksLabel.font = kFontSize(13);
    }
    return _remarksLabel;
}


@end


