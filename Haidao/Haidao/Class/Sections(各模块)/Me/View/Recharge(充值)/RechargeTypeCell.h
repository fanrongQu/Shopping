//
//  RechargeTypeCell.h
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeTypeCell : UITableViewCell

/**  选中类型  */
@property (nonatomic, assign) BOOL selectedRecharge;

+ (instancetype)cellWithTableview:(UITableView *)tableView;

@end
