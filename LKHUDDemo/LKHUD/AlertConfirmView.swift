//
//  AlertConfirmView.swift
//  LKHUDDemo
//
//  Created by 林凯李 on 2018/1/19.
//  Copyright © 2018年 林凯李. All rights reserved.
//

import UIKit

class AlertConfirmView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    var handleAction:(()->())?
    
    func configAlertConfirm(titleStr:String, descStr:String, handle:@escaping (()->())){
        title.text = titleStr
        desc.attributedText = getAttributedString(contentStr: descStr as String, lineSpace: 5)
        handleAction = handle
        
        let strHeight = descStr.lk_heightForComment(fontSize: 13.0, width: 230.0)
        
        let totalHeight = 25+21+20+strHeight+20+50+20
        self.frame.size.height = totalHeight
    }
    
    func getAttributedString(contentStr:String, lineSpace:CGFloat) -> NSMutableAttributedString{
        let attributedStr = NSMutableAttributedString.init(string: contentStr)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: contentStr.count)
        attributedStr.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        return attributedStr
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        handleAction?()
    }
    
}

extension String {
    func lk_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func lk_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func lk_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}
