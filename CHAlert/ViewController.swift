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
        // Do any additional setup after loading the view, typically from a nib.
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
        //            alert.dismiss()
        //        }
//        view.chalert.hud(msg: "加载中")
        view.chalert.alert(message: "测试提示消息", during: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        CHAlert(title: "测试弹窗").alert(title: "确认", msg: "this is a test alert content") { (sender) in
//
//        }
//       CHAlert(title: "测试").alert("取消", nil, msg: "测试", rightTitle: "确认", rightHander: nil)
//        CHAlert(title: "test").alert(title: "test", msg: "test", handler: nil)
//        CHAlert().alert(message: "这是测试这是测试这是测试这是测试这是测试这是测试这是测试这是测试这是测试这是测试这是测试这是测试这是测试", during: 1.0)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//                        CHAlert().hide()
//                    }
//        view.chalert.alert(title: "<#T##String#>", msg: <#T##String#>, handler: <#T##CHAlert.operationClosure?##CHAlert.operationClosure?##(UIButton) -> Void#>)
    }



}

