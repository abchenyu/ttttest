//
//  TestViewController.swift
//  CYRecord
//
//  Created by 陈煜 on 16/12/28.
//  Copyright © 2016年 陈煜. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var bar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        let options = NSKeyValueObservingOptions.new
        self.table.addObserver(self, forKeyPath: "contentOffset", options: options, context: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let tableTmp = object as! UITableView
        if (self.table != tableTmp) {
            return
        }
        if (keyPath != "contentOffset") {
            return
        }
        let tableViewOffsetY = self.table.contentOffset.y
        if tableViewOffsetY < 0 {
            top.constant = -tableViewOffsetY - 20
            self.bar.alpha = 0
        } else if tableViewOffsetY < 200 {
            top.constant = -tableViewOffsetY - 20
            self.bar.alpha = 3 * tableViewOffsetY / 200.0
        } else {
            top.constant = -200 - 20
            self.bar.alpha = 1
        }
    }

}
