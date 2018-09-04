//
//  ViewController.swift
//  CHAlert
//
//  Created by Jemmy on 2018/8/31.
//  Copyright © 2018年 Jemmy. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

   
    
    @IBAction func hud(_ sender: UIButton) {
        view.chalert.hud(msg: "加载中")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            self.view.chalert.hide()
        }
    }
    

    @IBAction func message(_ sender: UIButton) {
        view.chalert.alert(message: "测试成功", during: 1.0)
    }
    
    @IBAction func alertTwo(_ sender: Any) {
        CHAlert(title: "提示").alert("失败", { (sender) in
            
        }, msg: "测试是否成功", rightbtn: "成功") { (sender) in
            
        }
    }
    @IBAction func alertOne(_ sender: Any) {
        CHAlert().alert(btnTitle: "确认", msg: "测试中") { (sender) in
            
        }
    }
}

