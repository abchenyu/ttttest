//
//  Person.h
//  prize
//
//  Created by 陈煜 on 16/7/11.
//  Copyright © 2016年 陈煜. All rights reserved.
//

#import "JKDBModel.h"

@interface Person : JKDBModel

@property (nonatomic, strong) NSString *prizeLevel;
@property (nonatomic, strong) NSString *num;

@end
