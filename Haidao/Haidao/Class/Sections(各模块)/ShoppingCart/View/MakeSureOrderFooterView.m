//
//  MakeSureOrderFooterView.m
//  Haidao
//
//  Created by 1860 on 16/8/21.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MakeSureOrderFooterView.h"
#import "FRTextField.h"

@interface MakeSureOrderFooterView ()

/**  配送方式  */
@property (nonatomic, strong) UIView *distributionView;
/**  配送  */
@property (nonatomic, weak) UILabel *distributionLabel;

/**  买家留言  */
@property (nonatomic, strong) UIView *messageView;
/**  留言内容  */
@property (nonatomic, weak) FRTextField *textField;

/**  合计  */
@property (nonatomic, strong) UIView *priceView;
/**  数量  */
@property (nonatomic, weak) UILabel *numberLabel;
/**  价格  */
@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation MakeSureOrderFooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"MakeSureOrderFooterView";
    MakeSureOrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!footerView) {
        footerView = [[MakeSureOrderFooterView alloc]initWithReuseIdentifier:ID];
    }
    return footerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self priceView];
        
        [self setDistributionType:@"快递包邮" orderNumber:@"2" orderPrice:@"200.00"];
    }
    return self;
}


- (void)setDistributionType:(NSString *)distribution orderNumber:(NSString *)number orderPrice:(NSString *)price {
    
    self.distributionLabel.text = distribution;
    self.numberLabel.text = [NSString stringWithFormat:@"共%@件商品  合计:",number];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
}

- (UIView *)distributionView {
    if (!_distributionView) {
        _distributionView = [[UIView alloc]init];
        [self addSubview:_distributionView];
        [_distributionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(48);
        }];
        _distributionView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        [_distributionView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        titleLabel.font = kFontSize(14);
        titleLabel.text = @"配送方式";
        
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [_distributionView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [imageView setImage:[UIImage imageNamed:@"导向"]];
        
        UILabel *distributionLabel = [[UILabel alloc]init];
        [_distributionView addSubview:distributionLabel];
        [distributionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(imageView.mas_left).offset(-5);
            make.centerY.mas_equalTo(0);
        }];
        distributionLabel.font = kFontSize(14);
        self.distributionLabel = distributionLabel;
    }
    return _distributionView;
}

- (UIView *)messageView {
    if (!_messageView) {
        _messageView = [[UIView alloc]init];
        [self addSubview:_messageView];
        __weak typeof(self) weakSelf = self;
        [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.distributionView.mas_bottom).offset(1);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(weakSelf.distributionView);
        }];
        _messageView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        [_messageView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(65);
        }];
        titleLabel.font = kFontSize(14);
        titleLabel.text = @"买家留言";
        
        FRTextField *textfield = [[FRTextField alloc]init];
        [_messageView addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(titleLabel.mas_right);
            make.bottom.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
        }];
        textfield.placeholder = @"选填，对本次交易的说明";
        self.textField = textfield;
    }
    return _messageView;
}

- (UIView *)priceView {
    if (!_priceView) {
        _priceView = [[UIView alloc]init];
        [self addSubview:_priceView];
        __weak typeof(self) weakSelf = self;
        [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.messageView.mas_bottom).offset(1);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(weakSelf.distributionView);
        }];
        _priceView.backgroundColor = [UIColor whiteColor];
        
        UILabel *priceLabel = [[UILabel alloc]init];
        [_priceView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        }];
        priceLabel.font = kFontSize(14);
        priceLabel.textColor = kSubjectColor;
        self.priceLabel = priceLabel;
        
        UILabel *numberLabel = [[UILabel alloc]init];
        [_priceView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(priceLabel.mas_left);
            make.centerY.mas_equalTo(0);
        }];
        numberLabel.font = kFontSize(14);
        self.numberLabel = numberLabel;
        
    }
    return _priceView;
}

@end
