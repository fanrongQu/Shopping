//
//  SelectIndexPath.h
//  Haidao
//
//  Created by 1860 on 16/7/28.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BaseModel.h"

@interface SelectIndexPath : BaseModel

/**  组  */
@property (nonatomic, assign) NSInteger section;
/**  列  */
@property (nonatomic, assign) NSInteger row;

@end
