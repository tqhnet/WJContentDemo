//
//  HomeImageCell.m
//  IOSContentDemo
//
//  Created by tqh on 2017/12/8.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "HomeImageCell.h"

@implementation HomeImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark - setter

- (void)setModel:(HomeModel *)model {
    _model = model;
}

@end
