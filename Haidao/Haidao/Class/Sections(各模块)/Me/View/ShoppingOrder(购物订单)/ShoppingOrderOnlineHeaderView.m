//
//  ShoppingOrderOnlineHeaderView.m
//  Haidao
//
//  Created by 1860 on 16/7/27.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingOrderOnlineHeaderView.h"

@interface ShoppingOrderOnlineHeaderView ()

/**  背景  */
@property (nonatomic, strong) UIView *bgView;
/**  店铺名称按钮  */
@property (nonatomic, strong) UIButton *nameBtn;
/**  导向箭头图片  */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ShoppingOrderOnlineHeaderView


+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ShoppingOrderOnlineHeaderView";
    ShoppingOrderOnlineHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[ShoppingOrderOnlineHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self imageView];
        
        //选择按钮点击事件
        [[self.selectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            self.selectedBtn.selected = !self.selectedBtn.selected;
            //如果代理实现了相应的方法就会调用该方法，没有实现则不调用
            if ([self.delegate respondsToSelector:@selector(selectedBtnClickedOfHeaderView:selected:)]) {
                [self.delegate selectedBtnClickedOfHeaderView:self selected:self.selectedBtn.selected];
            }
        }];
        //商家名称点击事件
        [[self.nameBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if ([self.delegate respondsToSelector:@selector(nameBtnClickedOfHeaderView:)]) {
                [self.delegate nameBtnClickedOfHeaderView:self];
            }
        }];
        
        //编辑按钮点击事件
        [[self.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            self.editBtn.selected = !self.editBtn.selected;
            if ([self.delegate respondsToSelector:@selector(editBtnClickedOfHeaderView:edit:)]) {
                [self.delegate editBtnClickedOfHeaderView:self edit:self.editBtn.selected];
            }
        }];
    }
    return self;
}

- (void)setTitleName:(NSString *)titleName {
    _titleName = titleName;
    [self.nameBtn setTitle:titleName forState:UIControlStateNormal];
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(12, 0, 0, 0));
        }];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [[UIButton alloc]init];
        [self.bgView addSubview:_selectedBtn];
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

- (UIButton *)nameBtn {
    if (!_nameBtn) {
        _nameBtn = [[UIButton alloc]init];
        [self.bgView addSubview:_nameBtn];
        __weak typeof(self) weakSelf = self;
        [_nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.selectedBtn.mas_right).with.offset(5);
            make.centerY.mas_equalTo(0);
        }];
        
        _nameBtn.titleLabel.font = kFontSize(15);
        [_nameBtn setImage:[UIImage imageNamed:@"店铺主页"] forState:UIControlStateNormal];
        [_nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_nameBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    return _nameBtn;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"导向"]];
        [self.bgView addSubview:_imageView];
        __weak typeof(self) weakSelf = self;
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.nameBtn.mas_right).with.offset(5);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _imageView;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [[UIButton alloc]init];
        [self.bgView addSubview:_editBtn];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-8);
        }];
        
        _editBtn.titleLabel.font = kFontSize(14);
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    return _editBtn;
}

@end
