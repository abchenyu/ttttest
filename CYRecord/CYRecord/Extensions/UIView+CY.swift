//
//  UIView+CY.swift
//  CYRecord
//
//  Created by 陈煜 on 16/4/26.
//  Copyright © 2016年 陈煜. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    //圆角
    public func yy_setCornerRadius (_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    //边框
    public func yy_setBorderWidth (_ width: CGFloat, color: UIColor?) {
        self.layer.borderColor = color!.cgColor
        self.layer.borderWidth = width
    }
    
    public func yy_setCommonBorderAndCorner () {
        self.yy_setCornerRadius(4.0);
        self.yy_setBorderWidth(1.0, color: UIColor.init(white: 0.85, alpha: 1.0));
    }
    
    public func yy_fadeIn () {
        UIView.animate(withDuration: 0.3, animations: { 
            self.alpha = 1.0
        }) 
    }
    
    public func yy_fadeOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }) 
    }
    
//    + (instancetype)createViewFromNibName:(NSString *)nibName
//    {
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
//    return [nib objectAtIndex:0];
//    }
//    
//    + (instancetype)createViewFromNib
//    {
//    return [self createViewFromNibName:NSStringFromClass(self.class)];
//    }
    
    public class func yy_createViewFromNibName (_ nibName: String?) -> UIView? {
        let nibs = Bundle.main.loadNibNamed(nibName!, owner: self, options: nil) as NSArray?
        return nibs?.object(at: 0) as? UIView
    }
    
    public class func yy_createViewFromNib () -> UIView? {
        return self.yy_createViewFromNibName(NSStringFromClass(self))
    }
    
}
