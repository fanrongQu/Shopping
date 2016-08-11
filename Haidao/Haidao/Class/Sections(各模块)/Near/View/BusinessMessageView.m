//
//  BusinessMessageView.m
//  Haidao
//
//  Created by 1860 on 16/8/11.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BusinessMessageView.h"

@interface BusinessMessageView ()

/**  商家信息  */
@property (nonatomic, strong) UILabel *viewTitleLabel;
/**  间距线条  */
@property (nonatomic, strong) UIView *firstLineView;
/**  标题  */
@property (nonatomic, strong) UILabel *titleLabel;
/**  地址  */
@property (nonatomic, strong) UILabel *addressLabel;
/**  距离  */
@property (nonatomic, strong) UILabel *distanceLabel;
/**  间距线条  */
@property (nonatomic, strong) UIView *secondLineView;
/**  电话按钮  */
@property (nonatomic, strong) UIButton *phoneButton;
/**  间距线条  */
@property (nonatomic, strong) UIView *thridLineView;
/**  简介  */
@property (nonatomic, strong) UILabel *introductionLabel;
/**  联系电话  */
@property (nonatomic, strong) UILabel *phoneText;
/**  浏览量  */
@property (nonatomic, strong) UILabel *browseNumLabel;

/**  电话号码  */
@property (nonatomic, copy) NSString *phone;

@end

@implementation BusinessMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [[self.phoneButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"拨打电话");
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.phone]]]];
            [self addSubview:callWebview];
        }];
    }
    return self;
}

- (void)setBusinessMessageViewTitle:(NSString *)title address:(NSString *)address distance:(NSString *)distance introduction:(NSString *)introduction phone:(NSString *)phone browseNum:(NSString *)browseNumber {
    self.titleLabel.text = title;
    self.addressLabel.text = [NSString stringWithFormat:@"地址：%@",address];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@km",distance];
    self.introductionLabel.attributedText = [NSAttributedString attributedStringWithString:[NSString stringWithFormat:@"简介：%@",introduction]];
    self.phoneText.text = [NSString stringWithFormat:@"联系电话：%@",phone];
    self.phone = phone;
    self.browseNumLabel.text = [NSString stringWithFormat:@"浏览量  %@",browseNumber];
}


#pragma mark - 懒加载
- (UILabel *)viewTitleLabel {
    if (!_viewTitleLabel) {
        _viewTitleLabel = [[UILabel alloc]init];
        [self addSubview:_viewTitleLabel];
        [_viewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
        }];
        _viewTitleLabel.font = kFontSize(16);
        _viewTitleLabel.text = @"商家信息";
    }
    return _viewTitleLabel;
}

- (UIView *)firstLineView {
    if (!_firstLineView) {
        _firstLineView = [[UIView alloc]init];
        [self addSubview:_firstLineView];
        __weak typeof(self) weakSelf = self;
        [_firstLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.viewTitleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(0.7);
        }];
        _firstLineView.backgroundColor = kUIColor_RGB(230, 230, 230, 1);
    }
    return _firstLineView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.firstLineView.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.viewTitleLabel);
        }];
        _titleLabel.font = kFontSize(16);
        _titleLabel.textColor = kSubjectColor;
    }
    return _titleLabel;
}


- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        [self addSubview:_addressLabel];
        __weak typeof(self) weakSelf = self;
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.viewTitleLabel);
            make.right.mas_equalTo(-75);
        }];
        _addressLabel.font = kFontSize(12);
        _addressLabel.textColor = kGrayColor;
    }
    return _addressLabel;
}


- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        __weak typeof(self) weakSelf = self;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.addressLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.viewTitleLabel);
            make.size.mas_equalTo(CGSizeMake(8, 12));
        }];
        [imageView setImage:[UIImage imageNamed:@"当前城市"]];
        
        _distanceLabel = [[UILabel alloc]init];
        [self addSubview:_distanceLabel];
        [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).offset(3);
            make.centerY.mas_equalTo(imageView);
        }];
        _distanceLabel.font = kFontSize(12);
        _distanceLabel.textColor = kGrayColor;
    }
    return _distanceLabel;
}

- (UIView *)secondLineView {
    if (!_secondLineView) {
        _secondLineView = [[UIView alloc]init];
        [self addSubview:_secondLineView];
        __weak typeof(self) weakSelf = self;
        [_secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLabel);
            make.left.mas_equalTo(weakSelf.addressLabel.mas_right).offset(5);
            make.bottom.mas_equalTo(weakSelf.distanceLabel);
            make.width.mas_equalTo(0.7);
        }];
        _secondLineView.backgroundColor = kUIColor_RGB(230, 230, 230, 1);
    }
    return _secondLineView;
}


- (UIButton *)phoneButton {
    if (!_phoneButton) {
        _phoneButton = [[UIButton alloc]init];
        [self addSubview:_phoneButton];
        __weak typeof(self) weakSelf = self;
        [_phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(weakSelf.secondLineView);
            make.left.mas_equalTo(weakSelf.secondLineView.mas_right);
            make.right.mas_equalTo(-15);
        }];
        [_phoneButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    }
    return _phoneButton;
}


- (UIView *)thridLineView {
    if (!_thridLineView) {
        _thridLineView = [[UIView alloc]init];
        [self addSubview:_thridLineView];
        __weak typeof(self) weakSelf = self;
        [_thridLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.phoneButton.mas_bottom).offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(0.7);
        }];
        _thridLineView.backgroundColor = kUIColor_RGB(230, 230, 230, 1);
    }
    return _thridLineView;
}


- (UILabel *)introductionLabel {
    if (!_introductionLabel) {
        _introductionLabel = [[UILabel alloc]init];
        [self addSubview:_introductionLabel];
        __weak typeof(self) weakSelf = self;
        [_introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.thridLineView.mas_bottom).offset(10);
            make.left.mas_equalTo(weakSelf.viewTitleLabel);
            make.right.mas_equalTo(-15);
        }];
        _introductionLabel.font = kFontSize(12);
        _introductionLabel.numberOfLines = 0;
        _introductionLabel.textColor = kGrayColor;
    }
    return _introductionLabel;
}



- (UILabel *)phoneText {
    if (!_phoneText) {
        _phoneText = [[UILabel alloc]init];
        [self addSubview:_phoneText];
        __weak typeof(self) weakSelf = self;
        [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.introductionLabel.mas_bottom).offset(20);
            make.left.mas_equalTo(weakSelf.viewTitleLabel);
            make.bottom.mas_equalTo(-10);
        }];
        _phoneText.font = kFontSize(12);
        _phoneText.textColor = kGrayColor;
    }
    return _phoneText;
}


- (UILabel *)browseNumLabel {
    if (!_browseNumLabel) {
        
        _browseNumLabel = [[UILabel alloc]init];
        [self addSubview:_browseNumLabel];
        __weak typeof(self) weakSelf = self;
        [_browseNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.phoneText);
            make.right.mas_equalTo(-15);
        }];
        _browseNumLabel.font = kFontSize(12);
        _browseNumLabel.textColor = kGrayColor;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_browseNumLabel.mas_left).offset(-5);
            make.centerY.mas_equalTo(_browseNumLabel);
            make.size.mas_equalTo(CGSizeMake(15, 9));
        }];
        [imageView setImage:[UIImage imageNamed:@"浏览量"]];
    }
    return _browseNumLabel;
}



@end
