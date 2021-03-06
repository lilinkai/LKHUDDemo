//
//  ViewController.swift
//  LKHUDDemo
//
//  Created by 林凯李 on 2018/1/13.
//  Copyright © 2018年 林凯李. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showHUDAction(_ sender: UIButton) {
        LKHUD.showHUD(HUDStyle: .prompt("这是一个提示信息"), animationStyle: .upDown)

    }
    
    @IBAction func showAlertHudAction(_ sender: UIButton) {
        LKHUD.showHUD(HUDStyle: .alert("兑换成功", "恭喜您获得N个金币", { 
            print("点击事件执行了")
            LKHUD.hideHUD()
        }), animationStyle: .upDown)
    }
    
    @IBAction func showOptionAlertView(_ sender: UIButton) {
        LKHUD.showHUD(HUDStyle: .option("抓取成功", UIView(), "取消", { 
            LKHUD.hideHUD()
        }, "确定", { 
            LKHUD.hideHUD()
        }), animationStyle: .upDown)
    }
    
    
}

