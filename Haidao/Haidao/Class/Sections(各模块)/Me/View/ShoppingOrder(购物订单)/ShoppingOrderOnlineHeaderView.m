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
/**  headerView的序号  */
@property (nonatomic, assign) NSInteger section;
/**  店铺名称按钮  */
@property (nonatomic, strong) UIButton *nameBtn;
/**  导向箭头图片  */
@property (nonatomic, strong) UIImageView *imageView;
/**  订单状态  */
@property (nonatomic, strong) UILabel *stateLabel;

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
        
       //商家名称点击事件
        [[self.nameBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if ([self.delegate respondsToSelector:@selector(nameBtnClickedOfHeaderView:)]) {
                [self.delegate nameBtnClickedOfHeaderView:self];
            }
        }];
    }
    return self;
}

- (void)setShoppingOrderOnlineHeaderViewTitle:(NSString *)title state:(NSString *)state {
    
    [self.nameBtn setTitle:title forState:UIControlStateNormal];
    self.stateLabel.text = state;
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

- (UIButton *)nameBtn {
    if (!_nameBtn) {
        _nameBtn = [[UIButton alloc]init];
        [self.bgView addSubview:_nameBtn];
        [_nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
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

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        [self.bgView addSubview:_stateLabel];
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
        }];
        _stateLabel.font = kFontSize(13);
        _stateLabel.textColor = kUIColor_RGB(213, 122, 126, 1);
    }
    return _stateLabel;
}


@end
