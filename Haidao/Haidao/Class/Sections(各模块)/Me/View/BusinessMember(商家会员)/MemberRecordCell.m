//
//  MemberRecordCell.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MemberRecordCell.h"
@interface MemberRecordCell ()

/**  手机号码  */
@property (nonatomic, strong) UIImageView *telephoneImg;
@property (nonatomic, strong) UILabel *telephoneText;
@property (nonatomic, strong) UILabel *telephoneLabel;
/**  真实姓名 */
@property (nonatomic, strong) UIImageView *trueNameImg;
@property (nonatomic, strong) UILabel *trueNameText;
@property (nonatomic, strong) UILabel *trueNameLabel;
/**  会员编号  */
@property (nonatomic, strong) UIImageView *memberNumberImg;
@property (nonatomic, strong) UILabel *memberNumberText;
@property (nonatomic, strong) UILabel *memberNumberLabel;
/**  会员等级  */
@property (nonatomic, strong) UIImageView *memberTypeImg;
@property (nonatomic, strong) UILabel *memberTypeText;
@property (nonatomic, strong) UILabel *memberTypeLabel;
/**  注册时间  */
@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UILabel *timeText;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation MemberRecordCell

+ (MemberRecordCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"MemberRecordCell";
    MemberRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MemberRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self trueNameImg];
    }
    return self;
}

- (void)setTelephone:(NSString *)telephone trueName:(NSString *)trueName memberNumber:(NSString *)memberNumber memberType:(NSString *)memberType time:(NSString *)time {
    self.telephoneLabel.text = telephone;
    self.trueNameLabel.text = trueName;
    self.memberNumberLabel.text = memberNumber;
    self.memberTypeLabel.text = memberType;
    self.timeLabel.text = time;
}

#pragma mark - 懒加载
- (UIImageView *)telephoneImg {
    if (!_telephoneImg) {
        _telephoneImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_telephoneImg];
        [_telephoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(20);
        }];
        [_telephoneImg setImage:[UIImage imageNamed:@"手机"]];
    }
    return _telephoneImg;
}

- (UILabel *)telephoneText {
    if (!_telephoneText) {
        _telephoneText = [[UILabel alloc]init];
        [self.contentView addSubview:_telephoneText];
        __weak typeof(self) weakSelf = self;
        [_telephoneText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.telephoneImg.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.telephoneImg);
        }];
        _telephoneText.font = kFontSize(13);
        _telephoneText.text = @"手机号码";
    }
    return _telephoneText;
}

- (UILabel *)telephoneLabel {
    if (!_telephoneLabel) {
        _telephoneLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_telephoneLabel];
        __weak typeof(self) weakSelf = self;
        [_telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.telephoneText.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.telephoneImg);
        }];
        _telephoneLabel.font = kFontSize(13);
        _telephoneLabel.textColor = [UIColor redColor];
    }
    return _telephoneLabel;
}

- (UIImageView *)trueNameImg {
    if (!_trueNameImg) {
        _trueNameImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_trueNameImg];
        __weak typeof(self) weakSelf = self;
        [_trueNameImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.telephoneImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.telephoneImg);
            make.size.mas_equalTo(weakSelf.telephoneImg);
        }];
        [_trueNameImg setImage:[UIImage imageNamed:@"受赠人"]];
    }
    return _trueNameImg;
}

- (UILabel *)trueNameText {
    if (!_trueNameText) {
        _trueNameText = [[UILabel alloc]init];
        [self.contentView addSubview:_trueNameText];
        __weak typeof(self) weakSelf = self;
        [_trueNameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.trueNameImg.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.trueNameImg);
        }];
        _trueNameText.font = kFontSize(13);
        _trueNameText.text = @"真实姓名";
    }
    return _trueNameText;
}

- (UILabel *)trueNameLabel {
    if (!_trueNameLabel) {
        _trueNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_trueNameLabel];
        __weak typeof(self) weakSelf = self;
        [_trueNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.trueNameText.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.trueNameImg);
        }];
        _trueNameLabel.font = kFontSize(13);
    }
    return _trueNameLabel;
}

- (UIImageView *)memberNumberImg {
    if (!_memberNumberImg) {
        _memberNumberImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_memberNumberImg];
        __weak typeof(self) weakSelf = self;
        [_memberNumberImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.trueNameImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.telephoneImg);
            make.size.mas_equalTo(weakSelf.telephoneImg);
        }];
        [_memberNumberImg setImage:[UIImage imageNamed:@"编号"]];
    }
    return _memberNumberImg;
}

- (UILabel *)memberNumberText {
    if (!_memberNumberText) {
        _memberNumberText = [[UILabel alloc]init];
        [self.contentView addSubview:_memberNumberText];
        __weak typeof(self) weakSelf = self;
        [_memberNumberText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.memberNumberImg.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.memberNumberImg);
        }];
        _memberNumberText.font = kFontSize(13);
        _memberNumberText.text = @"会员编号";
    }
    return _memberNumberText;
}

- (UILabel *)memberNumberLabel {
    if (!_memberNumberLabel) {
        _memberNumberLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_memberNumberLabel];
        __weak typeof(self) weakSelf = self;
        [_memberNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.memberNumberText.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.memberNumberImg);
        }];
        _memberNumberLabel.font = kFontSize(13);
    }
    return _memberNumberLabel;
}


- (UIImageView *)memberTypeImg {
    if (!_memberTypeImg) {
        _memberTypeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_memberTypeImg];
        __weak typeof(self) weakSelf = self;
        [_memberTypeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.memberNumberImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.telephoneImg);
            make.size.mas_equalTo(weakSelf.telephoneImg);
        }];
        [_memberTypeImg setImage:[UIImage imageNamed:@"等级"]];
    }
    return _memberTypeImg;
}

- (UILabel *)memberTypeText {
    if (!_memberTypeText) {
        _memberTypeText = [[UILabel alloc]init];
        [self.contentView addSubview:_memberTypeText];
        __weak typeof(self) weakSelf = self;
        [_memberTypeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.memberTypeImg.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.memberTypeImg);
        }];
        _memberTypeText.font = kFontSize(13);
        _memberTypeText.text = @"会员等级";
    }
    return _memberTypeText;
}

- (UILabel *)memberTypeLabel {
    if (!_memberTypeLabel) {
        _memberTypeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_memberTypeLabel];
        __weak typeof(self) weakSelf = self;
        [_memberTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.memberTypeText.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.memberTypeImg);
        }];
        _memberTypeLabel.font = kFontSize(13);
    }
    return _memberTypeLabel;
}


- (UIImageView *)timeImg {
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_timeImg];
        __weak typeof(self) weakSelf = self;
        [_timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.memberTypeImg.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.telephoneImg);
            make.size.mas_equalTo(weakSelf.telephoneImg);
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
            make.left.mas_equalTo(weakSelf.timeImg.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.timeImg);
        }];
        _timeText.font = kFontSize(13);
        _timeText.text = @"注册时间";
    }
    return _timeText;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_timeLabel];
        __weak typeof(self) weakSelf = self;
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.timeText.mas_right).offset(15);
            make.centerY.mas_equalTo(weakSelf.timeImg);
        }];
        _timeLabel.font = kFontSize(13);
    }
    return _timeLabel;
}

@end

