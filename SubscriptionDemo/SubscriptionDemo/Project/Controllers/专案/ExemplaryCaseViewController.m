//
//  ExemplaryCaseViewController.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/19.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "ExemplaryCaseViewController.h"
#import "AdvertisementView.h"
#import "ExemplaryTableView.h"
#import "ExemplaryCell.h"

@interface ExemplaryCaseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ExemplaryTableView *mainTableView;
@property (nonatomic, strong) AdvertisementView *ADView;

@property (nonatomic, strong) UIView *buttonsView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSArray *buttonTitleArr;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL cellCanDrag;
@property (nonatomic, strong) ExemplaryCell *currentCell;

@end

// cell identifier
static NSString *const ExemplaryCellID = @"ExemplaryCell";

// common tag value
static NSInteger const switchBtnTag    = 1000;

@implementation ExemplaryCaseViewController

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[ExemplaryTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.dataSource      = self;
        _mainTableView.delegate        = self;
        _mainTableView.bounces = false;
        _mainTableView.showsVerticalScrollIndicator = false;
        _mainTableView.rowHeight = kScreenHeight-64-adaptY(30);
        [self.view addSubview:_mainTableView];
        
        _mainTableView.tableHeaderView = ({
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(146))];
            headerView.backgroundColor = [UIColor redColor];
            
            [headerView addSubview:self.ADView];
            self.ADView.y = adaptY(116);
            
            headerView;
        });
        
    }
    return _mainTableView;
}

// 消息
- (AdvertisementView *)ADView {
    if (!_ADView) {
        _ADView = [[AdvertisementView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(30))];
        _ADView.backgroundColor = [UIColor yellowColor];
    }
    return _ADView;
}

- (UIView *)buttonsView {
    if (!_buttonsView) {
        _buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(30))];
        _buttonsView.backgroundColor = commonWhiteColor;
        
        CGFloat btnW = adaptX(60);
        CGFloat padding = adaptX(20);
        CGFloat margin  = (kScreenWidth-2*padding-3*btnW) /2;
        for (int i = 0; i < self.buttonTitleArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(padding+i*(btnW+margin), 0, btnW, adaptY(30));
            [btn setTitle:self.buttonTitleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = kFont(12);
            btn.tag = switchBtnTag+i; // tag;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonsView addSubview:btn];
            
            // default
            if (i == 0) {
                btn.selected = true;
                _selectedBtn = btn;
            }
        }
        
    }
    return _buttonsView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavWithTitle:@"文阅"];
 
    [self mainTableView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.ADView.contentList = @[@"你好0", @"你好1", @"你好2", @"你好3", @"你好4"];
    });
    
    // 默认
    self.canScroll   = YES;
    self.cellCanDrag = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
  
}

#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.currentCell.cellCanScroll = NO;
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExemplaryCell *cell = [ExemplaryCell cellWithTableView:tableView identifier:ExemplaryCellID];
    cell.sendIndex = ^(NSInteger page) {
        UIButton *btn = (UIButton *)[_buttonsView viewWithTag:switchBtnTag+page];
        [self changeBtnProperty:btn];
        
    };
    cell.controlScrollBlock = ^ (BOOL res) {
        _mainTableView.scrollEnabled = res;
    };
    cell.cellCanDrag = self.cellCanDrag;
    self.currentCell = cell;
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return adaptY(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self buttonsView];
}

#pragma mark -
- (void)switchAction:(UIButton *)sender {
    [self changeBtnProperty:sender];
    
    ExemplaryCell *cell = [_mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell switchViewMethod:sender.tag-switchBtnTag];
}

- (void)changeBtnProperty:(UIButton *)sender {
    if (sender == _selectedBtn) return;
    
    sender.selected = true;
    _selectedBtn.selected = false;
    _selectedBtn = sender;
}

#pragma mark - lazy load
- (NSArray *)buttonTitleArr {
    if (!_buttonTitleArr) {
        _buttonTitleArr = @[@"热门", @"最新", @"全部"];
    }
    return _buttonTitleArr;
}


#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self old:scrollView];
}

- (void)old:(UIScrollView *)scrollView {
    CGFloat bottomCellOffset = _mainTableView.tableHeaderView.height;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.currentCell.cellCanScroll = YES;
            self.currentCell.cellCanDrag   = NO;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        
        } else {
            if (scrollView.contentOffset.y <= 0) {
                self.currentCell.cellCanDrag = YES;
            }
        }
    }
    
}

@end
