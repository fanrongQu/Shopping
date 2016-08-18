//
//  ShoppingOrderOnlineCell.m
//  Haidao
//
//  Created by 1860 on 16/8/13.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingOrderOnlineCell.h"

@implementation ShoppingOrderOnlineCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"ShoppingOrderOnlineCell";
    ShoppingOrderOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ShoppingOrderOnlineCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

@end
