//
//  NSString+WJTool.m
//  IOSContentDemo
//
//  Created by tqh on 2017/12/10.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "NSString+WJTool.h"

@implementation NSString (WJTool)

- (BOOL)wj_isGifImage {
    NSString *ext = self.pathExtension.lowercaseString;
    
    if ([ext isEqualToString:@"gif"]) {
        return YES;
    }
    return NO;
}

@end
