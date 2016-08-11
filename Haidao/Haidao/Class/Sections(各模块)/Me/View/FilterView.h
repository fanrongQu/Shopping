//
//  FilterView.h
//  Haidao
//
//  Created by 1860 on 16/8/3.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterViewDelegate <NSObject>

- (void)filterItemClickWithTitle:(NSString *)title;

@end

@interface FilterView : UIView

/**  筛选选项  */
@property (nonatomic, strong) NSArray *filterArray;

/**  代理对象  */
@property (nonatomic, assign) id<FilterViewDelegate> delegate;

@end
