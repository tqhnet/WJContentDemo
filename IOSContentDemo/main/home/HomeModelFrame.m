//
//  HomeModelFrame.m
//  IOSContentDemo
//
//  Created by tqh on 2017/12/9.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "HomeModelFrame.h"

@implementation HomeModelFrame

- (instancetype)initWithHomeModel:(HomeModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        
        if (model.resourceType == 1) {
            _cellHeight = 80;
        }else {
            _cellHeight = 200;
        }
        
    }
    return self;
}

@end
