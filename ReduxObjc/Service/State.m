//
//  State.m
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import "State.h"

@implementation State

- (id)copyWithZone:(NSZone *)zone {
    State *state      = [[[self class] allocWithZone:zone] init];
    state.numberArray = self.numberArray;
    return state;
}

@end
