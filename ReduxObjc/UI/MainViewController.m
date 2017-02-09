//
//  MainViewController.m
//  ReduxObjc
//
//  Created by S.C. on 2017/2/8.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "MainViewModel.h"
#import "MainTableViewItem.h"
#import "MainViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) MainViewModel    *viewModel;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

static NSString *cellIdentifier = @"TableViewCell";

@implementation MainViewController

- (instancetype)init {
    if (self = [super init]) {
        _viewModel = [[MainViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
    
    @weakify(self)
    [[RACObserve(self.viewModel, items) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

#pragma mark - Delegate & DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    MainTableViewItem *item = self.viewModel.items[indexPath.row];
    cell.textLabel.text     = item.number;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView            = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.rac_command = self.viewModel.refreshCommand;
    }
    return _refreshControl;
}

@end
