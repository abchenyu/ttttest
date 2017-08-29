//
//  SecondViewController.swift
//  CYRecord
//
//  Created by 陈煜 on 16/4/25.
//  Copyright © 2016年 陈煜. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "1"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
