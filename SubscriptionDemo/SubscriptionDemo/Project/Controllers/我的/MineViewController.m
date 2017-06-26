//
//  MineViewController.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/19.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "MineModel.h"

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray <MineModel *> *dataList;

@end

static NSString *const MineCellID = @"MineCell";

@implementation MineViewController

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight - 64)) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.dataSource      = self;
        _mainTableView.delegate  = self;
        _mainTableView.rowHeight = adaptY(45);
        [self.view addSubview:_mainTableView];
        
        
        _mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            _page = 0;
            
            [self requestDataWithPage:_page isHeader:true];

        }];
        
        _mainTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [self requestDataWithPage:_page isHeader:false];
        }];
    }
   
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavWithTitle:@"个人中心"];
    
    [self mainTableView];
    
    MineModel *model0 = [MineModel modelWithText:@"哈哈" allowSpread:true cellFlag:0];
    MineModel *model1 = [MineModel modelWithText:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈你好" allowSpread:false cellFlag:0];
    MineModel *model2 = [MineModel modelWithText:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好哈哈哈哈哈哈哈哈哈哈你好" allowSpread:true cellFlag:0];
    
    [self.dataList addObject:model0];
    [self.dataList addObject:model1];
    [self.dataList addObject:model2];
    
    [self.mainTableView reloadData];
    
}

- (void)requestDataWithPage:(NSInteger)page isHeader:(BOOL)isHeader {
    
    if (isHeader) {
        [_mainTableView.header endRefreshing];
    } else {
        [_mainTableView.footer endRefreshing];
    }
    
    if (page == 0) {
        [self.dataList removeAllObjects];
    }
    
    MineModel *model0 = [MineModel modelWithText:@"哈哈美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美" allowSpread:true cellFlag:0];
    MineModel *model1 = [MineModel modelWithText:@"你好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美" allowSpread:false cellFlag:0];
    MineModel *model2 = [MineModel modelWithText:@"美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好美好" allowSpread:true cellFlag:0];
    
    [self.dataList addObject:model0];
    [self.dataList addObject:model1];
    [self.dataList addObject:model2];
    
    _page++;
    
    [self.mainTableView reloadData];
    
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineCell *cell = [MineCell cellWithTableView:tableView identifier:MineCellID];
    
    [cell configCellWithModel:self.dataList[indexPath.row]];
    
    __weak __typeof(&*self)weakSelf = self;
    cell.refreshHeightBlock = ^ () {
        [weakSelf.mainTableView beginUpdates];
        
        [weakSelf.mainTableView endUpdates];
    };
    
    return cell;

}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [MineCell cellHeightWith:self.dataList[indexPath.row]];
    
    return height;
}

#pragma mark - lazy loady
- (NSMutableArray <MineModel *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataList;
}


@end
