//
//  PresentIntegralViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "PresentIntegralViewController.h"
#import "PresentButton.h"
#import "PresentListViewController.h"
#import "ReceiveListViewController.h"

@interface PresentIntegralViewController ()

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
/**  获赠积分  */
@property (nonatomic, strong) PresentButton *receiveButton;
/**  增出积分  */
@property (nonatomic, strong) PresentButton *presentButton;

@end

@implementation PresentIntegralViewController

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赠送积分";
    [self bgImageView];
    [self currentIntegralText];
    
    [self setCurrentIntegral:@"10000" receiveIntegral:@"2300" presentIntegral:@"400"];
}

- (void)dealloc {
    if (_scrollView != nil) _scrollView = nil;
    
    if (_bgImageView != nil) _bgImageView = nil;
    
    if (_iconImageView != nil) _iconImageView = nil;
    
    if (_currentIntegralText != nil) _currentIntegralText = nil;
    
    if (_currentIntegralLabel != nil) _currentIntegralLabel = nil;
    
    if (_receiveButton != nil) _receiveButton = nil;
    
    if (_presentButton != nil) _presentButton = nil;
}

- (void)setCurrentIntegral:(NSString *)currentIntegral receiveIntegral:(NSString *)receiveIntegral presentIntegral:(NSString *)presentIntegral {
    
    self.currentIntegralLabel.text = currentIntegral;
    [self.receiveButton setPresentNumber:receiveIntegral type:@"获赠积分"];
    [self.presentButton setPresentNumber:presentIntegral type:@"赠出积分"];
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
        _currentIntegralText.text = @"当前积分";
        _currentIntegralText.textColor = [UIColor whiteColor];
    }
    return _currentIntegralText;
}

/**
 *  获赠积分按钮
 */
- (PresentButton *)receiveButton {
    if (!_receiveButton) {
        _receiveButton = [[PresentButton alloc]init];
        [self.scrollView addSubview:_receiveButton];
        __weak typeof(self) weakSelf = self;
        [_receiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.bgImageView.mas_bottom);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.5, 120));
            make.bottom.mas_equalTo(0);
        }];
        _receiveButton.backgroundColor = [UIColor whiteColor];
        
        [[_receiveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            ReceiveListViewController *receiveListVC = [[ReceiveListViewController alloc]init];
            [self.navigationController pushViewController:receiveListVC animated:YES];
        }];
    }
    return _receiveButton;
}

/**
 *  赠出积分按钮
 */
- (PresentButton *)presentButton {
    if (!_presentButton) {
        _presentButton = [[PresentButton alloc]init];
        [self.scrollView addSubview:_presentButton];
        __weak typeof(self) weakSelf = self;
        [_presentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.receiveButton);
            make.left.mas_equalTo(weakSelf.receiveButton.mas_right).offset(1.0);
            make.size.mas_equalTo(weakSelf.receiveButton);
        }];
        _presentButton.backgroundColor = [UIColor whiteColor];
        
        [[_presentButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            PresentListViewController *presentListVC = [[PresentListViewController alloc]init];
            [self.navigationController pushViewController:presentListVC animated:YES];
        }];
    }
    return _presentButton;
}

@end
