//
//  GroupViewController.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/19.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISegmentedControl *titleControl;
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger currentType;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation GroupViewController

- (UISegmentedControl *)titleControl {
    if (!_titleControl) {
        NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"专案群", @"私信", @"消息", nil];
        _titleControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
        _titleControl.frame = CGRectMake(0, 0, adaptX(90), adaptY(30));
        _titleControl.selectedSegmentIndex = 0;
        _currentType = 0; // 记录
        _titleControl.tintColor = kOrangeColor;
        [_titleControl addTarget:self action:@selector(switchPageView:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _titleControl;
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight - 64)) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.dataSource      = self;
        _mainTableView.delegate  = self;
        _mainTableView.rowHeight = adaptY(45);
        [self.view addSubview:_mainTableView];
        
        __weak __typeof(&*self)weakSelf = self;
        _mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            [weakSelf requestDataWithType:_currentType page:_page];
        }];
        
        
        _mainTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestDataWithType:_currentType page:_page];
        }];
    }
   
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.titleControl;
    [self mainTableView];
    _page = 0;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestDataWithType:0 page:_page];
}

- (void)switchPageView:(UISegmentedControl *)control {
    
    _currentType = control.selectedSegmentIndex;
    
    _page = 0;
    [self requestDataWithType:control.selectedSegmentIndex page:_page];
}

- (void)requestDataWithType:(NSInteger)type page:(NSInteger)page {
    
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const cellID = @"UITableViewCellID";;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"1234567";
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//}

#pragma mark - lazy load
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataList;
}

@end
