//
//  ShoppingCartHeaderView.h
//  Haidao
//
//  Created by 1860 on 16/7/27.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCartHeaderView;
@protocol ShoppingCartHeaderViewDelegate <NSObject>

@optional

/**
 *  选择按钮被点击了
 *
 *  @param headerView 按钮点击对应的headerView
 */
- (void)selectedBtnClickedOfHeaderView:(ShoppingCartHeaderView *)headerView selected:(BOOL)selected;

/**
 *  店铺名称按钮被点击了
 *
 *  @param headerView 按钮点击对应的headerView
 */
- (void)nameBtnClickedOfHeaderView:(ShoppingCartHeaderView *)headerView;

/**
 *  编辑按钮被点击了
 *
 *  @param headerView 按钮点击对应的headerView
 */
- (void)editBtnClickedOfHeaderView:(ShoppingCartHeaderView *)headerView edit:(BOOL)edit;

@end

@interface ShoppingCartHeaderView : UITableViewHeaderFooterView

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
@property (nonatomic, weak) id<ShoppingCartHeaderViewDelegate> delegate;

@end
