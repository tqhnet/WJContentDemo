//
//  HomeImageCell.m
//  IOSContentDemo
//
//  Created by tqh on 2017/12/8.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "HomeImageCell.h"

@interface HomeImageCell ()

@property (nonatomic,strong) YYAnimatedImageView *contentImageView;     //图片
@property (nonatomic,strong) UIImageView *gifIconView;          //gif标志

@end

@implementation HomeImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.contentImageView];
        [self addSubview:self.gifIconView];
    }
    return self;
}

- (void)layoutSubviews {
    self.contentImageView.frame = self.bounds;
    self.gifIconView.frame = CGRectMake(5, 5, 16, 16);
}

#pragma mark - setter

- (void)setModel:(HomeModelFrame *)model {
    _model = model;
    
    [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:model.model.coverImage] placeholder:[UIImage imageNamed:@"home_cell_placeholder"]];
    if (model.model.coverImage.wj_isGifImage) {
        self.gifIconView.hidden = NO;
    }else {
        self.gifIconView.hidden = YES;
    }
}

#pragma mark - lazy

- (YYAnimatedImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [YYAnimatedImageView new];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _contentImageView.layer.masksToBounds = YES;
    }
    return _contentImageView;
}

- (UIImageView *)gifIconView {
    if (!_gifIconView) {
        _gifIconView = [UIImageView new];
        _gifIconView.image = [UIImage imageNamed:@"home_cell_gif"];
        _gifIconView.backgroundColor = [UIColor whiteColor];
        _gifIconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _gifIconView;
}

@end
