//
//  ShippingAddressCell.m
//  Haidao
//
//  Created by 1860 on 16/8/19.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShippingAddressCell.h"

@interface ShippingAddressCell ()

/**  姓名  */
@property (nonatomic, strong) UILabel *nameLabel;
/**  电话  */
@property (nonatomic, strong) UILabel *phoneLabel;
/**  地址  */
@property (nonatomic, strong) UILabel *addressLabel;
/**  分割线  */
@property (nonatomic, strong) UIView *cuttingLineView;
/**  删除  */
@property (nonatomic, strong) UIButton *removeBtn;
/**  编辑  */
@property (nonatomic, strong) UIButton *editBtn;
/**  cell的indexPath  */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation ShippingAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"ShippingAddressCell";
    ShippingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ShippingAddressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        __weak typeof(self) weakSelf = self;
        [[self.settingDefaultBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if(weakSelf.settingDefaultBtn.selected) return;
            
            weakSelf.settingDefaultBtn.selected = YES;
            
            if ([weakSelf.delegate respondsToSelector:@selector(setDefaultShippingAddressAtIndexPath:)]) {
                [weakSelf.delegate setDefaultShippingAddressAtIndexPath:weakSelf.indexPath];
            }
            
        }];
        
        
        [[self.removeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([weakSelf.delegate respondsToSelector:@selector(removeShippingAddressAtIndexPath:)]) {
                [weakSelf.delegate removeShippingAddressAtIndexPath:weakSelf.indexPath];
            }
        }];
        
        
        [[self.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if ([weakSelf.delegate respondsToSelector:@selector(editShippingAddressAtIndexPath:)]) {
                [weakSelf.delegate editShippingAddressAtIndexPath:weakSelf.indexPath];
            }
        }];
        
        
    }
    return self;
}

- (void)setShippingAddressName:(NSString *)name phone:(NSString *)phone address:(NSString *)address indexPath:(NSIndexPath *)indexPath {
    
    self.nameLabel.text = name;
    NSString *string1 = [phone substringToIndex:3];
    NSString *string2 = [phone substringFromIndex:phone.length - 4];
    
    self.phoneLabel.text = [NSString stringWithFormat:@"%@****%@",string1,string2];
    self.addressLabel.text = address;
    self.indexPath = indexPath;
}

#pragma mark - 懒加载

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
        }];
        
        _nameLabel.font = kFontSize(16);
    }
    return _nameLabel;
}


- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_phoneLabel];
        __weak typeof(self) weakSelf = self;
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel);
            make.left.mas_equalTo(weakSelf.nameLabel.mas_right).offset(20);
        }];
        
        _phoneLabel.font = kFontSize(16);
    }
    return _phoneLabel;
}


- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_addressLabel];
        __weak typeof(self) weakSelf = self;
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
        
        _addressLabel.font = kFontSize(13);
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}


- (UIView *)cuttingLineView {
    if (!_cuttingLineView) {
        _cuttingLineView = [[UIView alloc]init];
        [self.contentView addSubview:_cuttingLineView];
        __weak typeof(self) weakSelf = self;
        [_cuttingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.addressLabel.mas_bottom).offset(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0.7);
        }];
        _cuttingLineView.backgroundColor = KLineViewColor;
    }
    return _cuttingLineView;
}

- (UIButton *)settingDefaultBtn {
    if (!_settingDefaultBtn) {
        _settingDefaultBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_settingDefaultBtn];
        __weak typeof(self) weakSelf = self;
        [_settingDefaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.cuttingLineView.mas_bottom).offset(10);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(20);
            make.bottom.mas_equalTo(-15);
        }];
        
        _settingDefaultBtn.titleLabel.font = kFontSize(14);
        [_settingDefaultBtn setImage:[UIImage imageNamed:@"default_normal"] forState:UIControlStateNormal];
        [_settingDefaultBtn setImage:[UIImage imageNamed:@"default_selected"] forState:UIControlStateSelected];
        
        [_settingDefaultBtn setTitle:@" 设为默认" forState:UIControlStateNormal];
        [_settingDefaultBtn setTitle:@" 默认地址" forState:UIControlStateSelected];
        
        [_settingDefaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_settingDefaultBtn setTitleColor:kSubjectColor forState:UIControlStateSelected];
    }
    return _settingDefaultBtn;
}

- (UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_removeBtn];
        __weak typeof(self) weakSelf = self;
        [_removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(weakSelf.settingDefaultBtn);
            make.height.mas_equalTo(weakSelf.settingDefaultBtn);
        }];
        
        _removeBtn.titleLabel.font = kFontSize(14);
        [_removeBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_removeBtn setTitle:@" 删除" forState:UIControlStateNormal];
        [_removeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _removeBtn;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_editBtn];
        __weak typeof(self) weakSelf = self;
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.removeBtn.mas_left).offset(-20);
            make.top.mas_equalTo(weakSelf.settingDefaultBtn);
            make.height.mas_equalTo(weakSelf.settingDefaultBtn);
        }];
        
        _editBtn.titleLabel.font = kFontSize(14);
        [_editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [_editBtn setTitle:@" 编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _editBtn;
}



@end
