//
//  InfoView.m
//  Haidao
//
//  Created by 1860 on 16/7/17.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "InfoView.h"
#import "ShoppingCartButton.h"
#import "CommodityBtn.h"


@interface InfoView ()

/**  店铺logo  */
@property (nonatomic, strong) UIImageView *storeLogoImageView;
/**  店铺名称  */
@property (nonatomic, strong) UILabel *storeNameLabel;
/**  直营  */
@property (nonatomic, strong) UILabel *directLabel;
/**  关注数量  */
@property (nonatomic, strong) UILabel *arrentionLabel;

/**  关注店铺  */
@property (nonatomic, strong) UIButton *attentionBtn;

/**  店铺首页  */
@property (nonatomic, strong) ShoppingCartButton *storeHomeBtn;
/**  全部商品  */
@property (nonatomic, strong) CommodityBtn *allCommodityBtn;
/**  热销商品  */
@property (nonatomic, strong) CommodityBtn *hotsCommodityBtn;
/**  最新上架  */
@property (nonatomic, strong) CommodityBtn *newsCommodityBtn;
/**  分割线  */
@property (nonatomic, strong) UIView *cuttingLineView;

/**  联系客服  */
@property (nonatomic, strong) UIButton *serviceBtn;
/**  进入首页  */
@property (nonatomic, strong) UIButton *goToHomeBtn;


@end

@implementation InfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addSubviews {
    self.storeNameLabel.text = @"回百硕电子科技";
    self.directLabel.text = @" 直营 ";
    self.arrentionLabel.text = @"1200人关注";
    
    [self.allCommodityBtn setTitle:@"500" forState:UIControlStateNormal];
    [self.hotsCommodityBtn setTitle:@"600" forState:UIControlStateNormal];
    [self.newsCommodityBtn setTitle:@"100" forState:UIControlStateNormal];
    
    //点击关注店铺按钮
    [self addTouchUpInside:self.attentionBtn InfoViewButtonType:InfoViewButtonAttentionType];
    
    //点击店铺首页按钮
    [self addTouchUpInside:self.storeHomeBtn InfoViewButtonType:InfoViewButtonStoreHomeType];
    
    //点击全部商品按钮
    [self addTouchUpInside:self.allCommodityBtn InfoViewButtonType:InfoViewButtonAllCommodityType];
    
    //点击热销商品按钮
    [self addTouchUpInside:self.hotsCommodityBtn InfoViewButtonType:InfoViewButtonHotsCommodityType];
    
    //点击最新上架按钮
    [self addTouchUpInside:self.newsCommodityBtn InfoViewButtonType:InfoViewButtonNewsCommodityType];
    
    //点击联系客服按钮
    [self addTouchUpInside:self.serviceBtn InfoViewButtonType:InfoViewButtonServiceType];
    
    //点击进入首页按钮
    [self addTouchUpInside:self.goToHomeBtn InfoViewButtonType:InfoViewButtonStoreHomeType];
    
}

/**
 *  为按钮添加点击事件
 *
 *  @param button 点击的按钮
 *  @param type   按钮的类型
 */
- (void)addTouchUpInside:(UIButton *)button InfoViewButtonType:(InfoViewButtonType)type {
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([self.delegate respondsToSelector:@selector(clickInfoViewButtonWithType:)]) {
            [self.delegate clickInfoViewButtonWithType:type];
        }
    }];
}

#pragma mark - 懒加载
- (UIImageView *)storeLogoImageView {
    if (!_storeLogoImageView) {
        _storeLogoImageView = [[UIImageView alloc]init];
        [self addSubview:_storeLogoImageView];
        [_storeLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
        _storeLogoImageView.backgroundColor = [UIColor yellowColor];
    }
    return _storeLogoImageView;
}

- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [[UILabel alloc]init];
        [self addSubview:_storeNameLabel];
        __weak typeof(self) weakSelf = self;
        [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.storeLogoImageView);
            make.left.mas_equalTo(weakSelf.storeLogoImageView.mas_right).offset(10);
        }];
        _storeNameLabel.font = kFontSize(15);
    }
    return _storeNameLabel;
}

- (UILabel *)directLabel {
    if (!_directLabel) {
        _directLabel = [[UILabel alloc]init];
        [self addSubview:_directLabel];
        __weak typeof(self) weakSelf = self;
        [_directLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.storeLogoImageView);
            make.left.mas_equalTo(weakSelf.storeNameLabel);
        }];
        _directLabel.font = kFontSize(12);
        _directLabel.backgroundColor = kSubjectColor;
        _directLabel.textColor = [UIColor whiteColor];
        [_directLabel.layer setMasksToBounds:YES];
        [_directLabel.layer setCornerRadius:3.0];
    }
    return _directLabel;
}

- (UILabel *)arrentionLabel {
    if (!_arrentionLabel) {
        _arrentionLabel = [[UILabel alloc]init];
        [self addSubview:_arrentionLabel];
        __weak typeof(self) weakSelf = self;
        [_arrentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.storeLogoImageView);
            make.left.mas_equalTo(weakSelf.directLabel.mas_right).offset(5);
        }];
        _arrentionLabel.font = kFontSize(12);
        _arrentionLabel.textColor = labelColor;
    }
    return _arrentionLabel;
}

- (UIButton *)attentionBtn {
    if (!_attentionBtn) {
        _attentionBtn = [[UIButton alloc]init];
        [self addSubview:_attentionBtn];
        __weak typeof(self) weakSelf = self;
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.storeLogoImageView);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(65, 30));
        }];
        _attentionBtn.backgroundColor = kSubjectColor;
        _attentionBtn.titleLabel.font = kFontSize(14);
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_attentionBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_attentionBtn.layer setMasksToBounds:YES];
        [_attentionBtn.layer setCornerRadius:5.0];
    }
    return _attentionBtn;
}

- (ShoppingCartButton *)storeHomeBtn {
    if (!_storeHomeBtn) {
        _storeHomeBtn = [[ShoppingCartButton alloc]init];
        [self addSubview:_storeHomeBtn];
        __weak typeof(self) weakSelf = self;
        [_storeHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.storeLogoImageView.mas_bottom).offset(10);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.25, 55));
        }];
        
        _storeHomeBtn.titleLabel.font = kFontSize(14);
        [_storeHomeBtn setTitle:@"店铺首页" forState:UIControlStateNormal];
        [_storeHomeBtn setTitleColor:labelColor forState:UIControlStateNormal];
        [_storeHomeBtn setImage:[UIImage imageNamed:@"店铺主页"] forState:UIControlStateNormal];
        [_storeHomeBtn setImage:[UIImage imageNamed:@"店铺主页"] forState:UIControlStateHighlighted];
        
        //分割线
        UIView *lineView = [[UIView alloc]init];
        [_storeHomeBtn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _storeHomeBtn;
}

- (CommodityBtn *)allCommodityBtn {
    if (!_allCommodityBtn) {
        _allCommodityBtn = [[CommodityBtn alloc]init];
        [self addSubview:_allCommodityBtn];
        __weak typeof(self) weakSelf = self;
        [_allCommodityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.storeHomeBtn);
            make.left.mas_equalTo(weakSelf.storeHomeBtn.mas_right);
            make.size.mas_equalTo(weakSelf.storeHomeBtn);
        }];
        
        _allCommodityBtn.titleLabel.numberOfLines = 2;
        [_allCommodityBtn setTitleColor:labelColor forState:UIControlStateNormal];
        _allCommodityBtn.describeLabel.text = @"全部商品";
        
        //分割线
        UIView *lineView = [[UIView alloc]init];
        [_allCommodityBtn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _allCommodityBtn;
}

- (CommodityBtn *)hotsCommodityBtn {
    if (!_hotsCommodityBtn) {
        _hotsCommodityBtn = [[CommodityBtn alloc]init];
        [self addSubview:_hotsCommodityBtn];
        __weak typeof(self) weakSelf = self;
        [_hotsCommodityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.storeHomeBtn);
            make.left.mas_equalTo(weakSelf.allCommodityBtn.mas_right);
            make.size.mas_equalTo(weakSelf.storeHomeBtn);
        }];
        
        _hotsCommodityBtn.titleLabel.numberOfLines = 2;
        [_hotsCommodityBtn setTitleColor:labelColor forState:UIControlStateNormal];
        _hotsCommodityBtn.describeLabel.text = @"热门商品";
        
        //分割线
        UIView *lineView = [[UIView alloc]init];
        [_hotsCommodityBtn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(0.7);
        }];
        lineView.backgroundColor = KLineViewColor;
    }
    return _hotsCommodityBtn;
}

- (CommodityBtn *)newsCommodityBtn {
    if (!_newsCommodityBtn) {
        _newsCommodityBtn = [[CommodityBtn alloc]init];
        [self addSubview:_newsCommodityBtn];
        __weak typeof(self) weakSelf = self;
        [_newsCommodityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.storeHomeBtn);
            make.left.mas_equalTo(weakSelf.hotsCommodityBtn.mas_right);
            make.size.mas_equalTo(weakSelf.storeHomeBtn);
        }];
        
        _newsCommodityBtn.titleLabel.numberOfLines = 2;
        [_newsCommodityBtn setTitleColor:labelColor forState:UIControlStateNormal];
        _newsCommodityBtn.describeLabel.text = @"最新上架";
    }
    return _newsCommodityBtn;
}

- (UIView *)cuttingLineView {
    if (!_cuttingLineView) {
        _cuttingLineView = [[UIView alloc]init];
        [self addSubview:_cuttingLineView];
        __weak typeof(self) weakSelf = self;
        [_cuttingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.newsCommodityBtn.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0.7);
        }];
        _cuttingLineView.backgroundColor = KLineViewColor;
    }
    return _cuttingLineView;
}

- (UIButton *)serviceBtn {
    if (!_serviceBtn) {
        _serviceBtn = [[UIButton alloc]init];
        [self addSubview:_serviceBtn];
        __weak typeof(self) weakSelf = self;
        [_serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.cuttingLineView.mas_bottom).offset(12);
            make.centerX.mas_equalTo(weakSelf.centerX).offset(-55);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        _serviceBtn.titleLabel.font = kFontSize(16);
        [_serviceBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        [_serviceBtn setTitleColor:labelColor forState:UIControlStateNormal];
        [_serviceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_serviceBtn.layer setMasksToBounds:YES];
        [_serviceBtn.layer setBorderWidth:1.0];
        [_serviceBtn.layer setBorderColor:[UIColor grayColor].CGColor];
    }
    return _serviceBtn;
}

- (UIButton *)goToHomeBtn {
    if (!_goToHomeBtn) {
        _goToHomeBtn = [[UIButton alloc]init];
        [self addSubview:_goToHomeBtn];
        __weak typeof(self) weakSelf = self;
        [_goToHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.serviceBtn);
            make.centerX.mas_equalTo(weakSelf.centerX).offset(55);
            make.size.mas_equalTo(weakSelf.serviceBtn);
        }];
        _goToHomeBtn.titleLabel.font = kFontSize(16);
        [_goToHomeBtn setTitle:@"进入首页" forState:UIControlStateNormal];
        [_goToHomeBtn setTitleColor:labelColor forState:UIControlStateNormal];
        [_goToHomeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_goToHomeBtn.layer setMasksToBounds:YES];
        [_goToHomeBtn.layer setBorderWidth:1.0];
        [_goToHomeBtn.layer setBorderColor:[UIColor grayColor].CGColor];
        
    }
    return _goToHomeBtn;
}

@end
