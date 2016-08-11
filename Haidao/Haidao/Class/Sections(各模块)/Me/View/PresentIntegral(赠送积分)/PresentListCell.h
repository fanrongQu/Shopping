//
//  PresentListCell.h
//  Haidao
//
//  Created by 1860 on 16/8/2.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentListCell : UITableViewCell

+ (PresentListCell *)cellWithTableView:(UITableView *)tableView;

/**
 *  设置cell的数据
 *
 *  @param serialNumber 流水号
 *  @param presentName  受赠人
 *  @param money        金额
 *  @param remarks      备注
 *  @param time         时间
 */
- (void)setSerialNumber:(NSString *)serialNumber presentName:(NSString *)presentName money:(NSString *)money remarks:(NSString *)remarks time:(NSString *)time;

@end
