//
//  OptionAlertView.swift
//  LKHUDDemo
//
//  Created by 林凯李 on 2018/1/19.
//  Copyright © 2018年 林凯李. All rights reserved.
//

import UIKit

class OptionAlertView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var contentView: UIView!
    var leftHandleAction:(()->())?
    var rightHandleAction:(()->())?

    func configOptionAlert(titleStr:String, contentObj:Any, leftBtnTitle:String, leftHandle:@escaping (()->()), rightBtnTitle:String, rightHandle:@escaping (()->())){
        title.text = titleStr
       
        leftHandleAction = leftHandle
        rightHandleAction = rightHandle
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        leftHandleAction?()
    }
    
    @IBAction func againAction(_ sender: UIButton) {
        rightHandleAction?()
    }
    
    
}
