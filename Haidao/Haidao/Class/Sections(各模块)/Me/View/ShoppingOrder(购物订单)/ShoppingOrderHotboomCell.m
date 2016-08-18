//
//  ShoppingOrderHotboomCell.m
//  Haidao
//
//  Created by 1860 on 16/8/13.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingOrderHotboomCell.h"

@interface ShoppingOrderHotboomCell ()

/**  订单号  */
@property (nonatomic, strong) UIImageView *serialNumberImg;
@property (nonatomic, strong) UILabel *serialNumberText;
@property (nonatomic, strong) UILabel *serialNumberLabel;
/**  代购网站  */
@property (nonatomic, strong) UIImageView *websiteImg;
@property (nonatomic, strong) UILabel *websiteText;
@property (nonatomic, strong) UILabel *websiteLabel;
/**  购买商品  */
@property (nonatomic, strong) UIImageView *commodityImg;
@property (nonatomic, strong) UILabel *commodityText;
@property (nonatomic, strong) UILabel *commodityLabel;
/**  消费金额  */
@property (nonatomic, strong) UIImageView *expendMoneyImg;
@property (nonatomic, strong) UILabel *expendMoneyText;
@property (nonatomic, strong) UILabel *expendMoneyLabel;
/**  数量  */
@property (nonatomic, strong) UIImageView *numberImg;
@property (nonatomic, strong) UILabel *numberText;
@property (nonatomic, strong) UILabel *numberLabel;
/**  产品属性  */
@property (nonatomic, strong) UIImageView *attributeImg;
@property (nonatomic, strong) UILabel *attributeText;
@property (nonatomic, strong) UILabel *attributeLabel;
/**  状态  */
@property (nonatomic, strong) UIImageView *stateImg;
@property (nonatomic, strong) UILabel *stateText;
@property (nonatomic, strong) UILabel *stateLabel;
/**  时间  */
@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UILabel *timeText;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ShoppingOrderHotboomCell

+ (ShoppingOrderHotboomCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"ShoppingOrderHotboomCell";
    ShoppingOrderHotboomCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ShoppingOrderHotboomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self serialNumberText];
        [self websiteText];
        [self commodityText];
        [self expendMoneyText];
        [self numberText];
        [self attributeText];
        [self stateText];
        [self timeText];
    }
    return self;
}

- (void)setReceiveListOfSerialNumber:(NSString *)serialNumber website:(NSString *)website telphone:(NSString *)telphone commodity:(NSString *)commodity expendMoney:(NSString *)expendMoney number:(NSString *)number attribute:(NSString *)attribute state:(NSString *)state time:(NSString *)time {
    self.serialNumberLabel.text = serialNumber;
    self.websiteLabel.text = website;
    self.commodityLabel.text = commodity;
    self.expendMoneyLabel.text = expendMoney;
    self.numberLabel.text = number;
    self.attributeLabel.text = attribute;
    self.stateLabel.text = state;
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
        _serialNumberText.text = @"订单号";
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

- (UIImageView *)websiteImg {
    if (!_websiteImg) {
        _websiteImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_websiteImg];
        __weak typeof(self) weakSelf = self;
        [_websiteImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.serialNumberImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_websiteImg setImage:[UIImage imageNamed:@"代购网站"]];
    }
    return _websiteImg;
}

- (UILabel *)websiteText {
    if (!_websiteText) {
        _websiteText = [[UILabel alloc]init];
        [self.contentView addSubview:_websiteText];
        __weak typeof(self) weakSelf = self;
        [_websiteText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.websiteImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.websiteImg);
        }];
        _websiteText.font = kFontSize(13);
        _websiteText.text = @"代购网站";
    }
    return _websiteText;
}

- (UILabel *)websiteLabel {
    if (!_websiteLabel) {
        _websiteLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_websiteLabel];
        __weak typeof(self) weakSelf = self;
        [_websiteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.websiteImg);
        }];
        _websiteLabel.font = kFontSize(13);
    }
    return _websiteLabel;
}


- (UIImageView *)commodityImg {
    if (!_commodityImg) {
        _commodityImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_commodityImg];
        __weak typeof(self) weakSelf = self;
        [_commodityImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.websiteImg.mas_bottom).offset(5);
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


- (UIImageView *)numberImg {
    if (!_numberImg) {
        _numberImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_numberImg];
        __weak typeof(self) weakSelf = self;
        [_numberImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.expendMoneyImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_numberImg setImage:[UIImage imageNamed:@"数量"]];
    }
    return _numberImg;
}

- (UILabel *)numberText {
    if (!_numberText) {
        _numberText = [[UILabel alloc]init];
        [self.contentView addSubview:_numberText];
        __weak typeof(self) weakSelf = self;
        [_numberText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.numberImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.numberImg);
        }];
        _numberText.font = kFontSize(13);
        _numberText.text = @"数量";
    }
    return _numberText;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_numberLabel];
        __weak typeof(self) weakSelf = self;
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.numberImg);
        }];
        _numberLabel.font = kFontSize(13);
    }
    return _numberLabel;
}



- (UIImageView *)attributeImg {
    if (!_attributeImg) {
        _attributeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_attributeImg];
        __weak typeof(self) weakSelf = self;
        [_attributeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.numberImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_attributeImg setImage:[UIImage imageNamed:@"产品属性"]];
    }
    return _attributeImg;
}

- (UILabel *)attributeText {
    if (!_attributeText) {
        _attributeText = [[UILabel alloc]init];
        [self.contentView addSubview:_attributeText];
        __weak typeof(self) weakSelf = self;
        [_attributeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.attributeImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.attributeImg);
        }];
        _attributeText.font = kFontSize(13);
        _attributeText.text = @"产品属性";
    }
    return _attributeText;
}

- (UILabel *)attributeLabel {
    if (!_attributeLabel) {
        _attributeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_attributeLabel];
        __weak typeof(self) weakSelf = self;
        [_attributeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.attributeImg);
        }];
        _attributeLabel.font = kFontSize(13);
    }
    return _attributeLabel;
}



- (UIImageView *)stateImg {
    if (!_stateImg) {
        _stateImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_stateImg];
        __weak typeof(self) weakSelf = self;
        [_stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.attributeImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.serialNumberImg);
            make.size.mas_equalTo(weakSelf.serialNumberImg);
        }];
        [_stateImg setImage:[UIImage imageNamed:@"状态"]];
    }
    return _stateImg;
}

- (UILabel *)stateText {
    if (!_stateText) {
        _stateText = [[UILabel alloc]init];
        [self.contentView addSubview:_stateText];
        __weak typeof(self) weakSelf = self;
        [_stateText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.stateImg.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.stateImg);
        }];
        _stateText.font = kFontSize(13);
        _stateText.text = @"状态";
    }
    return _stateText;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_stateLabel];
        __weak typeof(self) weakSelf = self;
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serialNumberLabel);
            make.centerY.mas_equalTo(weakSelf.stateImg);
        }];
        _stateLabel.font = kFontSize(13);
    }
    return _stateLabel;
}


- (UIImageView *)timeImg {
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_timeImg];
        __weak typeof(self) weakSelf = self;
        [_timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.stateImg.mas_bottom).offset(5);
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
        _timeText.text = @"订单时间";
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
