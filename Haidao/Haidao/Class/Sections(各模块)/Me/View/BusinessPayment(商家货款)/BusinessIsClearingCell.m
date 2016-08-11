//
//  BusinessIsClearingCell.m
//  Haidao
//
//  Created by 1860 on 16/8/3.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BusinessIsClearingCell.h"


@interface BusinessIsClearingCell ()

/**  订单号  */
@property (nonatomic, strong) UIImageView *serialNumberImg;
@property (nonatomic, strong) UILabel *serialNumberText;
@property (nonatomic, strong) UILabel *serialNumberLabel;
/**  状态  */
@property (nonatomic, strong) UIImageView *statusImg;
@property (nonatomic, strong) UILabel *statusText;
/**  申请金额  */
@property (nonatomic, strong) UIImageView *applyMoneyImg;
@property (nonatomic, strong) UILabel *applyMoneyText;
@property (nonatomic, strong) UILabel *applyMoneyLabel;
/**  结算类型  */
@property (nonatomic, strong) UIImageView *clearingTypeImg;
@property (nonatomic, strong) UILabel *clearingTypeText;
@property (nonatomic, strong) UILabel *clearingTypeLabel;
/**  申请时间  */
@property (nonatomic, strong) UIImageView *applyTimeImg;
@property (nonatomic, strong) UILabel *applyTimeText;
@property (nonatomic, strong) UILabel *applyTimeLabel;
/**  到账银行卡  */
@property (nonatomic, strong) UIImageView *bankCardImg;
@property (nonatomic, strong) UILabel *bankCardText;
@property (nonatomic, strong) UILabel *bankCardLabel;
/**  备注  */
@property (nonatomic, strong) UIImageView *remarkImg;
@property (nonatomic, strong) UILabel *remarkText;
@property (nonatomic, strong) UILabel *remarkLabel;
/**  到账时间  */
@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UILabel *timeText;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation BusinessIsClearingCell

+ (BusinessIsClearingCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BusinessIsClearingCell";
    BusinessIsClearingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BusinessIsClearingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self applyMoneyText];
        [self clearingTypeText];
        [self applyTimeText];
        [self bankCardText];
        [self remarkText];
        [self timeText];
    }
    return self;
}

- (void)setBusinessIsClearingOfSerialNumber:(NSString *)serialNumber applyMoney:(NSString *)applyMoney clearingType:(NSString *)clearingType applyTime:(NSString *)applyTime bankCard:(NSString *)bankCard remark:(NSString *)remark time:(NSString *)time status:(BOOL)status{
    self.serialNumberLabel.text = serialNumber;
    self.applyMoneyLabel.text = applyMoney;
    self.clearingTypeLabel.text = clearingType;
    self.applyTimeLabel.text = applyTime;
    self.bankCardLabel.text = bankCard;
    self.remarkLabel.text = remark;
    self.timeLabel.text = time;
    if (status) {
        [self.statusImg setImage:[UIImage imageNamed:@"已到账"]];
        self.statusText.text = @"已到账";
        self.timeText.text = @"到账时间";
    }else {
        [self.statusImg setImage:[UIImage imageNamed:@"已拒绝"]];
        self.statusText.text = @"已拒绝";
        self.timeText.text = @"拒绝时间";
    }
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
            make.left.mas_equalTo(weakSelf.serialNumberText.mas_right).offset(30);
            make.centerY.mas_equalTo(weakSelf.serialNumberImg);
        }];
        _serialNumberLabel.font = kFontSize(13);
    }
    return _serialNumberLabel;
}

- (UIImageView *)statusImg {
    if (!_statusImg) {
        _statusImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_statusImg];
        __weak typeof(self) weakSelf = self;
        [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.statusText.mas_left).offset(-10);
            make.size.mas_equalTo(20);
            make.centerY.mas_equalTo(weakSelf.serialNumberImg);
        }];
    }
    return _statusImg;
}

- (UILabel *)statusText {
    if (!_statusText) {
        _statusText = [[UILabel alloc]init];
        [self.contentView addSubview:_statusText];
        __weak typeof(self) weakSelf = self;
        [_statusText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(weakSelf.statusImg);
        }];
        _statusText.font = kFontSize(13);
    }
    return _statusText;
}


- (UIImageView *)applyMoneyImg {
    if (!_applyMoneyImg) {
        _applyMoneyImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_applyMoneyImg];
        __weak typeof(self) weakSelf = self;
        [_applyMoneyImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.serialNumberImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_applyMoneyImg setImage:[UIImage imageNamed:@"金额"]];
    }
    return _applyMoneyImg;
}

- (UILabel *)applyMoneyText {
    if (!_applyMoneyText) {
        _applyMoneyText = [[UILabel alloc]init];
        [self.contentView addSubview:_applyMoneyText];
        __weak typeof(self) weakSelf = self;
        [_applyMoneyText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.applyMoneyImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.applyMoneyImg);
        }];
        _applyMoneyText.font = kFontSize(13);
        _applyMoneyText.text = @"申请金额";
    }
    return _applyMoneyText;
}

- (UILabel *)applyMoneyLabel {
    if (!_applyMoneyLabel) {
        _applyMoneyLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_applyMoneyLabel];
        __weak typeof(self) weakSelf = self;
        [_applyMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.applyMoneyImg);
        }];
        _applyMoneyLabel.font = kFontSize(13);
    }
    return _applyMoneyLabel;
}

- (UIImageView *)clearingTypeImg {
    if (!_clearingTypeImg) {
        _clearingTypeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_clearingTypeImg];
        __weak typeof(self) weakSelf = self;
        [_clearingTypeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.applyMoneyImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_clearingTypeImg setImage:[UIImage imageNamed:@"类型"]];
    }
    return _clearingTypeImg;
}

- (UILabel *)clearingTypeText {
    if (!_clearingTypeText) {
        _clearingTypeText = [[UILabel alloc]init];
        [self.contentView addSubview:_clearingTypeText];
        __weak typeof(self) weakSelf = self;
        [_clearingTypeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.clearingTypeImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.clearingTypeImg);
        }];
        _clearingTypeText.font = kFontSize(13);
        _clearingTypeText.text = @"结算类型";
    }
    return _clearingTypeText;
}

- (UILabel *)clearingTypeLabel {
    if (!_clearingTypeLabel) {
        _clearingTypeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_clearingTypeLabel];
        __weak typeof(self) weakSelf = self;
        [_clearingTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.clearingTypeImg);
        }];
        _clearingTypeLabel.font = kFontSize(13);
    }
    return _clearingTypeLabel;
}

- (UIImageView *)applyTimeImg {
    if (!_applyTimeImg) {
        _applyTimeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_applyTimeImg];
        __weak typeof(self) weakSelf = self;
        [_applyTimeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.clearingTypeImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_applyTimeImg setImage:[UIImage imageNamed:@"时间"]];
    }
    return _applyTimeImg;
}

- (UILabel *)applyTimeText {
    if (!_applyTimeText) {
        _applyTimeText = [[UILabel alloc]init];
        [self.contentView addSubview:_applyTimeText];
        __weak typeof(self) weakSelf = self;
        [_applyTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.applyTimeImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.applyTimeImg);
        }];
        _applyTimeText.font = kFontSize(13);
        _applyTimeText.text = @"申请时间";
    }
    return _applyTimeText;
}

- (UILabel *)applyTimeLabel {
    if (!_applyTimeLabel) {
        _applyTimeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_applyTimeLabel];
        __weak typeof(self) weakSelf = self;
        [_applyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.applyTimeImg);
        }];
        _applyTimeLabel.font = kFontSize(13);
    }
    return _applyTimeLabel;
}

- (UIImageView *)bankCardImg {
    if (!_bankCardImg) {
        _bankCardImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_bankCardImg];
        __weak typeof(self) weakSelf = self;
        [_bankCardImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.applyTimeImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_bankCardImg setImage:[UIImage imageNamed:@"到账银行卡"]];
    }
    return _bankCardImg;
}

- (UILabel *)bankCardText {
    if (!_bankCardText) {
        _bankCardText = [[UILabel alloc]init];
        [self.contentView addSubview:_bankCardText];
        __weak typeof(self) weakSelf = self;
        [_bankCardText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bankCardImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.bankCardImg);
        }];
        _bankCardText.font = kFontSize(13);
        _bankCardText.text = @"到账银行卡";
    }
    return _bankCardText;
}

- (UILabel *)bankCardLabel {
    if (!_bankCardLabel) {
        _bankCardLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_bankCardLabel];
        __weak typeof(self) weakSelf = self;
        [_bankCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.bankCardImg);
        }];
        _bankCardLabel.font = kFontSize(13);
    }
    return _bankCardLabel;
}


- (UIImageView *)remarkImg {
    if (!_remarkImg) {
        _remarkImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_remarkImg];
        __weak typeof(self) weakSelf = self;
        [_remarkImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.bankCardImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_remarkImg setImage:[UIImage imageNamed:@"备注"]];
    }
    return _remarkImg;
}

- (UILabel *)remarkText {
    if (!_remarkText) {
        _remarkText = [[UILabel alloc]init];
        [self.contentView addSubview:_remarkText];
        __weak typeof(self) weakSelf = self;
        [_remarkText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.remarkImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.remarkImg);
        }];
        _remarkText.font = kFontSize(13);
        _remarkText.text = @"备注";
    }
    return _remarkText;
}

- (UILabel *)remarkLabel {
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_remarkLabel];
        __weak typeof(self) weakSelf = self;
        [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.remarkImg);
        }];
        _remarkLabel.font = kFontSize(13);
    }
    return _remarkLabel;
}


- (UIImageView *)timeImg {
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_timeImg];
        __weak typeof(self) weakSelf = self;
        [_timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.remarkImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
            make.bottom.mas_equalTo(-15);
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
        _timeText.text = @"到账时间";
    }
    return _timeText;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_timeLabel];
        __weak typeof(self) weakSelf = self;
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.timeImg);
        }];
        _timeLabel.font = kFontSize(13);
    }
    return _timeLabel;
}



@end

