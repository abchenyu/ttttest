//
//  YYCABasicAnimationUtil.m
//  Animation
//
//  Created by 陈煜 on 17/3/21.
//  Copyright © 2017年 陈煜. All rights reserved.
//

#import "YYCABasicAnimationUtil.h"
#import <UIKit/UIKit.h>

@implementation YYCABasicAnimationUtil

-(void)animationWithView:(UIView *)view keyPath:(NSString *)keyPath
{
    CABasicAnimation *animation = nil;
    switch (btn.tag) {
        case 0:{
            //淡如淡出
            animation = [CABasicAnimation animationWithKeyPath:keyPath];
            [animation setFromValue:@1.0];
            [animation setToValue:@0.1];
        }break;
        case 1:{
            //缩放
            animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            [animation setFromValue:@1.0];//设置起始值
            [animation setToValue:@0.1];//设置目标值
        }break;
        case 2:{
            //旋转
            animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            //setFromValue不设置,默认以当前状态为准
            [animation setToValue:@(M_PI)];
        }break;
        case 3:{
            //平移
            animation = [CABasicAnimation animationWithKeyPath:@"position"];
            //setFromValue不设置,默认以当前状态为准
            [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + 200)]];
        }break;
        default:break;
    }
    [animation setDelegate:nil];//代理回调
    [animation setDuration:0.25];//设置动画时间，单次动画时间
    [animation setRemovedOnCompletion:NO];//默认为YES,设置为NO时setFillMode有效
    /**
     *设置时间函数CAMediaTimingFunction
     *kCAMediaTimingFunctionLinear 匀速
     *kCAMediaTimingFunctionEaseIn 开始速度慢，后来速度快
     *kCAMediaTimingFunctionEaseOut 开始速度快 后来速度慢
     *kCAMediaTimingFunctionEaseInEaseOut = kCAMediaTimingFunctionDefault 中间速度快，两头速度慢
     */
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //设置自动翻转
    //设置自动翻转以后单次动画时间不变，总动画时间增加一倍，它会让你前半部分的动画以相反的方式动画过来
    //比如说你设置执行一次动画，从a到b时间为1秒，设置自动翻转以后动画的执行方式为，先从a到b执行一秒，然后从b到a再执行一下动画结束
    [animation setAutoreverses:YES];
    //kCAFillModeForwards//动画结束后回到准备状态
    //kCAFillModeBackwards//动画结束后保持最后状态
    //kCAFillModeBoth//动画结束后回到准备状态,并保持最后状态
    //kCAFillModeRemoved//执行完成移除动画
    [animation setFillMode:kCAFillModeBoth];
    //将动画添加到layer,添加到图层开始执行动画，
    //注意:key值的设置与否会影响动画的效果
    //如果不设置key值每次执行都会创建一个动画，然后创建的动画会叠加在图层上
    //如果设置key值，系统执行这个动画时会先检查这个动画有没有被创建，如果没有的话就创建一个，如果有的话就重新从头开始执行这个动画
    //你可以通过key值获取或者删除一个动画:
    //[self.demoView.layer animationForKey:@""];
    //[self.demoView.layer removeAnimationForKey:@""]
    [view.layer addAnimation:animation forKey:@"baseanimation"];
}

@end
