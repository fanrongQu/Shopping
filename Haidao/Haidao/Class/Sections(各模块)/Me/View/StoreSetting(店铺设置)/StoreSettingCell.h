//
//  StoreSettingCell.h
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreSettingCell : UITableViewCell

/**  标题  */
@property (nonatomic, strong) UILabel *titleLabel;
/**  简述  */
@property (nonatomic, strong) UILabel *detailLabel;
/**  头像  */
@property (nonatomic, strong) UIImageView *iconImageView;
/**  描述  */
@property (nonatomic, strong) UILabel *describeLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
