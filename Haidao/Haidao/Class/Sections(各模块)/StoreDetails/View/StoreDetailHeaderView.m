//
//  StoreDetailHeaderView.m
//  Haidao
//
//  Created by 1860 on 16/7/30.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "StoreDetailHeaderView.h"
#import "ShoppingCartButton.h"
#import "CommodityBtn.h"


@interface StoreDetailHeaderView ()

/**  顶部背景  */
@property (nonatomic, strong) UIImageView *topBackgrand;
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

@end

@implementation StoreDetailHeaderView

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
    [self addTouchUpInside:self.attentionBtn StoreDetailHeaderViewButtonType:StoreDetailHeaderViewButtonAttentionType];
    
    //点击店铺首页按钮
    [self addTouchUpInside:self.storeHomeBtn StoreDetailHeaderViewButtonType:StoreDetailHeaderViewButtonStoreHomeType];
    
    //点击全部商品按钮
    [self addTouchUpInside:self.allCommodityBtn StoreDetailHeaderViewButtonType:StoreDetailHeaderViewButtonAllCommodityType];
    
    //点击热销商品按钮
    [self addTouchUpInside:self.hotsCommodityBtn StoreDetailHeaderViewButtonType:StoreDetailHeaderViewButtonHotsCommodityType];
    
    //点击最新上架按钮
    [self addTouchUpInside:self.newsCommodityBtn StoreDetailHeaderViewButtonType:StoreDetailHeaderViewButtonNewsCommodityType];
}

/**
 *  为按钮添加点击事件
 *
 *  @param button 点击的按钮
 *  @param type   按钮的类型
 */
- (void)addTouchUpInside:(UIButton *)button StoreDetailHeaderViewButtonType:(StoreDetailHeaderViewButtonType)type {
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([self.delegate respondsToSelector:@selector(clickStoreDetailHeaderViewButtonWithType:)]) {
            [self.delegate clickStoreDetailHeaderViewButtonWithType:type];
        }
    }];
}

#pragma mark - 懒加载
- (UIImageView *)topBackgrand {
    if (!_topBackgrand) {
        _topBackgrand = [[UIImageView alloc]init];
        [self addSubview:_topBackgrand];
        [_topBackgrand mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(100);
        }];
        _topBackgrand.backgroundColor = [UIColor purpleColor];
    }
    return _topBackgrand;
}

- (UIImageView *)storeLogoImageView {
    if (!_storeLogoImageView) {
        _storeLogoImageView = [[UIImageView alloc]init];
        [self.topBackgrand addSubview:_storeLogoImageView];
        [_storeLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
        _storeLogoImageView.backgroundColor = [UIColor yellowColor];
    }
    return _storeLogoImageView;
}

- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [[UILabel alloc]init];
        [self.topBackgrand addSubview:_storeNameLabel];
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
        [self.topBackgrand addSubview:_directLabel];
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
        [self.topBackgrand addSubview:_arrentionLabel];
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
        [self.topBackgrand addSubview:_attentionBtn];
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
        lineView.backgroundColor = [UIColor lightGrayColor];
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
        lineView.backgroundColor = [UIColor lightGrayColor];
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
        lineView.backgroundColor = [UIColor lightGrayColor];
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

@end
