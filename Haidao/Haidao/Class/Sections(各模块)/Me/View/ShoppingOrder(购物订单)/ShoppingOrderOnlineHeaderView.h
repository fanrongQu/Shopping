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
 *  选择按钮被点击了
 *
 *  @param headerView 按钮点击对应的headerView
 */
- (void)selectedBtnClickedOfHeaderView:(ShoppingOrderOnlineHeaderView *)headerView selected:(BOOL)selected;

/**
 *  店铺名称按钮被点击了
 *
 *  @param headerView 按钮点击对应的headerView
 */
- (void)nameBtnClickedOfHeaderView:(ShoppingOrderOnlineHeaderView *)headerView;

/**
 *  编辑按钮被点击了
 *
 *  @param headerView 按钮点击对应的headerView
 */
- (void)editBtnClickedOfHeaderView:(ShoppingOrderOnlineHeaderView *)headerView edit:(BOOL)edit;

@end

@interface ShoppingOrderOnlineHeaderView : UITableViewHeaderFooterView

/**  店铺名  */
@property (nonatomic, copy) NSString *titleName;
/**  headerView的序号  */
@property (nonatomic, assign) NSInteger section;
/**  选择按钮  */
@property (nonatomic, strong) UIButton *selectedBtn;
/**  编辑按钮  */
@property (nonatomic, strong) UIButton *editBtn;

/**
 *  根据tableView创建headerView
 *
 *  @param tableView  tableView
 *
 *  @return headerView
 */
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

/**  代理的对象  */
@property (nonatomic, weak) id<ShoppingOrderOnlineHeaderViewDelegate> delegate;

@end

