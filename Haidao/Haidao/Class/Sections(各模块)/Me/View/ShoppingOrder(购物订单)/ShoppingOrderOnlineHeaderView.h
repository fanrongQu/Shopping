//
//  ShoppingOrderOnlineHeaderView.h
//  Haidao
//
//  Created by 1860 on 16/8/19.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingOrderOnlineHeaderView;
@protocol ShoppingOrderOnlineHeaderViewDelegate <NSObject>

@optional

/**
 *  店铺名称按钮被点击了
 *
 *  @param headerView 按钮点击对应的headerView
 */
- (void)nameBtnClickedOfHeaderView:(ShoppingOrderOnlineHeaderView *)headerView;


@end

@interface ShoppingOrderOnlineHeaderView : UITableViewHeaderFooterView

/**
 *  根据tableView创建headerView
 *
 *  @param tableView  tableView
 *
 *  @return headerView
 */
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

- (void)setShoppingOrderOnlineHeaderViewTitle:(NSString *)title state:(NSString *)state section:(NSInteger)section;

/**  代理的对象  */
@property (nonatomic, weak) id<ShoppingOrderOnlineHeaderViewDelegate> delegate;

@end

