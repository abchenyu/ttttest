//
//  UITableView+CY.swift
//  CYRecord
//
//  Created by 陈煜 on 16/4/26.
//  Copyright © 2016年 陈煜. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    public func yy_registerNibWithCellReuseIdentifier (_ identifier: String) {
        self.register(UINib.init(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}
