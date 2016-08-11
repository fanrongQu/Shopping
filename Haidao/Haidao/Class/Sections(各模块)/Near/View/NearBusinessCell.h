//
//  NearBusinessCell.h
//  Haidao
//
//  Created by 1860 on 16/8/11.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearBusinessCell : UITableViewCell

+ (NearBusinessCell *)cellWithTableView:(UITableView *)tableView;

- (void)setNearBusinessCellImage:(NSString *)imageName name:(NSString *)name distance:(NSString *)distance address:(NSString *)address browseNumber:(NSString *)browseNumber;

@end
