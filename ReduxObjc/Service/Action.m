//
//  Action.m
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import "Action.h"

@interface Action ()

@property (nonatomic, assign, readwrite) ActionType type;
@property (nonatomic, strong, readwrite, nullable) id payload;

@end

@implementation Action

- (instancetype)initWithActionType:(ActionType)type payload:(nullable id)payload {
    if (self = [super init]) {
        _type = type;
        _payload = payload;
    }
    return self;
}

@end
