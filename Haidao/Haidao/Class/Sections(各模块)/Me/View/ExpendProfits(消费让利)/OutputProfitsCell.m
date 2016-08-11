//
//  OutputProfitsCell.m
//  Haidao
//
//  Created by 1860 on 16/8/2.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "OutputProfitsCell.h"

@interface OutputProfitsCell ()

/**  订单号  */
@property (nonatomic, strong) UIImageView *serialNumberImg;
@property (nonatomic, strong) UILabel *serialNumberText;
@property (nonatomic, strong) UILabel *serialNumberLabel;
/**  类别  */
@property (nonatomic, strong) UIImageView *typeImg;
@property (nonatomic, strong) UILabel *typeText;
@property (nonatomic, strong) UILabel *typeLabel;
/**  消费者  */
@property (nonatomic, strong) UIImageView *consumerNameImg;
@property (nonatomic, strong) UILabel *consumerNameText;
@property (nonatomic, strong) UILabel *consumerNameLabel;
/**  购买商品  */
@property (nonatomic, strong) UIImageView *commodityImg;
@property (nonatomic, strong) UILabel *commodityText;
@property (nonatomic, strong) UILabel *commodityLabel;
/**  消费金额  */
@property (nonatomic, strong) UIImageView *expendMoneyImg;
@property (nonatomic, strong) UILabel *expendMoneyText;
@property (nonatomic, strong) UILabel *expendMoneyLabel;
/**  让利金额  */
@property (nonatomic, strong) UIImageView *cuttingProfitsImg;
@property (nonatomic, strong) UILabel *cuttingProfitsText;
@property (nonatomic, strong) UILabel *cuttingProfitsLabel;
/**  时间  */
@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UILabel *timeText;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation OutputProfitsCell

+ (OutputProfitsCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"OutputProfitsCell";
    OutputProfitsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OutputProfitsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self typeText];
        [self consumerNameText];
        [self commodityText];
        [self expendMoneyText];
        [self cuttingProfitsText];
        [self timeText];
    }
    return self;
}

- (void)setReceiveListOfSerialNumber:(NSString *)serialNumber type:(NSString *)type consumerName:(NSString *)consumerName commodity:(NSString *)commodity expendMoney:(NSString *)expendMoney cuttingProfits:(NSString *)cuttingProfits time:(NSString *)time{
    self.serialNumberLabel.text = serialNumber;
    self.typeLabel.text = type;
    self.consumerNameLabel.text = consumerName;
    self.commodityLabel.text = commodity;
    self.expendMoneyLabel.text = expendMoney;
    self.cuttingProfitsLabel.text = cuttingProfits;
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
            make.left.mas_equalTo(weakSelf.serialNumberText.mas_right).offset(22);
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
            make.top.mas_equalTo(weakSelf.serialNumberImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
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
            make.left.mas_equalTo(weakSelf.typeImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.typeImg);
        }];
        _typeText.font = kFontSize(13);
        _typeText.text = @"类别";
    }
    return _typeText;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_typeLabel];
        __weak typeof(self) weakSelf = self;
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.typeImg);
        }];
        _typeLabel.font = kFontSize(13);
    }
    return _typeLabel;
}

- (UIImageView *)consumerNameImg {
    if (!_consumerNameImg) {
        _consumerNameImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_consumerNameImg];
        __weak typeof(self) weakSelf = self;
        [_consumerNameImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.typeImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_consumerNameImg setImage:[UIImage imageNamed:@"受赠人"]];
    }
    return _consumerNameImg;
}

- (UILabel *)consumerNameText {
    if (!_consumerNameText) {
        _consumerNameText = [[UILabel alloc]init];
        [self.contentView addSubview:_consumerNameText];
        __weak typeof(self) weakSelf = self;
        [_consumerNameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.consumerNameImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.consumerNameImg);
        }];
        _consumerNameText.font = kFontSize(13);
        _consumerNameText.text = @"消费者";
    }
    return _consumerNameText;
}

- (UILabel *)consumerNameLabel {
    if (!_consumerNameLabel) {
        _consumerNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_consumerNameLabel];
        __weak typeof(self) weakSelf = self;
        [_consumerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.consumerNameImg);
        }];
        _consumerNameLabel.font = kFontSize(13);
    }
    return _consumerNameLabel;
}

- (UIImageView *)commodityImg {
    if (!_commodityImg) {
        _commodityImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_commodityImg];
        __weak typeof(self) weakSelf = self;
        [_commodityImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.consumerNameImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_commodityImg setImage:[UIImage imageNamed:@"购买商品"]];
    }
    return _commodityImg;
}

- (UILabel *)commodityText {
    if (!_commodityText) {
        _commodityText = [[UILabel alloc]init];
        [self.contentView addSubview:_commodityText];
        __weak typeof(self) weakSelf = self;
        [_commodityText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.commodityImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.commodityImg);
        }];
        _commodityText.font = kFontSize(13);
        _commodityText.text = @"购买商品";
    }
    return _commodityText;
}

- (UILabel *)commodityLabel {
    if (!_commodityLabel) {
        _commodityLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_commodityLabel];
        __weak typeof(self) weakSelf = self;
        [_commodityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.commodityImg);
        }];
        _commodityLabel.font = kFontSize(13);
    }
    return _commodityLabel;
}

- (UIImageView *)expendMoneyImg {
    if (!_expendMoneyImg) {
        _expendMoneyImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_expendMoneyImg];
        __weak typeof(self) weakSelf = self;
        [_expendMoneyImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.commodityImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_expendMoneyImg setImage:[UIImage imageNamed:@"消费金额"]];
    }
    return _expendMoneyImg;
}

- (UILabel *)expendMoneyText {
    if (!_expendMoneyText) {
        _expendMoneyText = [[UILabel alloc]init];
        [self.contentView addSubview:_expendMoneyText];
        __weak typeof(self) weakSelf = self;
        [_expendMoneyText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.expendMoneyImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.expendMoneyImg);
        }];
        _expendMoneyText.font = kFontSize(13);
        _expendMoneyText.text = @"消费金额";
    }
    return _expendMoneyText;
}

- (UILabel *)expendMoneyLabel {
    if (!_expendMoneyLabel) {
        _expendMoneyLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_expendMoneyLabel];
        __weak typeof(self) weakSelf = self;
        [_expendMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.expendMoneyImg);
        }];
        _expendMoneyLabel.font = kFontSize(13);
    }
    return _expendMoneyLabel;
}


- (UIImageView *)cuttingProfitsImg {
    if (!_cuttingProfitsImg) {
        _cuttingProfitsImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_cuttingProfitsImg];
        __weak typeof(self) weakSelf = self;
        [_cuttingProfitsImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.expendMoneyImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_cuttingProfitsImg setImage:[UIImage imageNamed:@"让利金额"]];
    }
    return _cuttingProfitsImg;
}

- (UILabel *)cuttingProfitsText {
    if (!_cuttingProfitsText) {
        _cuttingProfitsText = [[UILabel alloc]init];
        [self.contentView addSubview:_cuttingProfitsText];
        __weak typeof(self) weakSelf = self;
        [_cuttingProfitsText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.cuttingProfitsImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.cuttingProfitsImg);
        }];
        _cuttingProfitsText.font = kFontSize(13);
        _cuttingProfitsText.text = @"让利金额";
    }
    return _cuttingProfitsText;
}

- (UILabel *)cuttingProfitsLabel {
    if (!_cuttingProfitsLabel) {
        _cuttingProfitsLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_cuttingProfitsLabel];
        __weak typeof(self) weakSelf = self;
        [_cuttingProfitsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.cuttingProfitsImg);
        }];
        _cuttingProfitsLabel.font = kFontSize(13);
    }
    return _cuttingProfitsLabel;
}


- (UIImageView *)timeImg {
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_timeImg];
        __weak typeof(self) weakSelf = self;
        [_timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.cuttingProfitsImg.mas_bottom).offset(5);
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
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.timeImg);
        }];
        _timeLabel.font = kFontSize(13);
    }
    return _timeLabel;
}



@end
