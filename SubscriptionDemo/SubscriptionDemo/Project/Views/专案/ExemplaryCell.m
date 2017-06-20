//
//  ExemplaryCell.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/19.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "ExemplaryCell.h"
#import "ExemplaryContentCell.h"
#import "MJRefresh.h"

@interface ExemplaryCell () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *container;

@property (nonatomic, strong) UITableView *hotTableView;    // 热门
@property (nonatomic, strong) UITableView *newestTableView; // 最新
@property (nonatomic, strong) UITableView *wholeTableView;  // 全部

@property (nonatomic, assign) NSInteger hotPage;
@property (nonatomic, assign) NSInteger newestPage;
@property (nonatomic, assign) NSInteger wholePage;

@property (nonatomic, strong) NSMutableArray *hotListArray;
@property (nonatomic, strong) NSMutableArray *newestListArray;
@property (nonatomic, strong) NSMutableArray *wholeListArray;

@end

static NSString *const ExemplaryContentCellID = @"ExemplaryContentCell";

@implementation ExemplaryCell

- (UIScrollView *)container {
    if (!_container) {
        _container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-adaptY(30)-50)];
        _container.alwaysBounceVertical=true;
        _container.pagingEnabled = true;
        _container.bounces = false;
        _container.delegate = self;
        _container.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_container];
        
        _hotTableView    = [self createTableWithFrame:CGRectMake(0, 0, kScreenWidth, _container.height)];
        [_container addSubview:_hotTableView];
        
        _newestTableView = [self createTableWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, _container.height)];
        [_container addSubview:_newestTableView];
        
        _wholeTableView  = [self createTableWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, _container.height)];
        [_container addSubview:_wholeTableView];
        
        _container.contentSize = CGSizeMake(kScreenWidth*3, 0);
        
        // 默认
        [self setupDefaultValue];
        
        // 下拉刷新
        [self addRefresh];
        
        // 上拉加载
        [self addLoadMore];
        
    }
    return _container;
}

- (void)setupDefaultValue {
    _hotPage = _newestPage = _wholePage = 0;
}

- (void)addRefresh {
    _hotTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        _hotPage = 0;
        DLog(@"===下拉hot page:%ld", (long)_hotPage);
        [self requestDataWithType:0 page:_hotPage];
        
        [_hotTableView.header endRefreshing];
        
        
    }];
    
    _newestTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        _newestPage = 0;
        DLog(@"===下拉newes page:%ld", (long)_newestPage);
        [self requestDataWithType:1 page:_newestPage];
        
        [_newestTableView.header endRefreshing];
        
        
        
    }];
    
    
    _wholeTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        _wholePage = 0;
        DLog(@"===下拉whole page:%ld", (long)_wholePage);
        [self requestDataWithType:2 page:_wholePage];
        
        [_wholeTableView.header endRefreshing];
        
        
    }];
}

- (void)addLoadMore {
    
    
    _hotTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        DLog(@"==上拉hot page:%ld", (long)_hotPage);
        [self requestDataWithType:0 page:_hotPage];
        
        [_hotTableView.footer endRefreshing];
    }];
    
    
    _newestTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        DLog(@"==上拉newes page:%ld", (long)_newestPage);
        
        [self requestDataWithType:1 page:_newestPage];
        
        [_newestTableView.footer endRefreshing];
    }];
    
    
    _wholeTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        DLog(@"==上拉whole page:%ld", (long)_wholePage);
        
        [self requestDataWithType:2 page:_wholePage];
        
        [_wholeTableView.footer endRefreshing];
    }];
}

- (void)requestDataWithType:(NSInteger)type page:(NSInteger)page {
    NSString *typeStr = @"";
    
    switch (type) {
        case 0:
            typeStr = @"hot";
            break;
        case 1:
            typeStr = @"new";
            break;
        case 2:
            typeStr = @"whole";
            break;
        default:
            break;
    }
    
    //成功
    if (type == 0)
    {
        if (page == 0) {
            [self.hotListArray removeAllObjects];
        }
        
        // add models
        
        // page+1
        _hotPage++;
        
    }
    else if (type == 1)
    {
        if (page == 0) {
            [self.newestListArray removeAllObjects];
        }
        
        // add models
        
        // page+1
        _newestPage++;
    }
    else if (type == 2)
    {
        if (page == 0) {
            [self.wholeListArray removeAllObjects];
        }
        
        // add models
        
        // page+1
        _wholePage++;
    }
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    ExemplaryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ExemplaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self container];
    }
    return self;
}

#pragma mark - table datasource

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if (tableView == _hotTableView) {
//        return self.hotListArray.count;
//        
//    } else if (tableView == _newestTableView) {
//        return self.newestListArray.count;
//        
//    } else if (tableView == _wholeTableView) {
//        return self.wholeListArray.count;
//        
//    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExemplaryContentCell *cell = [ExemplaryContentCell cellWithTableView:tableView identifier:ExemplaryContentCellID];
    
    if (tableView == _hotTableView) {
        [cell settingValueWithModel:self.hotListArray[indexPath.section]];
        cell.backgroundColor = [UIColor redColor];
        
    } else if (tableView == _newestTableView) {
        
        [cell settingValueWithModel:self.newestListArray[indexPath.section]];
        cell.backgroundColor = [UIColor greenColor];
        
    } else if (tableView == _wholeTableView) {
        
        [cell settingValueWithModel:self.wholeListArray[indexPath.section]];
        cell.backgroundColor = [UIColor orangeColor];
        
    }
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return adaptY(10);
    }
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return adaptY(10);
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _container)
    {
        NSInteger page = (scrollView.contentOffset.x + kScreenWidth*0.5) / kScreenWidth;
        
        !_sendIndex ? : _sendIndex(page);
        
        // false
        !_controlScrollBlock ? : _controlScrollBlock(false);
        
    } else if (scrollView == _hotTableView || scrollView == _newestTableView || scrollView == _wholeTableView) {
        
        if (scrollView.contentOffset.y > 0) {
            if (!self.cellCanScroll) {
                scrollView.contentOffset = CGPointZero;
            } else {
                
            }
        } else {
            if (!self.cellCanDrag) {
                scrollView.contentOffset = CGPointZero;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
            }
            
        }
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _container) {
        // true
        !_controlScrollBlock ? : _controlScrollBlock(true);
    }
}

#pragma mark - other method
// 快速创建tableView
- (UITableView *)createTableWithFrame:(CGRect)frame {
    UITableView *main = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    main.dataSource = self;
    main.delegate   = self;
    main.rowHeight = adaptY(215);
    main.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return main;
}

// 联动
- (void)switchViewMethod:(NSInteger)page {
    [_container setContentOffset:CGPointMake(kScreenWidth*page, 0) animated:true];
    
    
}


- (void)setCellCanScroll:(BOOL)cellCanScroll
{
    _cellCanScroll = cellCanScroll;
}


@end
