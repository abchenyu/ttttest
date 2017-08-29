//
//  UIViewController+CY.swift
//  CYRecord
//
//  Created by 陈煜 on 16/4/25.
//  Copyright © 2016年 陈煜. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func setNavBackBarButtonItem (_ title: String?) {
        let item = UIBarButtonItem.init(title: title, style: UIBarButtonItemStyle.plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    
    public func setNavRightButtonItem (title: String?, action: Selector?) {
        let item = UIBarButtonItem.init(title: title, style: UIBarButtonItemStyle.plain, target: self, action: action)
        self.navigationItem.rightBarButtonItem = item
    }
}
