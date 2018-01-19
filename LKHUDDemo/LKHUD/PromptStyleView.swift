//
//  PromptStyleView.swift
//  LKHUDDemo
//
//  Created by 林凯李 on 2018/1/13.
//  Copyright © 2018年 林凯李. All rights reserved.
//

import UIKit

class PromptStyleView: UIView {
  
    @IBOutlet weak var titleLabel: UILabel!
    
    func configTitle(title:String){
        titleLabel.text = title
        let size = titleLabel.sizeThatFits(CGSize(width: 320.0, height: Double(MAXFLOAT)))
        let labelHeight = size.height > 50 ? size.height + 20 : 50
        frame.size = CGSize(width: size.width + 20, height: labelHeight)
    }
    
}
