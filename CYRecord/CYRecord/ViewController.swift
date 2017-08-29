//
//  ViewController.swift
//  CYRecord
//
//  Created by 陈煜 on 16/4/25.
//  Copyright © 2016年 陈煜. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "首页"
        self.setNavBackBarButtonItem("")
        self.setNavRightButtonItem(title: "修改", action: #selector(ViewController.edit))
        let mainPersionView = MainPersonView.yy_createViewFromNibName("MainPersonView")
        mainPersionView?.frame = self.view.frame;
        self.view.addSubview(mainPersionView!)
    }
    
    func edit() {
       self.performSegue(withIdentifier: "TestViewController", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 11 / 255.0, green: 111 / 255.0, blue: 111 / 255.0, alpha: 0.2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

