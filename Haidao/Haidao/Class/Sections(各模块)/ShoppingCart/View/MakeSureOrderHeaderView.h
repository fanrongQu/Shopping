//
//  MakeSureOrderHeaderView.h
//  Haidao
//
//  Created by 1860 on 16/8/21.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeSureOrderHeaderView : UITableViewHeaderFooterView

/**
 *  根据tableView创建headerView
 *
 *  @param tableView  tableView
 *
 *  @return headerView
 */
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

- (void)setMakeSureOrderHeaderViewTitle:(NSString *)title;

@end
