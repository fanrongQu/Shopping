//
//  PersonalTopView.m
//  Haidao
//
//  Created by 1860 on 16/7/17.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "PersonalTopView.h"

@interface PersonalTopView ()

/**  背景视图  */
@property (nonatomic, strong) UIImageView *backImageView;
/**  头像  */
@property (nonatomic, strong) UIButton *iconBtn;
/**  用户名  */
@property (nonatomic, strong) UIButton *nameButton;
/**  等级  */
@property (nonatomic, strong) UIButton *gradeButton;
/**  经验值  */
@property (nonatomic, strong) UIButton *empiricalValueButton;
/**  设置按钮  */
@property (nonatomic, strong) UIButton *settingBtn;

@end

@implementation PersonalTopView


/**
 *  设置数值
 */
- (void)setPersonalIcon:(NSString *)iconImage name:(NSString *)name gradeType:(NSString *)gradeType empiricalValue:(NSString *)empiricalValue {
    [self.iconBtn setImage:[UIImage imageNamed:iconImage] forState:UIControlStateNormal];
    [self.nameButton setTitle:name forState:UIControlStateNormal];
    if ([gradeType isEqualToString:@"注册会员"]) {
        [self.gradeButton setTitle:@"注册会员 " forState:UIControlStateNormal];
        [self.gradeButton setImage:[UIImage imageNamed:@"会员"] forState:UIControlStateNormal];
        [self.gradeButton setImage:[UIImage imageNamed:@"会员"] forState:UIControlStateHighlighted];
    }else {
        [self.gradeButton setTitle:@"商家 " forState:UIControlStateNormal];
        [self.gradeButton setImage:[UIImage imageNamed:@"商家"] forState:UIControlStateNormal];
        [self.gradeButton setImage:[UIImage imageNamed:@"商家"] forState:UIControlStateHighlighted];
    }
    
    [self.empiricalValueButton setTitle:[NSString stringWithFormat:@"经验值\t%@ ",empiricalValue] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.iconBtn.backgroundColor = [UIColor yellowColor];
        
        [self addTouchUpInside:self.iconBtn Type:PersonalTopViewIconType];
        [self addTouchUpInside:self.nameButton Type:PersonalTopViewIconType];
        [self addTouchUpInside:self.gradeButton Type:PersonalTopViewGradeType];
        [self addTouchUpInside:self.empiricalValueButton Type:PersonalTopViewEmpiricalType];
        [self addTouchUpInside:self.settingBtn Type:PersonalTopViewSettingType];
        
    }
    return self;
}

- (void)addTouchUpInside:(UIButton *)button Type:(PersonalTopViewType)type {
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([self.delegate respondsToSelector:@selector(personalTopViewClickButtonWithType:)]) {
            [self.delegate personalTopViewClickButtonWithType:type];
        }
    }];
}

#pragma mark - 懒加载
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        [self addSubview:_backImageView];
        
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(kScreenWidth * 110 / 320);
        }];
        [_backImageView setImage:[UIImage imageNamed:@"背景"]];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc]init];
        [self.backImageView addSubview:_iconBtn];
        __weak typeof(self) weakSelf = self;
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.backImageView).offset(10);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(60);
        }];
        [_iconBtn.layer setMasksToBounds:YES];
        [_iconBtn.layer setCornerRadius:30];
        [_iconBtn.layer setBorderWidth:2];
        [_iconBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    return _iconBtn;
}

- (UIButton *)nameButton {
    if (!_nameButton) {
        _nameButton = [[UIButton alloc]init];
        [self.backImageView addSubview:_nameButton];
        __weak typeof(self) weakSelf = self;
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.iconBtn);
            make.left.mas_equalTo(weakSelf.iconBtn.mas_right).offset(10);
            make.height.mas_equalTo(35);
        }];
        _nameButton.titleLabel.font = kFontSize(15);
        [_nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _nameButton;
}

- (UIButton *)gradeButton {
    if (!_gradeButton) {
        _gradeButton = [[UIButton alloc]init];
        [self.backImageView addSubview:_gradeButton];
        __weak typeof(self) weakSelf = self;
        [_gradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.iconBtn);
            make.left.mas_equalTo(weakSelf.nameButton);
            make.height.mas_equalTo(18);
        }];
        _gradeButton.titleLabel.font = kFontSize(12);
        _gradeButton.titleLabel.textColor = [UIColor whiteColor];
        _gradeButton.backgroundColor = kUIColor_RGB(67, 73, 73, 0.5);
        
        [_gradeButton.layer setMasksToBounds:YES];
        [_gradeButton.layer setCornerRadius:9.0];
    }
    return _gradeButton;
}

- (UIButton *)empiricalValueButton {
    if (!_empiricalValueButton) {
        _empiricalValueButton = [[UIButton alloc]init];
        [self.backImageView addSubview:_empiricalValueButton];
        __weak typeof(self) weakSelf = self;
        [_empiricalValueButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(weakSelf.gradeButton);
            make.left.mas_equalTo(weakSelf.gradeButton.mas_right).offset(15);
        }];
        _empiricalValueButton.titleLabel.font = kFontSize(12);
        _empiricalValueButton.titleLabel.textColor = [UIColor whiteColor];
        _empiricalValueButton.backgroundColor = kUIColor_RGB(67, 73, 73, 0.7);
        
        [_empiricalValueButton setImage:[UIImage imageNamed:@"经验值"] forState:UIControlStateNormal];
        [_empiricalValueButton setImage:[UIImage imageNamed:@"经验值"] forState:UIControlStateHighlighted];
        [_empiricalValueButton.layer setMasksToBounds:YES];
        [_empiricalValueButton.layer setCornerRadius:9.0];
    }
    return _empiricalValueButton;
}

- (UIButton *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [[UIButton alloc]init];
        [self.backImageView addSubview:_settingBtn];
        [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.right.mas_equalTo(-5);
            make.size.mas_equalTo(36);
        }];
        [_settingBtn setImage:[UIImage imageNamed:@"账户设置"] forState:UIControlStateNormal];
        [_settingBtn setImage:[UIImage imageNamed:@"账户设置"] forState:UIControlStateHighlighted];
    }
    return _settingBtn;
}

@end
