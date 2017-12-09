//
//  HomeStore.m
//  IOSContentDemo
//
//  Created by tqh on 2017/12/8.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "HomeStore.h"

@implementation HomeStore

- (void)loadData {
    
    for (int i = 0; i < 10; i ++) {
        HomeModel *model = [HomeModel new];
        [self.dataArray addObject:model];
    }
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
