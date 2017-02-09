//
//  Reducer.m
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import "Action.h"
#import "State.h"
#import "Reducer.h"

@implementation Reducer

+ (NSArray *)reducerBlocks {
    return @[ [self generateActionReducer] ];
}

+ (ReducerBlock)generateActionReducer {
    ReducerBlock block = ^(State **state, Action *action) {
        State *newState = *state;
        switch (action.type) {
            case ActionTypeFetchNumber:
                newState.numberArray = action.payload;
                break;
                
            default:
                break;
        }
    };
    return block;
}

@end
