//
//  NumberGenerator.m
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "NumberGenerator.h"

@implementation NumberGenerator

+ (RACSignal *)randomNumber {
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        NSNumber *num = [NSNumber numberWithInt:arc4random()%100];
        [temp addObject:num];
    }
    return [[RACSignal return:[temp copy]] delay:1];
}

@end
