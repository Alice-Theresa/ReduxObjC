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
    return @[ [self actionReducer] ];
}

+ (ReducerBlock)actionReducer {
    ReducerBlock block = ^(State **state, Action *action) {
        State *newState = *state;
        switch (action.type) {
                
            case ActionTypeFetchNumber: {
                newState.numberArray = action.payload;
                break;
            }
                
            case ActionTypeAddNumber: {
                NSMutableArray *temp;
                temp = newState.numberArray ? [newState.numberArray mutableCopy] : [NSMutableArray array];
                [temp insertObject:action.payload atIndex:0];
                newState.numberArray = [temp copy];
                break;
            }
                
            case ActionTypeDeleteNumber: {
                NSMutableArray *temp;
                if (newState.numberArray) {
                    temp = [newState.numberArray mutableCopy];
                    NSNumber *index = action.payload;
                    [temp removeObjectAtIndex:index.integerValue];
                    newState.numberArray = [temp copy];
                }
                break;
            }
                
            default:
                break;
        }
    };
    return block;
}

@end
