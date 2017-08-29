//
//  EditViewController.swift
//  CYRecord
//
//  Created by 陈煜 on 16/4/26.
//  Copyright © 2016年 陈煜. All rights reserved.
//

import UIKit

class EditViewController: BaseViewController {

    @IBOutlet weak var breastplateTF: UITextField!  //腹甲
    @IBOutlet weak var carapaceTF: UITextField!     //背甲
    @IBOutlet weak var weightTF: UITextField!       //体重
    @IBOutlet weak var heightTF: UITextField!       //高度
    @IBOutlet weak var batheSwitch: UISwitch!       //泡澡
    @IBOutlet weak var acidSwitch: UISwitch!        //排酸
    @IBOutlet weak var remarkTextView: UITextView!  //备注
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
