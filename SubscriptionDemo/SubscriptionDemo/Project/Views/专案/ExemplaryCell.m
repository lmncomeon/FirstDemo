//
//  ExemplaryCell.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/19.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "ExemplaryCell.h"
#import "ExemplaryContentCell.h"

@interface ExemplaryCell () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *container;

@property (nonatomic, strong) UITableView *hotTableView;    // 热门
@property (nonatomic, strong) UITableView *newestTableView; // 最新
@property (nonatomic, strong) UITableView *wholeTableView;  // 全部

@property (nonatomic, strong) NSMutableArray *hotListArray;
@property (nonatomic, strong) NSMutableArray *newestListArray;
@property (nonatomic, strong) NSMutableArray *wholeListArray;

@end

static NSString *const ExemplaryContentCellID = @"ExemplaryContentCell";

@implementation ExemplaryCell

- (UIScrollView *)container {
    if (!_container) {
        _container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-adaptY(30))];
        _container.alwaysBounceVertical=true;
        _container.pagingEnabled = true;
        _container.bounces = false;
        _container.delegate = self;
        [self.contentView addSubview:_container];
        
        _hotTableView    = [self createTableWithFrame:CGRectMake(0, 0, kScreenWidth, _container.height)];
        [_container addSubview:_hotTableView];
        
        _newestTableView = [self createTableWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, _container.height)];
        [_container addSubview:_newestTableView];
        
        _wholeTableView  = [self createTableWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, _container.height)];
        [_container addSubview:_wholeTableView];
        
        _container.contentSize = CGSizeMake(kScreenWidth*3, 0);
    }
    return _container;
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
    }
}

#pragma mark - other method
// 快速创建tableView
- (UITableView *)createTableWithFrame:(CGRect)frame {
    UITableView *main = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    main.dataSource = self;
    main.delegate   = self;
    main.rowHeight = adaptY(100);
    main.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return main;
}

// 联动
- (void)switchViewMethod:(NSInteger)page {
    [_container setContentOffset:CGPointMake(kScreenWidth*page, 0) animated:true];
    
    
}

@end
