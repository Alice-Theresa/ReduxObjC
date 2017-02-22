//
//  Action.h
//  ReduxObjc
//
//  Created by S.C. on 2017/2/9.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ActionType) {
    ActionTypeFetchNumber = 0,
    ActionTypeAddNumber,
    ActionTypeDeleteNumber
};

NS_ASSUME_NONNULL_BEGIN

@interface Action : NSObject

@property (nonatomic, assign, readonly) ActionType type;
@property (nonatomic, strong, readonly, nullable) id payload;

- (instancetype)initWithActionType:(ActionType)type payload:(nullable id)payload;

@end

NS_ASSUME_NONNULL_END
