//
//  NearBusinessViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/11.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "NearBusinessViewController.h"
#import "NearBusinessCollectionViewCell.h"
#import "BusinessMessageView.h"


/** 顶部轮播广告的宽高比 */
static CGFloat const NearBusinessImgCollectionViewWH = 0.55;
/** 顶部轮播广告的最大sections */
static CGFloat const MaxSections = 1;
/**  广告CollectionViewCell标记  */
static NSString * const NearBusinessCollectionViewCellID = @"NearBusinessCollectionViewCell";

@interface NearBusinessViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/**  分页显示商品展示和图文详情页  */
@property (nonatomic, strong) UIScrollView *scrollView;
/**  商品图片浏览  */
@property (nonatomic, strong) UICollectionView *nearBusinessImgCollectionView;
/**  商品图片展示pageControl  */
@property (nonatomic, strong) UIPageControl *pageControl;
/**  商品图片数组  */
@property (nonatomic, strong) NSArray *imgArray;
/**  商家信息  */
@property (nonatomic, strong) BusinessMessageView *businessMessageView;

@end

@implementation NearBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家详情";
    self.imgArray = @[@"轮播1",@"轮播2",@"轮播3",@"轮播4"];
    [self pageControl];
    
    [self.businessMessageView setBusinessMessageViewTitle:@"多美奇（中达店）" address:@"河南省南阳市卧龙区中达路" distance:@"110.0" introduction:@"百度网盘为您提供文件的网络备份、同步和分享服务。空间大、速度快、安全稳固,支持教育网加速,支持手机端。现在注册即有机会享受15G的免费存储空间百度网盘为您提供文件的网络备份、同步和分享服务。空间大、速度快、安全稳固,支持教育网加速,支持手机端。现在注册即有机会享受15G的免费存储空间" phone:@"15888888888" browseNum:@"100000"];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scrollView.delegate = self;
    
    self.nearBusinessImgCollectionView.delegate = self;
    self.nearBusinessImgCollectionView.dataSource = self;
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.scrollView.delegate = nil;
    
    self.nearBusinessImgCollectionView.delegate = nil;
    self.nearBusinessImgCollectionView.dataSource = nil;
    
}


- (void)dealloc {
    
    if (_scrollView != nil) _scrollView = nil;
    
    if (_nearBusinessImgCollectionView != nil) _nearBusinessImgCollectionView = nil;
    
    if (_pageControl != nil) _pageControl = nil;
    
}



#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == _nearBusinessImgCollectionView) {
        return MaxSections;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _nearBusinessImgCollectionView) {
        return self.imgArray.count;
    }
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _nearBusinessImgCollectionView) {
        NearBusinessCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NearBusinessCollectionViewCellID forIndexPath:indexPath];
        
        NSString *title = [NSString stringWithFormat:@"%@--%@",self.title,_imgArray[indexPath.row]];
        //        [cell setADImage:nil ADtitle:title];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }else {
        
        return nil;
    }
}

#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog_func();
    //    NearBusinessViewController *NearBusinessVC = [[NearBusinessViewController alloc]init];
    //    [self.navigationController pushViewController:NearBusinessVC animated:YES];
}


#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.nearBusinessImgCollectionView) {//设置页码
        int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.imgArray.count;
        self.pageControl.currentPage = page;
    }
}


#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-49);
        }];
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}


- (UICollectionView *)nearBusinessImgCollectionView {
    if (!_nearBusinessImgCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenWidth * NearBusinessImgCollectionViewWH);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _nearBusinessImgCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.scrollView addSubview:_nearBusinessImgCollectionView];
        [_nearBusinessImgCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(kScreenWidth * NearBusinessImgCollectionViewWH);
        }];
        
        _nearBusinessImgCollectionView.backgroundColor = [UIColor whiteColor];
        _nearBusinessImgCollectionView.pagingEnabled = YES;
        _nearBusinessImgCollectionView.showsHorizontalScrollIndicator = NO;
        _nearBusinessImgCollectionView.bounces = NO;
        //注册cell
        [_nearBusinessImgCollectionView registerClass:[NearBusinessCollectionViewCell class] forCellWithReuseIdentifier:NearBusinessCollectionViewCellID];
    }
    return _nearBusinessImgCollectionView;
}


- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        
        [self.scrollView insertSubview:_pageControl aboveSubview:self.nearBusinessImgCollectionView];
        __weak typeof(self) weakSelf = self;
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.nearBusinessImgCollectionView).offset(-2);
            make.right.mas_equalTo(weakSelf.nearBusinessImgCollectionView).offset(-15);
        }];
        
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = kSubjectColor;
        _pageControl.enabled = NO;
        _pageControl.numberOfPages = self.imgArray.count;
    }
    return _pageControl;
}

- (BusinessMessageView *)businessMessageView {
    if (!_businessMessageView) {
        _businessMessageView = [[BusinessMessageView alloc]init];
        [self.scrollView addSubview:_businessMessageView];
        __weak typeof(self) weakSelf = self;
        [_businessMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nearBusinessImgCollectionView.mas_bottom).offset(15);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(weakSelf.nearBusinessImgCollectionView);
        }];
        
    }
    return _businessMessageView;
}


@end

