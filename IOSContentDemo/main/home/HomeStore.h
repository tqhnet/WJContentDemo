//
//  HomeStore.h
//  IOSContentDemo
//
//  Created by tqh on 2017/12/8.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"
#import "HomeModelFrame.h"

@interface HomeStore : NSObject

@property (nonatomic,strong) NSMutableArray *dataArray;

- (void)loadData;

@end
