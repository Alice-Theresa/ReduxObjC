//
//  Store.h
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Action;
@class RACSignal;

@interface Store : NSObject

@property (nonatomic, strong, readonly) RACSignal *arrayState;

+ (instancetype)sharedInstance;

- (void)dispatchAction:(Action *)action;

@end
