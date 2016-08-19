//
//  ShoppingOrderOnlineFooterView.m
//  Haidao
//
//  Created by 1860 on 16/8/19.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingOrderOnlineFooterView.h"

@interface ShoppingOrderOnlineFooterView ()

/**  背景  */
@property (nonatomic, strong) UIView *bgView;
/**  价格  */
@property (nonatomic, strong) UILabel *priceLabel;
/**  数量  */
@property (nonatomic, strong) UILabel *numberLabel;
/**  左侧按钮  */
@property (nonatomic, strong) UIButton *leftButton;
/**  右侧按钮  */
@property (nonatomic, strong) UIButton *rightButton;
/**  对应的section  */
@property (nonatomic, assign) NSInteger section;
/**  状态  */
@property (nonatomic, assign) ShoppingOrderOnlineState state;

@end

@implementation ShoppingOrderOnlineFooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"ShoppingOrderOnlineFooterView";
    ShoppingOrderOnlineFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!footerView) {
        footerView = [[ShoppingOrderOnlineFooterView alloc]initWithReuseIdentifier:ID];
    }
    return footerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        __weak typeof(self) weakSelf = self;
        [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([weakSelf.delegate respondsToSelector:@selector(footerViewLeftButtonClickInSection:state:)]) {
                [weakSelf.delegate footerViewLeftButtonClickInSection:weakSelf.section state:weakSelf.state];
            }
        }];
        
        [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([weakSelf.delegate respondsToSelector:@selector(footerViewRightButtonClickInSection:state:)]) {
                [weakSelf.delegate footerViewRightButtonClickInSection:weakSelf.section state:weakSelf.state];
            }
        }];
        
    }
    return self;
}

- (void)setFooterViewOfPrice:(NSString *)price freight:(NSString *)freight number:(NSString *)number section:(NSInteger)section state:(ShoppingOrderOnlineState)state {
    
    self.priceLabel.text = [NSString stringWithFormat:@"合计:￥%@ (含运费:%@)",price,freight];
    self.numberLabel.text = [NSString stringWithFormat:@"共%@件商品",number];
    self.section = section;
    self.state = state;
    
    self.leftButton.hidden = NO;
    switch (state) {
        case ShoppingOrderOnlineWaitPayState:{//等待买家付款
            [self.leftButton setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"去付款" forState:UIControlStateNormal];
            
            [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightButton.backgroundColor = kSubjectColor;
        }
            break;
        case ShoppingOrderOnlinePaidState:{//买家已付款
            self.leftButton.hidden = YES;
            [self.rightButton setTitle:@"提醒发货" forState:UIControlStateNormal];
            
            [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.rightButton.backgroundColor = [UIColor whiteColor];
        }
            break;
        case ShoppingOrderOnlineSendOutState:{//卖家已发货
            [self.leftButton setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"确认收货" forState:UIControlStateNormal];
            
            [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightButton.backgroundColor = kSubjectColor;
        }
            break;
        case ShoppingOrderOnlineFinishState:{//交易完成
            [self.leftButton setTitle:@"去评价" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"删除订单" forState:UIControlStateNormal];
            
            [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.rightButton.backgroundColor = [UIColor whiteColor];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _bgView.backgroundColor = [UIColor whiteColor];
        
//        //分割线
//        UIView *lineView = [[UIView alloc]init];
//        [_bgView addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo(15);
//            make.right.mas_equalTo(0);
//            make.height.mas_equalTo(0.7);
//        }];
//        lineView.backgroundColor = KLineViewColor;
    }
    return _bgView;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        [self.bgView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        _priceLabel.font = kFontSize(13);
    }
    return _priceLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        [self.bgView addSubview:_numberLabel];
        __weak typeof(self) weakSelf = self;
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.priceLabel);
            make.right.mas_equalTo(weakSelf.priceLabel.mas_left).offset(-6);
        }];
        _numberLabel.font = kFontSize(13);
    }
    return _numberLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]init];
        [self.bgView addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        _rightButton.titleLabel.font = kFontSize(14);
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightButton.backgroundColor = [UIColor whiteColor];
        [_rightButton.layer setMasksToBounds:YES];
        [_rightButton.layer setBorderColor:kGrayColor.CGColor];
        [_rightButton.layer setBorderWidth:1.0];
        [_rightButton.layer setCornerRadius:3.0];
    }
    return _rightButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]init];
        [self.bgView addSubview:_leftButton];
        __weak typeof(self) weakSelf = self;
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.rightButton.mas_left).offset(-10);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        _leftButton.titleLabel.font = kFontSize(14);
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftButton.backgroundColor = [UIColor whiteColor];
        [_leftButton.layer setMasksToBounds:YES];
        [_leftButton.layer setBorderColor:kGrayColor.CGColor];
        [_leftButton.layer setBorderWidth:1.0];
        [_leftButton.layer setCornerRadius:3.0];
    }
    return _leftButton;
}

@end
