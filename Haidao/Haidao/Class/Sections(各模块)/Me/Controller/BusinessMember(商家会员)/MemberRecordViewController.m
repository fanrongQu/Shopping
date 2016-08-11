//
//  MemberRecordViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MemberRecordViewController.h"
#import "MemberRecordCell.h"

@interface MemberRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  记录列表  */
@property (nonatomic, strong) UITableView *tableView;
/**  记录数据  */
@property (nonatomic, strong) NSMutableArray *memberRecords;

@end

@implementation MemberRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员记录";
    self.memberRecords = [NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)dealloc {
    
    if (_tableView != nil) _tableView = nil;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.memberRecords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemberRecordCell *cell = [MemberRecordCell cellWithTableView:tableView];
    [cell setTelephone:@"15888888888" trueName:@"冯振强" memberNumber:@"123" memberType:@"一级会员" time:@"2016-11-23   12:00"];
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.tableFooterView = [UITableView new];
    }
    return _tableView;
}

- (NSMutableArray *)memberRecords {
    if (!_memberRecords) {
        _memberRecords = [NSMutableArray array];
    }
    return _memberRecords;
}


@end
