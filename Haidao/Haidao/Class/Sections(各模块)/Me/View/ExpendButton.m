//
//  ExpendButton.m
//  Haidao
//
//  Created by 1860 on 16/8/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ExpendButton.h"

@interface ExpendButton ()

/**  消费总额  */
@property (nonatomic, strong) UILabel *expendNumLabel;
/**  消费类型图片  */
@property (nonatomic, strong) UIImageView *expendTypeImage;
/**  消费类型  */
@property (nonatomic, strong) UILabel *expendTypeLabel;
/**  今日  */
@property (nonatomic, strong) UILabel *todayText;
/**  今日消费额  */
@property (nonatomic, strong) UILabel *todayExpendNum;
/**  累计  */
@property (nonatomic, strong) UILabel *totalText;
/**  累计金额  */
@property (nonatomic, strong) UILabel *totalExpendNum;

@end

@implementation ExpendButton


- (void)setExpendButtonWithExpendNum:(NSString *)expendNum expendType:(ExpendButtonType)expendButtonType todayExpendNum:(NSString *)todayExpendNum totalExpendNum:(NSString *)totalExpendNum {
    self.expendNumLabel.text = expendNum;
    self.todayExpendNum.text = todayExpendNum;
    self.totalExpendNum.text = totalExpendNum;
    switch (expendButtonType) {
        case ExpendButtonPresentIntegralType://赠送积分
            self.expendTypeImage.image = [UIImage imageNamed:@"赠送积分"];
            self.expendTypeLabel.text = @"赠送积分";
            self.todayText.text = @"今日";
            self.totalText.text = @"累计";
            break;
            
        case ExpendButtonExpendProfitsType://消费让利
            self.expendTypeImage.image = [UIImage imageNamed:@"消费让利额"];
            self.expendTypeLabel.text = @"消费让利额";
            break;
            
        case ExpendButtonMerchantProfitsType://商家让利
            self.expendTypeImage.image = [UIImage imageNamed:@"商家让利额"];
            self.expendTypeLabel.text = @"商家让利额";
            break;
            
        default:
            break;
    }
    
}

#pragma mark - 懒加载
- (UILabel *)expendNumLabel {
    if (!_expendNumLabel) {
        _expendNumLabel = [[UILabel alloc]init];
        [self addSubview:_expendNumLabel];
        [_expendNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(20);
        }];
        _expendNumLabel.font = kFontSize(16);
        
    }
    return _expendNumLabel;
}

- (UIImageView *)expendTypeImage {
    if (!_expendTypeImage) {
        _expendTypeImage = [[UIImageView alloc]init];
        [self addSubview:_expendTypeImage];
        __weak typeof(self) weakSelf = self;
        [_expendTypeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.expendNumLabel.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.mas_equalTo(weakSelf.expendTypeLabel.mas_left).offset(-4);
        }];
    }
    return _expendTypeImage;
}

- (UILabel *)expendTypeLabel {
    if (!_expendTypeLabel) {
        _expendTypeLabel = [[UILabel alloc]init];
        [self addSubview:_expendTypeLabel];
        __weak typeof(self) weakSelf = self;
        [_expendTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.expendTypeImage);
            make.centerX.mas_equalTo(12);
        }];
        _expendTypeLabel.font = kFontSize(14);
    }
    return _expendTypeLabel;
}

- (UILabel *)todayText {
    if (!_todayText) {
        _todayText = [[UILabel alloc]init];
        [self addSubview:_todayText];
        __weak typeof(self) weakSelf = self;
        [_todayText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.expendTypeImage).offset(-6);
            make.top.mas_equalTo(weakSelf.expendTypeImage.mas_bottom).offset(6);
        }];
        _todayText.font = kFontSize(13);
        _todayText.text = @"积分权";
    }
    return _todayText;
}

- (UILabel *)todayExpendNum {
    if (!_todayExpendNum) {
        _todayExpendNum = [[UILabel alloc]init];
        [self addSubview:_todayExpendNum];
        __weak typeof(self) weakSelf = self;
        [_todayExpendNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.todayText.mas_right).offset(10);
            make.top.mas_equalTo(weakSelf.todayText);
        }];
        _todayExpendNum.font = kFontSize(13);
    }
    return _todayExpendNum;
}

- (UILabel *)totalText {
    if (!_totalText) {
        _totalText = [[UILabel alloc]init];
        [self addSubview:_totalText];
        __weak typeof(self) weakSelf = self;
        [_totalText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.todayText);
            make.top.mas_equalTo(weakSelf.todayText.mas_bottom).offset(3);
            make.bottom.mas_equalTo(-15);
        }];
        _totalText.font = kFontSize(13);
        _totalText.text = @"总让利";
    }
    return _totalText;
}

- (UILabel *)totalExpendNum {
    if (!_totalExpendNum) {
        _totalExpendNum = [[UILabel alloc]init];
        [self addSubview:_totalExpendNum];
        __weak typeof(self) weakSelf = self;
        [_totalExpendNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.totalText.mas_right).offset(10);
            make.top.mas_equalTo(weakSelf.totalText);
        }];
        _totalExpendNum.font = kFontSize(13);
    }
    return _totalExpendNum;
}

@end
