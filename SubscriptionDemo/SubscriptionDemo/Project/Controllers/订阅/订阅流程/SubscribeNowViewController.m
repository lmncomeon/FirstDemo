//
//  SubscribeNowViewController.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/20.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "SubscribeNowViewController.h"
#import "SubscriptionOptionsCell.h"
#import "SubscriptionOptionsModel.h"
#import "FMVideoDetailViewController.h"

@interface SubscribeNowViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) SubscriptionOptionsModel *selectedModel;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

// cell identifier
static NSString *const SubscriptionOptionsCellID = @"SubscriptionOptionsCell";

@implementation SubscribeNowViewController

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight - 64-adaptY(40))) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.dataSource      = self;
        _mainTableView.delegate  = self;
        [self.view addSubview:_mainTableView];
        
    }
    return _mainTableView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mainTableView.frame), kScreenWidth, adaptY(40))];
        _bottomView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:_bottomView];
        
        __weak __typeof(&*self)weakSelf = self;
        [_bottomView addSingleTapEvent:^{
            if (!weakSelf.selectedModel) {
                [weakSelf showTips];
                return;
            }
            
            [weakSelf.navigationController pushViewController:[FMVideoDetailViewController new] animated:true];
        }];
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavWithTitle:@"立即订阅"];
 
    for (int i = 0; i < 10; i++) {
        SubscriptionOptionsModel *model = [SubscriptionOptionsModel new];
        model.isNike = false;
        [self.dataList addObject:model];
    }
    
    [self.mainTableView reloadData];
    [self bottomView];
}

- (void)showTips {
    showTip(@"轻选择");
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataList.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        SubscriptionOptionsCell *cell = [SubscriptionOptionsCell cellWithTableView:tableView identifier:SubscriptionOptionsCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataList[indexPath.row];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    cell.textLabel.text = @"ssss";
    return cell;
    
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        SubscriptionOptionsModel *model = self.dataList[indexPath.row];
        
//        if (model == _selectedModel) return;
        if (model == _selectedModel) {
            model.isNike = false;
            _selectedModel = nil;
        } else {
         
            model.isNike = true;
            _selectedModel.isNike = false;
            _selectedModel = model;
        }
        
        
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:0];
        [_mainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return adaptY(100);
    }
    return adaptY(200);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return adaptY(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(30))];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(adaptX(10), adaptY(5), adaptX(4), adaptY(20))];
    [header addSubview:line];
    
    SDKCustomLabel *lab = [SDKCustomLabel setLabelTitle:(section == 0 ? @"选择订阅项目" : @"选择订阅周期") setLabelFrame:CGRectMake(CGRectGetMaxX(line.frame), CGRectGetMinY(line.frame), adaptX(200), line.height) setLabelColor:[UIColor blackColor] setLabelFont:kFont(12)];
    [header addSubview:lab];
    
    return header;
}

#pragma mark - lazy load
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataList;
}

@end
