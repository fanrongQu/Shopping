//
//  PunctualityProfitsCell.h
//  Haidao
//
//  Created by 1860 on 16/8/2.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PunctualityProfitsCell : UITableViewCell

+ (PunctualityProfitsCell *)cellWithTableView:(UITableView *)tableView;

/**
 *  设置cell的数据
 *
 *  @param serialNumber 流水号
 *  @param type         类型
 *  @param money        金额
 *  @param remarks      备注
 *  @param time         时间
 */
- (void)setSerialNumber:(NSString *)serialNumber type:(NSString *)type money:(NSString *)money remarks:(NSString *)remarks time:(NSString *)time;

@end