//
//  RechargeTypeCell.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "RechargeTypeCell.h"

@interface RechargeTypeCell ()

/**  状态标识  */
@property (nonatomic, strong) UIImageView *accessoryImage;

@end

@implementation RechargeTypeCell

+ (instancetype)cellWithTableview:(UITableView *)tableView {
    static NSString *ID = @"RechargeTypeCell";
    RechargeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[RechargeTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setSelectedRecharge:(BOOL)selectedRecharge {
    if (selectedRecharge) {
        [self.accessoryImage setImage:[UIImage imageNamed:@"选中"]];
    }else {
        [self.accessoryImage setImage:[UIImage imageNamed:@"未选中"]];
    }
}

- (UIImageView *)accessoryImage {
    if (!_accessoryImage) {
        _accessoryImage = [[UIImageView alloc]init];
        [self addSubview:_accessoryImage];
        [_accessoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _accessoryImage;
}

@end
