//
//  HomeModelFrame.h
//  IOSContentDemo
//
//  Created by tqh on 2017/12/9.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"

/**首页模型布局*/
@interface HomeModelFrame : NSObject

@property (nonatomic,strong,readonly) HomeModel *model;

@property (nonatomic,assign,readonly) NSInteger cellHeight;

- (instancetype)initWithHomeModel:(HomeModel *)model;

@end
