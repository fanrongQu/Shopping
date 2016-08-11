//
//  ExpendProfitsViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/2.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ExpendProfitsViewController.h"
#import "PresentButton.h"

#import "OutputProfitsViewController.h"
#import "PunctualityProfitsViewController.h"

@interface ExpendProfitsViewController ()

/**  scrollView  */
@property (nonatomic, strong) UIScrollView *scrollView;
/**  顶部背景  */
@property (nonatomic, strong) UIImageView *bgImageView;
/**  图标  */
@property (nonatomic, strong) UIImageView *iconImageView;
/**  当前积分  */
@property (nonatomic, strong) UILabel *currentIntegralLabel;
/**  当前积分文字  */
@property (nonatomic, strong) UILabel *currentIntegralText;
/**  支出消费让利  */
@property (nonatomic, strong) PresentButton *outputButton;
/**  定返消费让利  */
@property (nonatomic, strong) PresentButton *punctualityButton;

@end

@implementation ExpendProfitsViewController

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费让利额";
    [self bgImageView];
    [self currentIntegralText];
    
    [self setCurrentIntegral:@"10000" outputIntegral:@"2300" ExpendProfits:@"400"];
}

- (void)dealloc {
    if (_scrollView != nil) _scrollView = nil;
    
    if (_bgImageView != nil) _bgImageView = nil;
    
    if (_iconImageView != nil) _iconImageView = nil;
    
    if (_currentIntegralText != nil) _currentIntegralText = nil;
    
    if (_currentIntegralLabel != nil) _currentIntegralLabel = nil;
    
    if (_outputButton != nil) _outputButton = nil;
    
    if (_punctualityButton != nil) _punctualityButton = nil;
}

- (void)setCurrentIntegral:(NSString *)currentIntegral outputIntegral:(NSString *)outputIntegral ExpendProfits:(NSString *)ExpendProfits {
    
    self.currentIntegralLabel.text = currentIntegral;
    [self.outputButton setPresentNumber:currentIntegral type:@"支出消费让利额"];
    [self.punctualityButton setPresentNumber:ExpendProfits type:@"定返消费让利额"];
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _scrollView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        [self.scrollView addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 140));
        }];
        [_bgImageView setImage:[UIImage imageNamed:@"bg"]];
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        [self.bgImageView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.size.mas_equalTo(50);
            make.centerY.mas_equalTo(0);
        }];
        [_iconImageView setImage:[UIImage imageNamed:@"refundable"]];
    }
    return _iconImageView;
}

- (UILabel *)currentIntegralLabel {
    if (!_currentIntegralLabel) {
        _currentIntegralLabel = [[UILabel alloc]init];
        [self.scrollView addSubview:_currentIntegralLabel];
        __weak typeof(self) weakSelf = self;
        [_currentIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.iconImageView);
            make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(12);
        }];
        _currentIntegralLabel.font = kFontSize(20);
        _currentIntegralLabel.textColor = [UIColor whiteColor];
    }
    return _currentIntegralLabel;
}

- (UILabel *)currentIntegralText {
    if (!_currentIntegralText) {
        _currentIntegralText = [[UILabel alloc]init];
        [self.scrollView addSubview:_currentIntegralText];
        __weak typeof(self) weakSelf = self;
        [_currentIntegralText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.iconImageView);
            make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(12);
        }];
        _currentIntegralText.font = kFontSize(12);
        _currentIntegralText.text = @"总让利额";
        _currentIntegralText.textColor = [UIColor whiteColor];
    }
    return _currentIntegralText;
}

/**
 *  支出消费让利按钮
 */
- (PresentButton *)outputButton {
    if (!_outputButton) {
        _outputButton = [[PresentButton alloc]init];
        [self.scrollView addSubview:_outputButton];
        __weak typeof(self) weakSelf = self;
        [_outputButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.bgImageView.mas_bottom);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.5, 120));
            make.bottom.mas_equalTo(0);
        }];
        _outputButton.backgroundColor = [UIColor whiteColor];
        
        [[_outputButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            OutputProfitsViewController *outputProfitsVC = [[OutputProfitsViewController alloc]init];
            [self.navigationController pushViewController:outputProfitsVC animated:YES];
        }];
    }
    return _outputButton;
}

/**
 *  定返消费让利按钮
 */
- (PresentButton *)punctualityButton {
    if (!_punctualityButton) {
        _punctualityButton = [[PresentButton alloc]init];
        [self.scrollView addSubview:_punctualityButton];
        __weak typeof(self) weakSelf = self;
        [_punctualityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.outputButton);
            make.left.mas_equalTo(weakSelf.outputButton.mas_right).offset(1.0);
            make.size.mas_equalTo(weakSelf.outputButton);
        }];
        _punctualityButton.backgroundColor = [UIColor whiteColor];
        
        [[_punctualityButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            PunctualityProfitsViewController *punctualityProfitsVC = [[PunctualityProfitsViewController alloc]init];
            [self.navigationController pushViewController:punctualityProfitsVC animated:YES];
        }];
    }
    return _punctualityButton;
}

@end

