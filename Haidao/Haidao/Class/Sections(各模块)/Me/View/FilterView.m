//
//  FilterView.m
//  Haidao
//
//  Created by 1860 on 16/8/3.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FilterView.h"
#import "FilterButton.h"

@interface FilterView ()

/**  上一个选中的按钮  */
@property (nonatomic, strong) FilterButton *lastSelectedBtn;

@end

@implementation FilterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kUIColor_RGB(100, 100, 100, 0.6);
    }
    return self;
}

- (void)setFilterArray:(NSArray *)filterArray {
    if (!_filterArray) {
        _filterArray = filterArray;
        
        NSInteger count = filterArray.count;
        
        CGFloat btnH = 50;
        CGFloat btnW = kScreenWidth;
        
        for (NSInteger n = 0; n < count; n++) {
            FilterButton *filterButton = [[FilterButton alloc]initWithFrame:CGRectMake(0, (btnH + 0.6) * n + 64, btnW, btnH)];
            NSString *title = filterArray[n];
            [filterButton setTitle:title forState:UIControlStateNormal];
            
            [self addSubview:filterButton];
            
            [[filterButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                self.lastSelectedBtn.selectedImage.hidden = YES;
                self.lastSelectedBtn.selected = NO;
                filterButton.selectedImage.hidden = NO;
                filterButton.selected = YES;
                self.lastSelectedBtn = filterButton;
                if ([self.delegate respondsToSelector:@selector(filterItemClickWithTitle:)]) {
                    [self.delegate filterItemClickWithTitle:title];
                }
            }];
        }
    }
}

@end
