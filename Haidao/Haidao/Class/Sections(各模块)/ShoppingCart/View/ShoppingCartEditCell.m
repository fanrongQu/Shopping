//
//  ShoppingCartEditCell.m
//  Haidao
//
//  Created by 1860 on 16/7/27.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#define otherColor kUIColor_RGB(85, 85, 85, 1)

#import "ShoppingCartEditCell.h"
#import "ParameterButton.h"

@interface ShoppingCartEditCell ()

/**  图片  */
@property (nonatomic, strong) UIImageView *iconView;
/**  参数  */
@property (nonatomic, strong) ParameterButton *parameterButton;
/**  删除  */
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation ShoppingCartEditCell

+ (ShoppingCartEditCell *)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"ShoppingCartEditCell";
    ShoppingCartEditCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ShoppingCartEditCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [[self.selectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            self.selectedBtn.selected = !self.selectedBtn.selected;
            if ([self.delegate respondsToSelector:@selector(selectedBtnClickedOfEditCell:selected:)]) {
                [self.delegate selectedBtnClickedOfEditCell:self selected:self.selectedBtn.selected];
            }
        }];
        
        [[self.parameterButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([self.delegate respondsToSelector:@selector(parameterButtonClick)]) {
                [self.delegate parameterButtonClick];
            }
        }];
        
        [[self.deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([self.delegate respondsToSelector:@selector(deleteButtonClick)]) {
                [self.delegate deleteButtonClick];
            }
        }];
    }
    return self;
}

- (void)setCommodityImage:(NSString *)imageString name:(NSString *)commodityName color:(NSString *)color size:(NSString *)size price:(NSString *)price oldPrice:(NSString *)oldPrice num:(NSString *)num {
    
    [self shoppingNum];
    NSString *text = [NSString stringWithFormat:@"颜色分类颜色分类颜色分类颜色分类颜色分类:%@ 尺寸:%@",color,size];
    [self.parameterButton setTitle:text forState:UIControlStateNormal];
}

#pragma mark - 懒加载
- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_selectedBtn];
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

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        __weak typeof(self) weakSelf = self;
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(weakSelf.selectedBtn.mas_right).with.offset(5);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(80);
        }];
        _iconView.backgroundColor = [UIColor redColor];
    }
    return _iconView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc]init];
        [self.contentView addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        _deleteButton.titleLabel.font = kFontSize(14);
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.backgroundColor = kUIColor_RGB(255, 30, 30, 1);
    }
    return _deleteButton;
}


- (ShoppingNum *)shoppingNum {
    if (!_shoppingNum) {
        _shoppingNum = [[ShoppingNum alloc]init];
        [self.contentView addSubview:_shoppingNum];
        __weak typeof(self) weakSelf = self;
        [_shoppingNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(weakSelf.iconView.mas_right).offset(10);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.deleteButton.mas_left).offset(-5);
        }];
        _shoppingNum.showBorder = NO;
    }
    return _shoppingNum;
}

- (ParameterButton *)parameterButton {
    if (!_parameterButton) {
        _parameterButton = [[ParameterButton alloc]init];
        [_parameterButton setTitleColor:otherColor forState:UIControlStateNormal];
        [_parameterButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _parameterButton.titleLabel.font = kFontSize(13);
        _parameterButton.titleLabel.numberOfLines = 2;
        [_parameterButton setImage:[UIImage imageNamed:@"属性"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_parameterButton];
        __weak typeof(self) weakSelf = self;
        [_parameterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.shoppingNum);
            make.right.mas_equalTo(weakSelf.shoppingNum).offset(-3);
            make.centerY.mas_equalTo(weakSelf.iconView.mas_centerY).offset(15);
            make.height.mas_equalTo(35);
        }];
        
    }
    return _parameterButton;
}

- (void)setShowDeleteBtn:(BOOL)showDeleteBtn {
    _showDeleteBtn = showDeleteBtn;
    if (!showDeleteBtn) {
        [self.deleteButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }else {
        [self.deleteButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(54);
        }];
    }
}

@end
