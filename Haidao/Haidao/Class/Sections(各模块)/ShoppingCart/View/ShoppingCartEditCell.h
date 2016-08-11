//
//  ShoppingCartEditCell.h
//  Haidao
//
//  Created by 1860 on 16/7/27.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingNum.h"

@class ShoppingCartEditCell;
@protocol ShoppingCartEditCellDelegate <NSObject>

@optional
/**
 *  ShoppingCartEditCell的选择按钮被点击了
 *
 *  @param ShoppingCartEditCell 按钮点击对应的ShoppingCartEditCell
 */
- (void)selectedBtnClickedOfEditCell:(ShoppingCartEditCell *)shoppingCartEditCell selected:(BOOL)selected;
/**
 *  商品参数
 */
- (void)parameterButtonClick;

/**
 *  从购物车中移除
 */
- (void)deleteButtonClick;

@end

@interface ShoppingCartEditCell : UITableViewCell

/**  cell的indexPath  */
@property (nonatomic, assign) NSIndexPath *indexPath;

/**  选择按钮  */
@property (nonatomic, strong) UIButton *selectedBtn;

/**  商品数量  */
@property (nonatomic, strong) ShoppingNum *shoppingNum;

/**  是否展示删除按钮  */
@property (nonatomic, assign) BOOL showDeleteBtn;

/**  代理的对象  */
@property (nonatomic, weak) id<ShoppingCartEditCellDelegate> delegate;

/**
 *  设置cell
 *
 *  @param tableView tableView
 *
 *  @return ShoppingCartEditCell
 */
+ (ShoppingCartEditCell *)cellWithTableView:(UITableView *)tableView;

/**
 *  设置cell的数据
 *
 *  @param imageString 商品图片
 *  @param name        商品名称
 *  @param color       商品颜色
 *  @param size        商品尺寸
 *  @param price       商品价格
 *  @param oldPrice    商品市场价格
 *  @param num         商品数量
 */
- (void)setCommodityImage:(NSString *)imageString name:(NSString *)commodityName color:(NSString *)color size:(NSString *)size price:(NSString *)price oldPrice:(NSString *)oldPrice num:(NSString *)num;
@end
