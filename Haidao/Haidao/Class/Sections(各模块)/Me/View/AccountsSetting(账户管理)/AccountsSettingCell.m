//
//  AccountsSettingCell.m
//  Haidao
//
//  Created by 1860 on 16/8/5.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "AccountsSettingCell.h"

@interface AccountsSettingCell ()

/**  头像  */
@property (nonatomic, strong) UIImageView *iconImage;

@end

@implementation AccountsSettingCell


+ (AccountsSettingCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"AccountsSettingCell";
    AccountsSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AccountsSettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = kFontSize(15);
        cell.detailTextLabel.font = kFontSize(14);
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.iconImage.hidden = YES;
    
    return cell;
}

- (void)setAccountsSettingCellIconImage:(NSString *)imageName {
    self.iconImage.image = [UIImage imageNamed:imageName];
    self.iconImage.hidden = NO;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-5);
            make.size.mas_equalTo(30);
        }];
        [_iconImage.layer setMasksToBounds:YES];
        [_iconImage.layer setCornerRadius:15];
        _iconImage.backgroundColor = [UIColor redColor];
    }
    return _iconImage;
}

@end
