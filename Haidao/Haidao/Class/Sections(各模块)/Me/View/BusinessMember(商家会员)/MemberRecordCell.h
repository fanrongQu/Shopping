//
//  MemberRecordCell.h
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MemberRecordCell : UITableViewCell

+ (MemberRecordCell *)cellWithTableView:(UITableView *)tableView;

/**
 *  设置cell的数据
 *
 *  @param serialNumber 手机号码
 *  @param type         真实姓名
 *  @param money        会员编号
 *  @param remarks      会员等级
 *  @param time         注册时间
 */
- (void)setTelephone:(NSString *)telephone trueName:(NSString *)trueName memberNumber:(NSString *)memberNumber memberType:(NSString *)memberType time:(NSString *)time;

@end