//
//  Cell.m
//  着装
//
//  Created by gyh on 15/9/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Cell.h"

@implementation Cell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MXPullDownMenuCell";
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (cell == nil) {
        cell = [[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.backgroundColor = [UIColor whiteColor];
        //cell选中状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setTextColor:[UIColor blackColor]];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}



#pragma mark 重画tableview的线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //    //上分割线，
    //    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    //    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
}


@end
