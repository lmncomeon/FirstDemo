//
//  ExemplaryCell.h
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/19.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface ExemplaryCell : BaseTableViewCell

@property (nonatomic, copy) void (^sendIndex)(NSInteger page);
@property (nonatomic, copy) void (^controlScrollBlock)(BOOL result);

- (void)switchViewMethod:(NSInteger)page;

@property (nonatomic, assign) BOOL cellCanScroll;

@property (nonatomic, assign) BOOL cellCanDrag;

@end
