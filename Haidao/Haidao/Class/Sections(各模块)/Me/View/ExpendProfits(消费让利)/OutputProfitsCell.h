//
//  OutputProfitsCell.h
//  Haidao
//
//  Created by 1860 on 16/8/2.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutputProfitsCell : UITableViewCell


+ (OutputProfitsCell *)cellWithTableView:(UITableView *)tableView;

/**
 *  设置OutputProfitsCell的数据
 *
 *  @param serialNumber   订单号
 *  @param type           消费类别
 *  @param consumerName   消费者姓名
 *  @param commodity      购买商品
 *  @param expendMoney    消费金额
 *  @param cuttingProfits 让利金额
 *  @param time           时间
 */
- (void)setReceiveListOfSerialNumber:(NSString *)serialNumber type:(NSString *)type consumerName:(NSString *)consumerName commodity:(NSString *)commodity expendMoney:(NSString *)expendMoney cuttingProfits:(NSString *)cuttingProfits time:(NSString *)time;

@end
