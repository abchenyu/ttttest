//
//  ViewController.m
//  prize
//
//  Created by 陈煜 on 16/7/11.
//  Copyright © 2016年 陈煜. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _againBtn.hidden = YES;
    _tableLeading.constant = -kTableWidth;
    _resultLabel.alphaValue = 0;
    NSArray *persons = [Person findAll];
    _settingView.hidden = (persons.count > 0);
    _count = persons.count;
    [self initPersons];
    [self initPrizeCfg];
    [self autoPrepare];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:@"ReloadViewController" object:nil];
}

- (void)reloadView {
    [self setResultViewHidden:YES];
    _settingView.hidden = NO;
    [self initPrizeCfg];
    [self autoPrepare];
}

- (IBAction)onClickSetCount:(id)sender {
    NSString *countStr = _countTF.stringValue;
    if (countStr && [self isInt:countStr]) {
        _count = countStr.intValue;
        _settingView.hidden = YES;
        [self initPersons];
        [self initPrizeCfg];
        [self autoPrepare];
    }
    _countTF.stringValue = @"";
}

- (IBAction)onClickAgain:(id)sender {
    PrizeLevel *level = _prizeLevels[_step];
    NSArray *persons = [self findAllPersonsWithPrizeLevel:level.level];
    if (persons.count == 1) {
        Person *person = persons[0];
        person.prizeLevel = @"-2";
        [person saveOrUpdate];
        [self startTimer];
        _againBtn.hidden = YES;
        [_bigBtn setTitle:@"停止"];
        
    }
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)initPrizeCfg {
    PrizeLevel *level1 = [[PrizeLevel alloc] initWithName:@"一等奖" prizeName:@"Macbook air" memo:@"1台" level:@"1" everyCount:1];
    PrizeLevel *level2 = [[PrizeLevel alloc] initWithName:@"二等奖" prizeName:@"iWatch" memo:@"1个" level:@"2" everyCount:1];
    PrizeLevel *level3 = [[PrizeLevel alloc] initWithName:@"二等奖" prizeName:@"银器" memo:@"1个" level:@"3" everyCount:1];
    PrizeLevel *level4 = [[PrizeLevel alloc] initWithName:@"三等奖" prizeName:@"Honeywell车载空气净化器" memo:@"1台" level:@"4" everyCount:1];
    PrizeLevel *level5 = [[PrizeLevel alloc] initWithName:@"三等奖" prizeName:@"海尔扫地机器人" memo:@"1台" level:@"5" everyCount:1];
    PrizeLevel *level6 = [[PrizeLevel alloc] initWithName:@"三等奖" prizeName:@"曼哈卡顿水晶音箱" memo:@"1台" level:@"6" everyCount:1];
    PrizeLevel *level7 = [[PrizeLevel alloc] initWithName:@"参与奖" prizeName:@"颈椎按摩仪" memo:@"4台" level:@"7" everyCount:4];
    PrizeLevel *level8 = [[PrizeLevel alloc] initWithName:@"参与奖" prizeName:@"飞利浦榨汁机" memo:@"4台" level:@"8" everyCount:4];
    PrizeLevel *level9 = [[PrizeLevel alloc] initWithName:@"参与奖" prizeName:@"采耳器" memo:@"4个" level:@"10" everyCount:4];
    PrizeLevel *level10 = [[PrizeLevel alloc] initWithName:@"参与奖" prizeName:@"300元京东商城购物卡" memo:@"4张" level:@"9" everyCount:4];
    
    _prizeLevels = [NSArray arrayWithObjects:level10, level9, level8, level7, level6, level5, level4, level3, level2, level1, nil];
    for (PrizeLevel *level in _prizeLevels) {
        NSArray *persons = [self findAllPersonsWithPrizeLevel:level.level];
        level.isDone = (persons.count > 0);
    }
    _table.delegate = self;
    _table.dataSource = self;
    [_table reloadData];
}

- (void)setPrizeName {
    if (_step > _prizeLevels.count - 1) {
        return;
    }
    PrizeLevel *level = _prizeLevels[_step];
    _prizeNameLabel.stringValue = [NSString stringWithFormat:@"%@(%@ %@)", level.name, level.prizeName, level.memo];
}

- (IBAction)onClickBtn:(id)sender {
    if (_count <= 0) {
        _settingView.hidden = NO;
        return;
    }
    [self onCLickBtn0];
}

//有下一步
- (void)onCLickBtn0 {
    [self setResultViewHidden:YES];
    if (_step > _prizeLevels.count - 1) {
        [self setResult];
        [self setResultViewHidden:NO];
        return;
    }
    if (_timeout != 0) {
        //停止
        _timeout = 0;
        [_bigBtn setTitle:@"准备抽奖"];
    } else {
        if (_prizePersonsLabel.stringValue && _prizePersonsLabel.stringValue.length > 0) {
            //准备下一个抽奖
            [self autoPrepare];
            _againBtn.hidden = YES;
        } else {
            //开始
            [self setTableHidden:YES];
            [_bigBtn setTitle:@"停止"];
            _personsWithoutPrize = [self findAllPersonsWithoutPrize];
            [self startTimer];
            _againBtn.hidden = YES;
        }
    }
}

//点列表抽奖
- (void)onCLickBtn1 {
    [self setResultViewHidden:YES];
    if (_step > _prizeLevels.count - 1) {
        [self setResult];
        [self setResultViewHidden:NO];
        return;
    }
    if (_timeout != 0) {
        //停止
        _timeout = 0;
        [_bigBtn setTitle:@"开始抽奖"];
    } else {
        if (_prizePersonsLabel.stringValue && _prizePersonsLabel.stringValue.length > 0) {
            [self setTableHidden:NO];
        } else {
            //开始
            [self setTableHidden:YES];
            [_bigBtn setTitle:@"停止"];
            _personsWithoutPrize = [self findAllPersonsWithoutPrize];
            [self startTimer];
        }
    }
}

- (void)autoPrepare {
    _step = (int)_prizeLevels.count;
    for (int i = 0; i < _prizeLevels.count; i++) {
        PrizeLevel *level = _prizeLevels[i];
        if (!level.isDone) {
            _step = i;
            break;
        }
    }
    if (_step == (int)_prizeLevels.count) {
        [self setResult];
        [self setResultViewHidden:NO];
    } else {
        [self prepare];
    }
}

- (void)prepare {
    [self setPrizeName];
    [_bigBtn setTitle:@"开始抽奖"];
    _prizePersonsLabel.stringValue = @"";
}

- (IBAction)onClickShowResult:(id)sender {
    [self setResult];
    [self setResultViewHidden:_resultLabel.alphaValue == 1];
}

- (NSArray *)random:(int)count total:(NSInteger)total {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    while (dic.allKeys.count < count) {
        int value = arc4random() % total;
        NSString *key = [NSString stringWithFormat:@"%d", value];
        if (![dic valueForKey:key]) {
            [dic setObject:key forKey:key];
        }
    }
    return dic.allKeys;
}

static dispatch_source_t timer;

- (void)startTimer {
    __weak typeof(self) weakSelf = self;
    _timeout = INT_MAX; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0), 0.1 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(weakSelf.timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //停止
                [self endTimer];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                //滚动
                [weakSelf scrolling];
            });
            weakSelf.timeout--;
        }
    });
    dispatch_resume(timer);
}

- (void)scrolling {
    if (_step > _prizeLevels.count - 1) {
        return;
    }
    PrizeLevel *level = _prizeLevels[_step];
    _randomArray = [self random:level.everyCount total:_personsWithoutPrize.count];
    NSMutableString *selectedNumStr = [[NSMutableString alloc] initWithString:kSpace];
    for (NSString *key in _randomArray) {
        Person *person = [_personsWithoutPrize objectAtIndex:[key integerValue]];
        [selectedNumStr appendString:person.num];
        [selectedNumStr appendString:kSpace];
    }
    _prizePersonsLabel.stringValue = selectedNumStr;
}

- (void)endTimer {
    if (_step > _prizeLevels.count - 1) {
        return;
    }
    PrizeLevel *level = _prizeLevels[_step];
    for (NSString *key in _randomArray) {
        Person *person = [_personsWithoutPrize objectAtIndex:[key integerValue]];
        person.prizeLevel = level.level;
        [person saveOrUpdate];
    }
    level.isDone = YES;
    [_table reloadData];
    if (_randomArray.count == 1) {
        _againBtn.hidden = NO;
    } else {
        _againBtn.hidden = YES;
    }
}

- (void)setResult {
    _resultStr = [[NSMutableString alloc] init];
    for (PrizeLevel *level in _prizeLevels) {
        NSArray *persons = [self findAllPersonsWithPrizeLevel:level.level];
        if (persons.count == 0) {
            continue;
        }
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"\n%@(%@ %@)", level.name, level.prizeName, level.memo];
        [str appendString:@"\n"];
        for (Person *person in persons) {
            [str appendString:person.num];
            [str appendString:@"    "];
        }
        [_resultStr insertString:str atIndex:0];
    }
    _resultLabel.stringValue = _resultStr;
    NSLog(@"%@", _resultStr);
}

- (void)setResultViewHidden:(BOOL)hidden {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        [context setDuration:0.3];
        [[_resultLabel animator] setAlphaValue:hidden ? 0 : 1];
        [[_prizeNameLabel animator] setAlphaValue:hidden ? 1 : 0];
        [[_prizePersonsLabel animator] setAlphaValue:hidden ? 1 : 0];
    } completionHandler:^{
        
    }];
}

- (void)showResultWithPrizeLevel:(PrizeLevel *)level {
    NSArray *persons = [self findAllPersonsWithPrizeLevel:level.level];
    NSMutableString *str = [[NSMutableString alloc] initWithString:kSpace];
    for (Person *person in persons) {
        [str appendString:person.num];
        [str appendString:kSpace];
    }
    _prizePersonsLabel.stringValue = str;
    _prizeNameLabel.stringValue = [[NSMutableString alloc] initWithFormat:@"\n%@(%@ %@)", level.name, level.prizeName, level.memo];
    if (persons.count == 1) {
        _againBtn.hidden = NO;
    } else {
        _againBtn.hidden = YES;
    }
}


#pragma mark - db

- (void)initPersons {
    NSArray *savedPerson = [Person findAll];
    if (savedPerson.count > 0) {
        return;
    }
    for (int i = 0; i < _count; i++) {
        Person *person = [[Person alloc] init];
        person.num = [NSString stringWithFormat:@"%.3d", i + 1];
        person.prizeLevel = @"-1";
        [person save];
    }
}

- (Person *)findPersonWithNum:(NSString *)num {
    NSArray *person = [Person findWithFormat:@" WHERE num = %@ ", num];
    if (person.count == 0) {
        return nil;
    }
    return person[0];
}

- (NSArray *)findAllPersonsWithoutPrize {
    return [self findAllPersonsWithPrizeLevel:@"-1"];
}

- (NSArray *)findAllPersonsWithPrizeLevel:(NSString *)prizeLevel {
    NSArray *persons = [Person findWithFormat:@" WHERE prizeLevel = %@ ", prizeLevel];
    return persons;
}

#pragma mark - table

- (IBAction)onClickShowTable:(id)sender {
    [self setTableHidden:_tableScrollView.frame.origin.x == 0];
}

- (void)setTableHidden:(BOOL)hidden {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        [context setDuration:0.3];
        CGPoint point = NSMakePoint(hidden ? -kTableWidth : 0, 0);
        [[_tableScrollView animator] setFrameOrigin:point];
    } completionHandler:^{
        
    }];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _prizeLevels.count + 1;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // 将容器里面的每行记录，分别放入到表格的没列里面，当表格重载的时候，就会自动执行本函数
    id identifier = [tableColumn identifier];
    if (row == _prizeLevels.count) {
        if([identifier isEqual:@"name"]){
            return @"结果";
        }
        return nil;
    }
    PrizeLevel *prizeLevel = [_prizeLevels objectAtIndex:row];
    if([identifier isEqual:@"name"]){
        return prizeLevel.name;
    }
    if([identifier isEqual:@"prizeName"]){
        return prizeLevel.prizeName;
    }
    if([identifier isEqual:@"memo"]){
        return prizeLevel.memo;
    }
    if([identifier isEqual:@"state"]){
        return prizeLevel.isDone ? @"完成" : @"--";
    }
    return nil;
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    if (row == _prizeLevels.count) {
        [self setResult];
        [self setResultViewHidden:NO];
    } else {
        PrizeLevel *prizeLevel = [_prizeLevels objectAtIndex:row];
        NSArray *persons = [self findAllPersonsWithPrizeLevel:prizeLevel.level];
        if (persons.count == 0) {
            //未抽奖，准备抽奖
            _step = (int)row;
            [self prepare];
            [self setTableHidden:YES];
        } else {
            //已抽奖，显示结果
            _step = (int)row;
            [self showResultWithPrizeLevel:prizeLevel];
        }
        [self setResultViewHidden:YES];
    }
    return YES;
}

- (BOOL)isInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

@end
