//
//  PrizeLevel.m
//  prize
//
//  Created by 陈煜 on 16/7/11.
//  Copyright © 2016年 陈煜. All rights reserved.
//

#import "PrizeLevel.h"

@implementation PrizeLevel

- (id)initWithName:(NSString *)name prizeName:(NSString *)prizeName memo:(NSString *)memo level:(NSString *)level everyCount:(int)everyCount {
    self = [super init];
    if (self) {
        self.name = name;
        self.prizeName = prizeName;
        self.everyCount = everyCount;
        self.memo = memo;
        self.level = level;
        self.isDone = NO;
    }
    return self;
}

@end
