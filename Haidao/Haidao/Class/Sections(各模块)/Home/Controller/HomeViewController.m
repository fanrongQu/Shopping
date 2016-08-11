//
//  RootViewController.m
//  Haidao
//
//  Created by 1860 on 16/7/7.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "HomeViewController.h"
#import "ADCollectionViewCell.h"
#import "CommodityCollectionViewCell.h"
#import "CommodityViewController.h"
#import "HomeSeleteButton.h"

/** 页边距 */
static CGFloat const edgeDistance = 5;
/** 顶部轮播广告的宽高比 */
static CGFloat const ADCollectionViewWH = 0.55;
/** 顶部轮播广告的最大sections */
static CGFloat const MaxSections = 100;
/**  广告CollectionViewCell标记  */
static NSString * const ADCollectionViewCellID = @"ADCollectionViewCell";

/**  列表视图的collectionReusableView标示符  */
static NSString * const collectionReusableViewHeaderID = @"commodityCollectionReusableViewHeaderID";
/**  商品CollectionViewCell标记  */
static NSString * const commodityCollectionViewCellID = @"CommodityCollectionViewCell";
/** 商品列表CollectionView的宽高比 */
static CGFloat const commodityCollectionViewWH = 1.2;

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**  是否是第一次加载页面 */
@property (nonatomic, assign) BOOL isFirstLoad;

@property (nonatomic, strong) UICollectionView *commodityCollectionView;

@property (nonatomic, strong) UICollectionView *AdCollectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *newses;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HomeViewController


#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在这里设置代理，记得不用的时候需要置nil，否则影响内存的释放
    self.commodityCollectionView.delegate = self;
    self.commodityCollectionView.dataSource = self;
    
    self.AdCollectionView.delegate = self;
    self.AdCollectionView.dataSource = self;
    
    if (!_isFirstLoad) {
        
        self.newses = @[@"轮播1",@"轮播2",@"轮播3",@"轮播4"];
        [self commodityCollectionView];
        
        [self.AdCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:MaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        
        _isFirstLoad = YES;
    }
    //在这里添加定时器，不用的时候移除，节省程序的运行内存
    [self addTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    //不用的时候代理置nil，否则影响内存的释放
    self.commodityCollectionView.delegate = nil;
    self.commodityCollectionView.dataSource = nil;
    
    self.AdCollectionView.delegate = nil;
    self.AdCollectionView.dataSource = nil;
    //在这里移除定时器，节省程序的运行内存
    [self removeTimer];
}


- (void)dealloc {
    if (_commodityCollectionView != nil) _commodityCollectionView = nil;
    
    if (_AdCollectionView != nil) _AdCollectionView = nil;
    
    if (_pageControl != nil) _pageControl = nil;
    
}


// 添加定时器
-(void) addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.6 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 删除定时器
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextpage{
   
    NSIndexPath *currentIndexPath = [[self.AdCollectionView indexPathsForVisibleItems] lastObject];
    //自动滚动时首选滚动回最中间的Item上，保证了最小分组时实现无限滚动效果
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:MaxSections / 2];
    [self.AdCollectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.newses.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.AdCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma mark - 配置UICollectionView的header和footer视图
//设置顶部的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (collectionView == self.commodityCollectionView) {
        return CGSizeMake(kScreenWidth, kScreenWidth * ADCollectionViewWH * 2 + 200);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader && collectionView == _commodityCollectionView){
        
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionReusableViewHeaderID forIndexPath:indexPath];
       
        UIView *headerView = [[UIView alloc] init];
        [reusableview addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        headerView.backgroundColor = [UIColor whiteColor];
        [self setCollectionHeaderViewOfHeaderView:headerView];
        
    }
    return reusableview;
}

/**
 *  设置CollectionView顶部视图
 */
- (void)setCollectionHeaderViewOfHeaderView:(UIView *)headerView {
    //轮播广告
    [headerView addSubview:self.AdCollectionView];
    [_AdCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreenWidth * ADCollectionViewWH);
    }];
    
    [headerView insertSubview:self.pageControl aboveSubview:_AdCollectionView];
    __weak typeof(self) weakSelf = self;
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.AdCollectionView).offset(2);
        make.centerX.mas_equalTo(0);
    }];
    
    CGFloat buttonW = 70;
    CGFloat margin = (kScreenWidth - buttonW * 4) * 0.2;
    
    //热卖商品
    HomeSeleteButton *hotCommodityBtn = [[HomeSeleteButton alloc]init];
    [headerView addSubview:hotCommodityBtn];
    [hotCommodityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.top.mas_equalTo(weakSelf.AdCollectionView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(buttonW, buttonW + 10));
    }];
    [hotCommodityBtn setTitle:@"热卖商品" forState:UIControlStateNormal];
    [hotCommodityBtn setImage:[UIImage imageNamed:@"热卖商品"] forState:UIControlStateNormal];
    [hotCommodityBtn setImage:[UIImage imageNamed:@"热卖商品"] forState:UIControlStateHighlighted];
    
    //新品推荐
    HomeSeleteButton *newsCommodityBtn = [[HomeSeleteButton alloc]init];
    [headerView addSubview:newsCommodityBtn];
    [newsCommodityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hotCommodityBtn.mas_right).offset(margin);
        make.top.mas_equalTo(hotCommodityBtn);
        make.size.mas_equalTo(hotCommodityBtn);
    }];
    [newsCommodityBtn setTitle:@"新品推荐" forState:UIControlStateNormal];
    [newsCommodityBtn setImage:[UIImage imageNamed:@"新品推荐"] forState:UIControlStateNormal];
    [newsCommodityBtn setImage:[UIImage imageNamed:@"新品推荐"] forState:UIControlStateHighlighted];
    
    //促销单品
    HomeSeleteButton *salesCommodityBtn = [[HomeSeleteButton alloc]init];
    [headerView addSubview:salesCommodityBtn];
    [salesCommodityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(newsCommodityBtn.mas_right).offset(margin);
        make.top.mas_equalTo(hotCommodityBtn);
        make.size.mas_equalTo(hotCommodityBtn);
    }];
    [salesCommodityBtn setTitle:@"促销单品" forState:UIControlStateNormal];
    [salesCommodityBtn setImage:[UIImage imageNamed:@"促销单品"] forState:UIControlStateNormal];
    [salesCommodityBtn setImage:[UIImage imageNamed:@"促销单品"] forState:UIControlStateHighlighted];
    
    //猜你喜欢
    HomeSeleteButton *loveCommodityBtn = [[HomeSeleteButton alloc]init];
    [headerView addSubview:loveCommodityBtn];
    [loveCommodityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(salesCommodityBtn.mas_right).offset(margin);
        make.top.mas_equalTo(hotCommodityBtn);
        make.size.mas_equalTo(hotCommodityBtn);
    }];
    [loveCommodityBtn setTitle:@"猜你喜欢" forState:UIControlStateNormal];
    [loveCommodityBtn setImage:[UIImage imageNamed:@"猜你喜欢"] forState:UIControlStateNormal];
    [loveCommodityBtn setImage:[UIImage imageNamed:@"猜你喜欢"] forState:UIControlStateHighlighted];
    
    //活动商品
    UIButton *activityShopBtn = [[UIButton alloc]init];
    [headerView addSubview:activityShopBtn];
    [activityShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kScreenWidth * ADCollectionViewWH);
    }];
    activityShopBtn.backgroundColor = [UIColor greenColor];
}

#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == _AdCollectionView) {
        return MaxSections;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _AdCollectionView) {
        return self.newses.count;
    }
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _AdCollectionView) {
        ADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADCollectionViewCellID forIndexPath:indexPath];
        
        NSString *title = [NSString stringWithFormat:@"%@--%@",self.title,_newses[indexPath.row]];
        [cell setADImage:nil ADtitle:title];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }else {
        CommodityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commodityCollectionViewCellID forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}

#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog_func();
    CommodityViewController *commodityVC = [[CommodityViewController alloc]init];
    [self.navigationController pushViewController:commodityVC animated:YES];
}


#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.AdCollectionView) {//设置页码
        int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.newses.count;
        self.pageControl.currentPage = page;
    }
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.AdCollectionView) {
        [self removeTimer];
    }
}

// 当用户停止的时候调用
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.AdCollectionView) {
        [self addTimer];
    }
}


#pragma mark - 懒加载
- (UICollectionView *)commodityCollectionView {
    if (!_commodityCollectionView) {
       
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemWidth = (kScreenWidth - edgeDistance * 3) * 0.5;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth * commodityCollectionViewWH);
        flowLayout.sectionInset = UIEdgeInsetsMake(edgeDistance, edgeDistance, edgeDistance, edgeDistance);
        flowLayout.minimumLineSpacing = edgeDistance;
        flowLayout.minimumInteritemSpacing = edgeDistance;
        
        _commodityCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _commodityCollectionView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_commodityCollectionView];
        [_commodityCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        //注册cell
        [_commodityCollectionView registerClass:[CommodityCollectionViewCell class] forCellWithReuseIdentifier:commodityCollectionViewCellID];
        
        [_commodityCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionReusableViewHeaderID];
        
    } 
    return _commodityCollectionView;
}

- (UICollectionView *)AdCollectionView {
    if (!_AdCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenWidth * ADCollectionViewWH);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _AdCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _AdCollectionView.pagingEnabled = YES;
        _AdCollectionView.showsHorizontalScrollIndicator = NO;
        _AdCollectionView.bounces = NO;
        //注册cell
        [_AdCollectionView registerClass:[ADCollectionViewCell class] forCellWithReuseIdentifier:ADCollectionViewCellID];
    }
    return _AdCollectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = kSubjectColor;
        _pageControl.enabled = NO;
        _pageControl.numberOfPages = self.newses.count;
    }
    return _pageControl;
}



@end
