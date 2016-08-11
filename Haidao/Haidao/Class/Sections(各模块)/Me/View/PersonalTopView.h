//
//  PersonalTopView.h
//  Haidao
//
//  Created by 1860 on 16/7/17.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PersonalTopViewType) {
    /**   头像   */
    PersonalTopViewIconType = 0,
    /**   等级   */
    PersonalTopViewGradeType,
    /**   积分   */
    PersonalTopViewEmpiricalType,
    /**   设置   */
    PersonalTopViewSettingType,
    
};

@protocol PersonalTopViewDelegate <NSObject>

@optional
- (void)personalTopViewClickButtonWithType:(PersonalTopViewType)type;

@end

@interface PersonalTopView : UIView

/**
 *  设置基本信息
 *
 *  @param iconImage      头像
 *  @param name           用户名
 *  @param gradeType      用户等级
 *  @param empiricalValue 用户积分
 */
- (void)setPersonalIcon:(NSString *)iconImage name:(NSString *)name gradeType:(NSString *)gradeType empiricalValue:(NSString *)empiricalValue;

/**  代理对象  */
@property (nonatomic, weak) id<PersonalTopViewDelegate> delegate;

@end
