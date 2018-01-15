//
//  LKHUDVC.swift
//  LKHUDDemo
//
//  Created by 林凯李 on 2018/1/13.
//  Copyright © 2018年 林凯李. All rights reserved.
//

import UIKit

class LKHUDVC: UIViewController {
    
    var HUDStyleView:UIView!
    var HUDAnimationStyle:HUDAnimationStyle!

    override func viewDidLoad() {
        super.viewDidLoad()

        HUDStyleView.center = self.view.center
        HUDAnimationStyle.showAnimation()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss(completed:@escaping(UIViewController)->()){
        completed(self)
    }

}
