//
//  SubscriptionViewController.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/19.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "SubscriptionViewController.h"
#import "SubscribeNowViewController.h"
@interface SubscriptionViewController ()

@end

@implementation SubscriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];
    
    [self setupNavWithTitle:@"订阅"];
 
    __weak __typeof(&*self)weakSelf = self;
    [self.view addSingleTapEvent:^{
        SubscribeNowViewController *vc =[SubscribeNowViewController new];
        vc.hidesBottomBarWhenPushed = true;
        [weakSelf.navigationController pushViewController:vc animated:true];
    }];
    
    
}

@end
