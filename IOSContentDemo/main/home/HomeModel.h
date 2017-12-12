//
//  HomeModel.h
//  IOSContentDemo
//
//  Created by tqh on 2017/12/8.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**首页模型*/
@interface HomeModel : NSObject

@property (nonatomic,assign) NSInteger resourceType;    //资源类型 0图片，1音频，2视频
@property (nonatomic,copy) NSString *coverImage;        //封面图
@property (nonatomic,copy) NSString *musicUrl;          //音频地址
@end
