//
//  PrizeLevel.h
//  prize
//
//  Created by 陈煜 on 16/7/11.
//  Copyright © 2016年 陈煜. All rights reserved.
//

#import "JKDBModel.h"

@interface PrizeLevel : JKDBModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *prizeName;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, assign) int everyCount;
@property (nonatomic, assign) int time;
@property (nonatomic, assign) BOOL isDone;

- (id)initWithName:(NSString *)name prizeName:(NSString *)prizeName memo:(NSString *)memo level:(NSString *)level everyCount:(int)everyCount;

@end
