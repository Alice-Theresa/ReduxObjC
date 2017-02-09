//
//  MainViewModel.h
//  ReduxObjc
//
//  Created by S.C. on 2017/2/8.
//  Copyright © 2017年 Mitsuha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand;
@class MainTableViewItem;

@interface MainViewModel : NSObject

@property (nonatomic, copy, readonly) NSArray<MainTableViewItem *> *items;

@property (nonatomic, strong) RACCommand *refreshCommand;

@end
