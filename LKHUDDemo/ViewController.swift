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
        
        LKHUD.showHUD(HUDStyle: .promptStyle("这是一个提示信息"), animationStyle: .fade)
        
    }
}

