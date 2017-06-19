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

- (void)switchViewMethod:(NSInteger)page;

@end
