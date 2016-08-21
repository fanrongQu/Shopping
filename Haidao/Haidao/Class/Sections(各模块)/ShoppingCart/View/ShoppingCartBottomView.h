//
//  ShoppingCartBottomView.h
//  Haidao
//
//  Created by 1860 on 16/7/28.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShoppingCartBottomViewDelegate <NSObject>

@optional

/**
 *  全选按钮点击
 */
- (void)selectedBtnClickedOfSelected:(BOOL)selected;

/**
 *  点击结算按钮
 */
- (void)clickSettleAccountsBtn;
/**
 *  点击关注按钮
 */
- (void)clickAttentionButton;
/**
 *  点击删除按钮
 */
- (void)clickRemoveButton;


@end


@interface ShoppingCartBottomView : UIView

/**  选择按钮  */
@property (nonatomic, strong) UIButton *selectedBtn;
/**  编辑状态  */
@property (nonatomic, assign) BOOL isEdit;


- (void)setShoppingCartBottomViewNumber:(NSString *)number allPrice:(NSString *)price;

/**  代理对象  */
@property (nonatomic, weak) id<ShoppingCartBottomViewDelegate> delegate;

@end
