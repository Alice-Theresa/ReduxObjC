//
//  MainViewModel.m
//  ReduxObjc
//
//  Created by S.C. on 2017/2/8.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "MainViewModel.h"
#import "MainTableViewItem.h"

#import "Store.h"
#import "OperateManager.h"
#import "GeneratorManager.h"

@interface MainViewModel ()

@property (nonatomic, copy, readwrite) NSArray<MainTableViewItem *> *items;

@end

@implementation MainViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self buildSection];
    }
    return self;
}

- (void)buildSection {
    @weakify(self)
    [[Store sharedInstance].arrayState subscribeNext:^(id x) {
        @strongify(self)
        NSMutableArray *temp = [NSMutableArray array];
        for (NSNumber *num in x) {
            MainTableViewItem *item = [[MainTableViewItem alloc] init];
            item.number = [NSString stringWithFormat:@"%@", num];
            [temp addObject:item];
        }
        self.items = [temp copy];
    }];
}

- (RACCommand *)refreshCommand {
    if (!_refreshCommand) {
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[GeneratorManager sharedManager] fetchNumbers];
        }];
    }
    return _refreshCommand;
}

- (RACCommand *)addCommand {
    if (!_addCommand) {
        _addCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[OperateManager sharedManager] addNumber];
        }];
    }
    return _addCommand;
}

- (RACCommand *)deleteCommand {
    if (!_deleteCommand) {
        _deleteCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[OperateManager sharedManager] deleteNumberAtIndex:input];
        }];
    }
    return _deleteCommand;
}

@end
