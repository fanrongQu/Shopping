//
//  PersonalBankCardCell.h
//  Haidao
//
//  Created by 1860 on 16/8/19.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalBankCardCellDelegate <NSObject>

@optional

- (void)setDefaultBankCardAtIndexPath:(NSIndexPath *)indexPath;

- (void)removeBankCardAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PersonalBankCardCell : UITableViewCell

/**  默认  */
@property (nonatomic, strong) UIButton *settingDefaultBtn;



+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  设置银行卡信息
 *
 *  @param bankIcon   银行logo
 *  @param bankName   银行名称
 *  @param bankNumber 银行卡号
 */
- (void)setPersonalbankCardIcon:(NSString *)bankIcon bankName:(NSString *)bankName bankNumber:(NSString *)bankNumber indexPath:(NSIndexPath *)indexPath;

/**  代理对象  */
@property (nonatomic, weak) id<PersonalBankCardCellDelegate> delegate;

@end
