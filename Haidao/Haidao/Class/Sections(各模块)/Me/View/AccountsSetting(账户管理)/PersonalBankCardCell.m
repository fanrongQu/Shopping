//
//  PersonalBankCardCell.m
//  Haidao
//
//  Created by 1860 on 16/8/19.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "PersonalBankCardCell.h"

@interface PersonalBankCardCell ()

/**  银行logo  */
@property (nonatomic, strong) UIImageView *bankImageView;
/**  名称  */
@property (nonatomic, strong) UILabel *bankNameLabel;
/**  卡号  */
@property (nonatomic, strong) UILabel *bankNumberLabel;
/**  默认  */
@property (nonatomic, strong) UIButton *settingDefaultBtn;
/**  删除  */
@property (nonatomic, strong) UIButton *removeBtn;

@end

@implementation PersonalBankCardCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"PersonalBankCardCell";
    PersonalBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PersonalBankCardCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [[self.settingDefaultBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
        }];
        
        
        [[self.removeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
        }];
        
        
    }
    return self;
}

- (void)setPersonalbankCardIcon:(NSString *)bankIcon bankName:(NSString *)bankName bankNumber:(NSString *)bankNumber {
    self.bankImageView.backgroundColor = [UIColor redColor];
    self.bankNameLabel.text = bankName;
    
    NSString *string = [bankNumber substringFromIndex:bankNumber.length - 4];
    
    self.bankNumberLabel.text = [NSString stringWithFormat:@"**** **** **** %@",string];
}

#pragma mark - 懒加载
- (UIImageView *)bankImageView {
    if (!_bankImageView) {
        _bankImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_bankImageView];
        [_bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(25);
            make.left.mas_offset(15);
            make.bottom.mas_offset(-25);
            make.size.mas_offset(54);
        }];
    }
    return _bankImageView;
}
- (UILabel *)bankNameLabel {
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_bankNameLabel];
        __weak typeof(self) weakSelf = self;
        [_bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.bankImageView);
            make.left.mas_equalTo(weakSelf.bankImageView.mas_right).offset(10);
            make.right.mas_equalTo(-65);
        }];
        
        _bankNameLabel.font = kFontSize(14);
    }
    return _bankNameLabel;
}


- (UILabel *)bankNumberLabel {
    if (!_bankNumberLabel) {
        _bankNumberLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_bankNumberLabel];
        __weak typeof(self) weakSelf = self;
        [_bankNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.bankImageView);
            make.left.right.mas_equalTo(weakSelf.bankNameLabel);
        }];
        
        _bankNumberLabel.font = kFontSize(16);
    }
    return _bankNumberLabel;
}

- (UIButton *)settingDefaultBtn {
    if (!_settingDefaultBtn) {
        _settingDefaultBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_settingDefaultBtn];
        [_settingDefaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        _settingDefaultBtn.titleLabel.font = kFontSize(14);
        [_settingDefaultBtn setTitle:@"设为默认" forState:UIControlStateNormal];
        [_settingDefaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _settingDefaultBtn;
}

- (UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_removeBtn];
        __weak typeof(self) weakSelf = self;
        [_removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.settingDefaultBtn);
            make.bottom.mas_equalTo(-20);
            make.height.mas_equalTo(weakSelf.settingDefaultBtn);
        }];
        
        _removeBtn.titleLabel.font = kFontSize(14);
        [_removeBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_removeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _removeBtn;
}

@end
