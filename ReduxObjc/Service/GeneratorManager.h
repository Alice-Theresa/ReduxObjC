//
//  GeneratorManager.h
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeneratorManager : NSObject

+ (instancetype)sharedManager;

- (RACSignal *)fetchNumbers;

@end
