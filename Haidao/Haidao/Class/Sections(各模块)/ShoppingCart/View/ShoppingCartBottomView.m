//
//  ShoppingCartBottomView.m
//  Haidao
//
//  Created by 1860 on 16/7/28.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingCartBottomView.h"

@interface ShoppingCartBottomView ()
/**  全选  */
@property (nonatomic, strong) UILabel *allSelectLabel;
/**  结算按钮  */
@property (nonatomic, strong) UIButton *settleAccountsBtn;
/**  不含运费  */
@property (nonatomic, strong) UILabel *uncarriageLabel;
/**  总价  */
@property (nonatomic, strong) UILabel *totalPricesL;
/**  合计  */
@property (nonatomic, strong) UILabel *totalL;

/**  转为关注  */
@property (nonatomic, strong) UIButton *attentionButton;
/**  删除  */
@property (nonatomic, strong) UIButton *removeButton;

@end

@implementation ShoppingCartBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self allSelectLabel];
        [self totalL];
        self.backgroundColor = [UIColor whiteColor];
        
        [[self.selectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            self.selectedBtn.selected = !self.selectedBtn.selected;
            if ([self.delegate respondsToSelector:@selector(selectedBtnClickedOfSelected:)]) {
                [self.delegate selectedBtnClickedOfSelected:self.selectedBtn.selected];
            }
        }];
        
        [[self.settleAccountsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([self.delegate respondsToSelector:@selector(clickSettleAccountsBtn)]) {
                [self.delegate clickSettleAccountsBtn];
            }
        }];
        
        [[self.attentionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([self.delegate respondsToSelector:@selector(clickAttentionButton)]) {
                [self.delegate clickAttentionButton];
            }
        }];
        
        [[self.removeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([self.delegate respondsToSelector:@selector(clickRemoveButton)]) {
                [self.delegate clickRemoveButton];
            }
        }];

    }
    return self;
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (isEdit) {
        self.attentionButton.hidden = NO;
        self.removeButton.hidden = NO;
        
        self.settleAccountsBtn.hidden = YES;
        self.uncarriageLabel.hidden = YES;
        self.totalPricesL.hidden = YES;
        self.totalL.hidden = YES;
    }else {
        self.attentionButton.hidden = YES;
        self.removeButton.hidden = YES;
        
        self.settleAccountsBtn.hidden = NO;
        self.uncarriageLabel.hidden = NO;
        self.totalPricesL.hidden = NO;
        self.totalL.hidden = NO;
    }
}

#pragma mark - 懒加载
- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [[UIButton alloc]init];
        [self addSubview:_selectedBtn];
        [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.size.mas_equalTo(36);
            make.centerY.mas_equalTo(0);
        }];
        [_selectedBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    }
    return _selectedBtn;
}

- (UILabel *)allSelectLabel {
    if (!_allSelectLabel) {
        _allSelectLabel = [[UILabel alloc]init];
        [self addSubview:_allSelectLabel];
        __weak typeof(self) weakSelf = self;
        [_allSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.selectedBtn.mas_right).offset(5);
            make.centerY.mas_equalTo(weakSelf.selectedBtn);
        }];
        _allSelectLabel.text = @"全选";
        _allSelectLabel.font = kFontSize(16);
        _allSelectLabel.textColor = [UIColor blackColor];
    }
    return _allSelectLabel;
}

- (UIButton *)settleAccountsBtn {
    if (!_settleAccountsBtn) {
        _settleAccountsBtn = [[UIButton alloc]init];
        [self addSubview:_settleAccountsBtn];
        [_settleAccountsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(100);
        }];
        _settleAccountsBtn.titleLabel.font = kFontSize(14);
        [_settleAccountsBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_settleAccountsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _settleAccountsBtn.backgroundColor = kSubjectColor;
    }
    return _settleAccountsBtn;
}

- (UILabel *)uncarriageLabel {
    if (!_uncarriageLabel) {
        _uncarriageLabel = [[UILabel alloc]init];
        [self addSubview:_uncarriageLabel];
        __weak typeof(self) weakSelf = self;
        [_uncarriageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.settleAccountsBtn.mas_left).offset(-10);
            make.centerY.mas_equalTo(weakSelf.selectedBtn);
        }];
        _uncarriageLabel.text = @"不含运费";
        _uncarriageLabel.textColor = [UIColor grayColor];
        _uncarriageLabel.font = kFontSize(10);
    }
    return _uncarriageLabel;
}

- (UILabel *)totalPricesL {
    if (!_totalPricesL) {
        _totalPricesL = [[UILabel alloc]init];
        [self addSubview:_totalPricesL];
        __weak typeof(self) weakSelf = self;
        [_totalPricesL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.uncarriageLabel.mas_left).offset(-10);
            make.centerY.mas_equalTo(weakSelf.selectedBtn);
        }];
        _totalPricesL.text = @"￥0.00";
        _totalPricesL.textColor = kUIColor_RGB(0, 132, 134, 1);
        _totalPricesL.font = kFontSize(14);
    }
    return _totalPricesL;
}

- (UILabel *)totalL {
    if (!_totalL) {
        _totalL = [[UILabel alloc]init];
        [self addSubview:_totalL];
        __weak typeof(self) weakSelf = self;
        [_totalL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.totalPricesL.mas_left);
            make.centerY.mas_equalTo(weakSelf.selectedBtn);
        }];
        _totalL.text = @"合计:";
        _totalL.font = kFontSize(14);
    }
    return _totalL;
}

- (UIButton *)removeButton {
    if (!_removeButton) {
        _removeButton = [[UIButton alloc]init];
        [self addSubview:_removeButton];
        [_removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(100);
        }];
        _removeButton.titleLabel.font = kFontSize(14);
        [_removeButton setTitle:@"删除" forState:UIControlStateNormal];
        [_removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _removeButton.backgroundColor = [UIColor redColor];
    }
    return _removeButton;
}

- (UIButton *)attentionButton {
    if (!_attentionButton) {
        _attentionButton = [[UIButton alloc]init];
        [self addSubview:_attentionButton];
        __weak typeof(self) weakSelf = self;
        [_attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.mas_equalTo(weakSelf.removeButton);
            make.right.mas_equalTo(weakSelf.removeButton.mas_left);
        }];
        _attentionButton.titleLabel.font = kFontSize(14);
        [_attentionButton setTitle:@"转为关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _attentionButton.backgroundColor = kSubjectColor;
    }
    return _attentionButton;
}

@end
