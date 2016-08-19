//
//  ShoppingCartViewController.m
//  Haidao
//
//  Created by 1860 on 16/7/15.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartHeaderView.h"
#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartEditCell.h"
#import "ShoppingCartBottomView.h"

#import "SelectIndexPath.h"

@interface ShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate,ShoppingCartHeaderViewDelegate,ShoppingCartTableViewCellDelegate,ShoppingCartEditCellDelegate,ShoppingNumDelegate,ShoppingCartBottomViewDelegate>

/**  购物车商品列表  */
@property (nonatomic, strong) UITableView *tableView;
///**  选中的商品Section数组  */
//@property (nonatomic, strong) NSMutableArray *selectedSectionArray;
/**  选中的商品indexPath数组  */
@property (nonatomic, strong) NSMutableArray *selectedIndexPathArray;
/**  进入编辑状态的Section数组  */
@property (nonatomic, strong) NSMutableArray *editSectionArray;
/**  底部视图  */
@property (nonatomic, strong) ShoppingCartBottomView *bottomView;
/**  全部进入编辑状态  */
@property (nonatomic, assign) BOOL shoppingCartIsEdit;

/**  购物车数据  */
@property (nonatomic, strong) NSMutableArray *shoppingCartArray;

@end

@implementation ShoppingCartViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self bottomView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)dealloc {
    
    if (_tableView != nil) _tableView = nil;
    if (_selectedIndexPathArray != nil) _selectedIndexPathArray = nil;
    if (_editSectionArray != nil) _editSectionArray = nil;
    if (_bottomView != nil) _bottomView = nil;
    if (_shoppingCartArray != nil) _shoppingCartArray = nil;
}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)rightBarButtonItem {
    if ([rightBarButtonItem.title isEqualToString:@"编辑"]) {
        rightBarButtonItem.title = @"完成";
        self.bottomView.isEdit = YES;
        //全部进入编辑状态
        self.shoppingCartIsEdit = YES;
    }else {
        rightBarButtonItem.title = @"编辑";
        self.bottomView.isEdit = NO;
        //全部退出编辑状态
        self.shoppingCartIsEdit = NO;
    }
    [self.tableView reloadData];
}

/**
 *  判断全选按钮是否是全选状态
 */
- (void)bottomViewSelected {
    NSInteger count = self.shoppingCartArray.count;
    NSInteger selSectionNum = 0;
    for (int n = 0; n < count; n++) {
        NSArray *cartArray = self.shoppingCartArray[n];
        NSInteger selectCount = 0;
        for (SelectIndexPath *selectIndexPath in self.selectedIndexPathArray) {
            if (selectIndexPath.section == n) selectCount ++;
        }
        if (selectCount == cartArray.count) selSectionNum ++;
        
    }
    if (selSectionNum == count) {
        self.bottomView.selectedBtn.selected = YES;
    }else {
        self.bottomView.selectedBtn.selected = NO;
    }
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.shoppingCartArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = self.shoppingCartArray[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (self.shoppingCartIsEdit) {//全部进入编辑状态
        ShoppingCartEditCell *cell = [ShoppingCartEditCell cellWithTableView:tableView];
        cell.showDeleteBtn = NO;
        
        cell.delegate = self;
        cell.shoppingNum.delegate = self;
        cell.indexPath = indexPath;
        cell.selectedBtn.selected = NO;
        
        for (SelectIndexPath *IndexPath in self.selectedIndexPathArray) {
            if (IndexPath.section == section && IndexPath.row == row) {
                cell.selectedBtn.selected = YES;
            }
        }
        
        [cell setCommodityImage:nil name:@"2016新款韩版时尚夏季衬衣新款韩版时尚夏季衬衣" color:@"白色" size:@"XL" price:@"120" oldPrice:@"130" num:@"2"];
        
        return cell;
    }
    
    for (NSString *editSection in self.editSectionArray) {//部分组进入编辑状态
        if (indexPath.section == [editSection integerValue]) {
            ShoppingCartEditCell *cell = [ShoppingCartEditCell cellWithTableView:tableView];
            cell.showDeleteBtn = YES;
            
            cell.delegate = self;
            cell.shoppingNum.delegate = self;
            cell.indexPath = indexPath;
            cell.selectedBtn.selected = NO;
            
            for (SelectIndexPath *IndexPath in self.selectedIndexPathArray) {
                if (IndexPath.section == section && IndexPath.row == row) {
                    cell.selectedBtn.selected = YES;
                }
            }
            
            [cell setCommodityImage:nil name:@"2016新款韩版时尚夏季衬衣新款韩版时尚夏季衬衣" color:@"白色" size:@"XL" price:@"120" oldPrice:@"130" num:@"2"];
            
            return cell;
        }
    }
    
    //非编辑状态
    ShoppingCartTableViewCell *cell = [ShoppingCartTableViewCell cellWithTableView:tableView];
    
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.selectedBtn.selected = NO;
   
    for (SelectIndexPath *IndexPath in self.selectedIndexPathArray) {
        if (IndexPath.section == section && IndexPath.row == row) {
            cell.selectedBtn.selected = YES;
        }
    }
    
    [cell setCommodityImage:nil name:@"2016新款韩版时尚夏季衬衣新款韩版时尚夏季衬衣" color:@"白色" size:@"XL" price:@"120" oldPrice:@"130" num:@"2"];
    
    return cell;
}


#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ShoppingCartHeaderView *headerView = [ShoppingCartHeaderView headerViewWithTableView:tableView];
    headerView.titleName = @"汇佰硕电子商行";
    headerView.section = section;
    headerView.delegate = self;
    headerView.selectedBtn.selected = NO;
    headerView.editBtn.selected = NO;
    
   //计算哪一组是全部选中状态并设置headerView的selectedBtn的状态
    NSArray *cartArray = self.shoppingCartArray[section];
    NSInteger cartCount = cartArray.count;
    NSInteger selectCount = 0;
    for (SelectIndexPath *IndexPath in self.selectedIndexPathArray) {
        if (IndexPath.section == section) {
            selectCount++;
        }
    }
    if (selectCount == cartCount) headerView.selectedBtn.selected = YES;
    
    for (NSString *editSection in self.editSectionArray) {
        if (section == [editSection integerValue]) {//部分组进入编辑状态下的headerView的编辑按钮状态
            headerView.editBtn.selected = YES;
        }
    }
    
    if (self.shoppingCartIsEdit) {//全部进入编辑状态
        headerView.editBtn.selected = NO;
        headerView.editBtn.hidden = YES;
        [self.editSectionArray removeAllObjects];
    }else {
        headerView.editBtn.hidden = NO;
    }

    return headerView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.shoppingCartIsEdit;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除cell");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - ShoppingCartTableViewCell delegate
/**
 *  ShoppingCartTableViewCell的选择按钮被点击了
 */
- (void)selectedBtnClickedOfTableViewCell:(ShoppingCartTableViewCell *)shoppingCartTableViewCell selected:(BOOL)selected {
    NSIndexPath *indexPath = shoppingCartTableViewCell.indexPath;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    SelectIndexPath *selectIndexPath = [[SelectIndexPath alloc]init];
    selectIndexPath.section = section;
    selectIndexPath.row = row;
    
    if (selected) {
        NSLog(@"选中%ld组%ld列",(long)indexPath.section,(long)indexPath.row);
        [self.selectedIndexPathArray addObject:selectIndexPath];
    }else {
        NSLog(@"取消选中%ld组%ld列",(long)indexPath.section,(long)indexPath.row);
        
        NSArray *selectArray = [NSArray arrayWithArray:self.selectedIndexPathArray];
        for (SelectIndexPath *IndexPath in selectArray) {
            if (IndexPath.section == section && IndexPath.row == row) {
                [self.selectedIndexPathArray removeObject:IndexPath];
            }
        }
    }
    [self bottomViewSelected];
    [self.tableView reloadData];
}

#pragma mark - ShoppingCartEditCell delegate
- (void)selectedBtnClickedOfEditCell:(ShoppingCartEditCell *)shoppingCartEditCell selected:(BOOL)selected {
    NSIndexPath *indexPath = shoppingCartEditCell.indexPath;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    SelectIndexPath *selectIndexPath = [[SelectIndexPath alloc]init];
    selectIndexPath.section = section;
    selectIndexPath.row = row;
    
    if (selected) {
        NSLog(@"选中%ld组%ld列",(long)indexPath.section,(long)indexPath.row);
        [self.selectedIndexPathArray addObject:selectIndexPath];
    }else {
        NSLog(@"取消选中%ld组%ld列",(long)indexPath.section,(long)indexPath.row);
        
        NSArray *selectArray = [NSArray arrayWithArray:self.selectedIndexPathArray];
        for (SelectIndexPath *IndexPath in selectArray) {
            if (IndexPath.section == section && IndexPath.row == row) {
                [self.selectedIndexPathArray removeObject:IndexPath];
            }
        }
    }
    [self bottomViewSelected];
    [self.tableView reloadData];
}

/**
 *  商品参数
 */
- (void)parameterButtonClick {
    NSLog(@"修改商品参数");
}

/**
 *  从购物车中移除
 */
- (void)deleteButtonClick {
    NSLog(@"从购物车移除商品");
}

#pragma mark - ShoppingCartHeaderView delegate
/**
 *  选择按钮被点击了
 */
- (void)selectedBtnClickedInSection:(NSInteger)section selected:(BOOL)selected {
    
    NSLog(@"%ld",(long)section);
    
    NSArray *selectArray = self.shoppingCartArray[section];
    NSInteger count = selectArray.count;
    
    //移除该分组下的所有数据
    NSArray *array = [NSArray arrayWithArray:self.selectedIndexPathArray];
    for (SelectIndexPath *IndexPath in array) {
        if (IndexPath.section == section) {
            [self.selectedIndexPathArray removeObject:IndexPath];
        }
    }
    
    if (selected) {
        for (int n = 0; n < count; n++) {//添加选中分组到selectedIndexPathArray
            SelectIndexPath *selectIndexPath = [[SelectIndexPath alloc]init];
            selectIndexPath.section = section;
            selectIndexPath.row = n;
            [self.selectedIndexPathArray addObject:selectIndexPath];
        }
        
    }
    
    [self bottomViewSelected];
    [self.tableView reloadData];
}

/**
 *  店铺名称按钮被点击了
 */
- (void)nameBtnClickedInSection:(NSInteger)section {
    
}

/**
 *  编辑按钮被点击了
 */
- (void)editBtnClickedInSection:(NSInteger)section edit:(BOOL)edit {
    
    if (edit) {
        NSLog(@"第%ld组进入编辑状态",(long)section);
        [self.editSectionArray addObject:[NSString stringWithFormat:@"%ld",section]];
    }else {
        NSLog(@"第%ld组移除编辑状态",(long)section);
        [self.editSectionArray removeObject:[NSString stringWithFormat:@"%ld",section]];
    }
    [self.tableView reloadData];
}


#pragma mark - ShoppingCartBottomView delegate
/**
 *  点击了全选按钮
 */
- (void)selectedBtnClickedOfSelected:(BOOL)selected {
    
    [self.selectedIndexPathArray removeAllObjects];
    if (selected) {
        NSLog(@"点击了全选按钮,全部选中");
        NSInteger count = self.shoppingCartArray.count;
        
        for (int n = 0; n < count; n++) {
            
            NSArray *selectArray = self.shoppingCartArray[n];
            NSInteger num = selectArray.count;
            for (int m = 0; m < num; m++) {
                
                SelectIndexPath *selectIndexPath = [[SelectIndexPath alloc]init];
                selectIndexPath.section = n;
                selectIndexPath.row = m;
                [self.selectedIndexPathArray addObject:selectIndexPath];
            }
        }
        
    }else {
        NSLog(@"再次点击了全选按钮,全部取消选中");
    }
    [self.tableView reloadData];
}
/**
 *  点击结算按钮
 */
- (void)clickSettleAccountsBtn {
    NSLog(@"点击了结算按钮");
}

/**
 *  点击关注按钮
 */
- (void)clickAttentionButton {
    NSLog(@"点击了关注按钮");
    
}
/**
 *  点击删除按钮
 */
- (void)clickRemoveButton {
    NSLog(@"点击了删除按钮");
}

#pragma mark - ShoppingNum delegate
- (void)actionMessage:(NSString *)message {
    if (message.length > 0) {
        NSLog(@"警告信息：%@",message);
    }
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 49, 0));
        }];
        
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}


- (NSMutableArray *)selectedIndexPathArray {
    if (!_selectedIndexPathArray) {
        _selectedIndexPathArray = [NSMutableArray array];
    }
    return _selectedIndexPathArray;
}

- (NSMutableArray *)editSectionArray {
    if (!_editSectionArray) {
        _editSectionArray = [NSMutableArray array];
    }
    return _editSectionArray;
}

- (ShoppingCartBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ShoppingCartBottomView alloc]init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-49);
            make.height.mas_equalTo(49);
        }];
        
        _bottomView.delegate = self;
        _bottomView.isEdit = NO;
    }
    return _bottomView;
}

- (NSMutableArray *)shoppingCartArray {
    if (!_shoppingCartArray) {
        _shoppingCartArray = [NSMutableArray array];
        NSArray *array = @[@[@"1",@"1",@"1"],@[@"1",@"1"],@[@"1",@"1",@"1",@"1"]];
        [_shoppingCartArray addObjectsFromArray:array];
    }
    return _shoppingCartArray;
}

@end
