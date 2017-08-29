//
//  ViewController.h
//  prize
//
//  Created by 陈煜 on 16/7/11.
//  Copyright © 2016年 陈煜. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PrizeLevel.h"
#import "Person.h"
#import "JKDBModel.h"

//#define kCount          120
#define kSpace          @"      "
#define kTableWidth     200

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
    NSArray *_personsWithoutPrize;
    NSArray *_prizeLevels;
    NSArray *_personsLeft;
    
    NSMutableString *_resultStr;
    int _count;
}

@property (weak) IBOutlet NSButton *bigBtn;
@property (nonatomic, assign) int timeout;
@property (nonatomic, assign) int step;
@property (nonatomic, strong) NSArray *randomArray;
@property (weak) IBOutlet NSButton *againBtn;

@property (weak) IBOutlet NSTextField *prizeNameLabel;
@property (weak) IBOutlet NSTextField *prizePersonsLabel;
@property (weak) IBOutlet NSTextField *resultLabel;
@property (weak) IBOutlet NSTableView *table;
@property (weak) IBOutlet NSScrollView *tableScrollView;
@property (weak) IBOutlet NSLayoutConstraint *tableLeading;
@property (weak) IBOutlet NSView *settingView;
@property (weak) IBOutlet NSTextField *countTF;

- (IBAction)onClickBtn:(id)sender;
- (IBAction)onClickShowResult:(id)sender;
- (IBAction)onClickShowTable:(id)sender;

- (IBAction)onClickSetCount:(id)sender;
- (IBAction)onClickAgain:(id)sender;

@end

