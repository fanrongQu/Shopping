//
//  ShoppingOrderOnlineCell.h
//  Haidao
//
//  Created by 1860 on 16/7/26.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingOrderOnlineCell;
@protocol ShoppingOrderOnlineCellDelegate <NSObject>

@optional
/**
 *  ShoppingOrderOnlineCell的选择按钮被点击了
 *
 *  @param ShoppingOrderOnlineCell 按钮点击对应的ShoppingOrderOnlineCell
 */
- (void)selectedBtnClickedOfTableViewCell:(ShoppingOrderOnlineCell *)ShoppingOrderOnlineCell selected:(BOOL)selected;

@end

@interface ShoppingOrderOnlineCell : UITableViewCell

/**  cell的indexPath  */
@property (nonatomic, assign) NSIndexPath *indexPath;

/**  选择按钮  */
@property (nonatomic, strong) UIButton *selectedBtn;

/**  代理的对象  */
@property (nonatomic, weak) id<ShoppingOrderOnlineCellDelegate> delegate;

/**
 *  设置cell
 *
 *  @param tableView tableView
 *
 *  @return ShoppingOrderOnlineCell
 */
+ (ShoppingOrderOnlineCell *)cellWithTableView:(UITableView *)tableView;

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
