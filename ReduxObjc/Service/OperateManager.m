//
//  OperateManager.m
//  ReduxObjc
//
//  Created by S.C. on 2017/2/10.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "NumberGenerator.h"
#import "OperateManager.h"

#import "Action.h"
#import "Store.h"

@implementation OperateManager

+ (instancetype)sharedManager {
    static OperateManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OperateManager alloc] init];
    });
    return manager;
}

- (RACSignal *)addNumber {
    return [[NumberGenerator singleRandomNumber] doNext:^(id x) {
        Action *action = [[Action alloc] initWithActionType:ActionTypeAddNumber payload:x];
        [[Store sharedInstance] dispatchAction:action];
    }];
}

- (RACSignal *)deleteNumberAtIndex:(NSNumber *)index {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        Action *action = [[Action alloc] initWithActionType:ActionTypeDeleteNumber payload:index];
        [[Store sharedInstance] dispatchAction:action];
        [subscriber sendCompleted];
        return nil;
    }];
    return signal;
}

@end
