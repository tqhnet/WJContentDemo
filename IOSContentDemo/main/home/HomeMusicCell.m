//
//  HomeMusicCell.m
//  IOSContentDemo
//
//  Created by tqh on 2017/12/10.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "HomeMusicCell.h"

@interface HomeMusicCell ()

@property (nonatomic,strong) UIButton *playButton;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation HomeMusicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.playButton];
        
    }
    return self;
}

- (void)setModel:(HomeModelFrame *)model {
    _model = model;
    self.titleLabel.text = @"音乐";
    
    self.playButton.frame = CGRectMake(100, 0, 80, 80);
    self.titleLabel.frame = CGRectMake(0, 0, 100, 80);
    
}

#pragma mark - 事件监听

- (void)buttonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - 懒加载

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton new];
        [_playButton setImage:[UIImage imageNamed:@"home_cell_music_play"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"home_cell_music_ pause"] forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

@end
