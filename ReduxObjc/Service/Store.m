//
//  Store.m
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "Action.h"
#import "Store.h"
#import "State.h"
#import "Reducer.h"

@interface Store ()

@property (nonatomic, strong, readwrite) RACSignal *arrayState;

@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, copy  ) NSArray<ReducerBlock> *reducers;
@property (nonatomic, strong) State *state;

@end

@implementation Store

+ (instancetype)sharedInstance {
    static Store *store;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[Store alloc] init];
    });
    return store;
}

- (instancetype)init {
    if (self = [super init]) {
        _serialQueue = dispatch_queue_create("com.reduxObjc.queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)dispatchAction:(Action *)action {
    dispatch_async(self.serialQueue, ^{
        State *newState = [self.state copy];
        for (ReducerBlock block in self.reducers) {
            block(&newState, action);
        }
        self.state = newState;
    });
}

- (State *)state {
    if (!_state) {
        _state = [[State alloc] init];
    }
    return _state;
}

- (RACSignal *)arrayState {
    if (!_arrayState) {
        _arrayState = RACObserve(self, state.numberArray);
    }
    return _arrayState;
}

- (NSArray<ReducerBlock> *)reducers {
    if (!_reducers) {
        _reducers = [Reducer reducerBlocks];
    }
    return _reducers;
}

@end
