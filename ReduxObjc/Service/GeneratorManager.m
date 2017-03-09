//
//  GeneratorManager.m
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "NumberGenerator.h"
#import "GeneratorManager.h"

#import "Action.h"
#import "Store.h"

@implementation GeneratorManager

+ (instancetype)sharedManager {
    static GeneratorManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GeneratorManager alloc] init];
    });
    return manager;
}

- (RACSignal *)fetchNumbers {
    return [[NumberGenerator multiRandomNumbers] doNext:^(id x) {
        Action *action = [Action type:ActionTypeFetchNumber payload:x];
        [[Store sharedInstance] dispatchAction:action];
    }];
}

@end
