//
//  HomeViewController.m
//  IOSContentDemo
//
//  Created by tqh on 2017/12/8.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeStore.h"
#import "HomeImageCell.h"
#import "HomeMusicCell.h"

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HomeStore *store;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"publish" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemPressed)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.view addSubview:self.tableView];
    [self.store loadData];
    
    
}

- (void)leftItemPressed {
    NSLog(@"发布");
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModelFrame *modelFrame = self.store.dataArray[indexPath.row];
    if (modelFrame.model.resourceType == 1) {
        HomeMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicCellID"];
        cell.model = modelFrame;
        return cell;
    }else {
        HomeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCellID"];
        cell.model = modelFrame;
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.store.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModelFrame *modelFrame = self.store.dataArray[indexPath.row];
    return modelFrame.cellHeight;
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[HomeImageCell class] forCellReuseIdentifier:@"imageCellID"];
        [_tableView registerClass:[HomeMusicCell class] forCellReuseIdentifier:@"musicCellID"];
    }
    return _tableView;
}

- (HomeStore *)store {
    if (!_store) {
        _store = [HomeStore new];
    }
    return _store;
}

@end
