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
        
        model.coverImage = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512843209829&di=68a501cfc0f2ea83b2ee7af9c99f7135&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F0824ab18972bd4070441413772899e510eb30971.jpg";
        if (i == 3) {
        model.coverImage = @"https://ww3.sinaimg.cn/large/bd698b0fly1fmadeb9jwlg20a6074doj.gif";
        }
        HomeModelFrame *modelFrame = [[HomeModelFrame alloc]initWithHomeModel:model];
        [self.dataArray addObject:modelFrame];
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
