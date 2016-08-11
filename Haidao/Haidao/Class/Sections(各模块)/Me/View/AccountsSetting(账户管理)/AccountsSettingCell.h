//
//  AccountsSettingCell.h
//  Haidao
//
//  Created by 1860 on 16/8/5.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountsSettingCell : UITableViewCell

+ (AccountsSettingCell *)cellWithTableView:(UITableView *)tableView;

- (void)setAccountsSettingCellIconImage:(NSString *)imageName;

@end
