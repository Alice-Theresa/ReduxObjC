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
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIBarButtonItem  *barItem;
@property (nonatomic, strong) MainViewModel    *viewModel;

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
    self.title = @"Redux Objc";
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];

    self.navigationItem.rightBarButtonItem = self.barItem;
    
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel.deleteCommand execute:@(indexPath.row)];
    }
}

#pragma mark - Lazy Loading

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

- (UIBarButtonItem *)barItem {
    if (!_barItem) {
        _barItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                    style:UIBarButtonItemStylePlain
                                                   target:nil
                                                   action:nil];
        _barItem.rac_command = self.viewModel.addCommand;
    }
    return _barItem;
}

@end
