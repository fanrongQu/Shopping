//
//  MakeSureOrderHeaderView.m
//  Haidao
//
//  Created by 1860 on 16/7/27.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MakeSureOrderHeaderView.h"

@interface MakeSureOrderHeaderView ()

/**  背景  */
@property (nonatomic, strong) UIView *bgView;
/**  headerView的序号  */
@property (nonatomic, assign) NSInteger section;
/**  店铺名称按钮  */
@property (nonatomic, strong) UIButton *nameBtn;
/**  导向箭头图片  */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MakeSureOrderHeaderView


+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MakeSureOrderHeaderView";
    MakeSureOrderHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[MakeSureOrderHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self imageView];
        
    }
    return self;
}

- (void)setMakeSureOrderHeaderViewTitle:(NSString *)title{
    
    [self.nameBtn setTitle:title forState:UIControlStateNormal];
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


@end
