//
//  Reducer.h
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class State;
@class Action;

typedef void (^ReducerBlock)(State **state, Action *action);

@interface Reducer : NSObject

+ (NSArray *)reducerBlocks;

@end
