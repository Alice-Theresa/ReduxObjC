//
//  OperateManager.h
//  ReduxObjc
//
//  Created by S.C. on 2017/2/10.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface OperateManager : NSObject

+ (instancetype)sharedManager;

- (RACSignal *)addNumber;
- (RACSignal *)deleteNumberAtIndex:(NSNumber *)index;

@end
