//
//  LKHUD.swift
//  LKHUDDemo
//
//  Created by 林凯李 on 2018/1/13.
//  Copyright © 2018年 林凯李. All rights reserved.
//

import Foundation
import UIKit

protocol HUDViewFactory {
    func createHUDView() -> UIView
}

protocol HUDViewAnimationFactory {
    func showAnimation()  //显示动画
    func hideAnimation(completed:@escaping ()->())  //隐藏动画
}

enum HUDAnimationStyle:HUDViewAnimationFactory {
   
    case fade
   
    func showAnimation() {
        switch self {
            case .fade:
                showFadeAnimationStyle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { 
                    LKHUD.hideHUD()
                })
            break
        }
    }
    
    func hideAnimation(completed:@escaping () -> ()) {
        switch self {
        case .fade: 
            hideFadeAnimationStyle {
                completed()
            }
            break
        }
    }
    
    private func showFadeAnimationStyle(){
        print("执行了渐隐显示动画")
        LKHUD.presentedHudStyleView?.alpha = 0
        UIView.animate(withDuration: 0.5) { 
            LKHUD.presentedHudStyleView?.alpha = 1
        }
    }
    
    private func hideFadeAnimationStyle(completed:@escaping () -> ()){
        print("执行了渐隐隐藏动画")
        UIView.animate(withDuration: 0.5, animations: { 
            LKHUD.presentedHudStyleView?.alpha = 0
        }) { (c) in
            completed()
        }
    }
}

enum HUDStyle:HUDViewFactory {
    
    case promptStyle(String)  //提示信息样式
    
    func createHUDView() -> UIView {
        switch self {
            case .promptStyle(let title): 
                //提示信息
                let promptStyleView = Bundle.main.loadNibNamed("PromptStyleView", owner: nil, options: nil)?.last as! PromptStyleView
                
                promptStyleView.configTitle(title: title)
               
                return promptStyleView
        }
    }
}

class LKHUD {
    
    static private var topVC: UIViewController{
        let getTopVC = UIApplication.shared.keyWindow?.rootViewController
        return getTopVC!
    }
    
    static private func createHudVc() -> LKHUDVC{
        let hud = UIStoryboard(name: "LKHUDVC", bundle: nil).instantiateViewController(withIdentifier: "LKHUDVC")
        return hud as! LKHUDVC
    }
    
    static private weak var presentedVC:LKHUDVC?
    static private var currentAnimationStyle:HUDAnimationStyle?
    static weak var presentedHudStyleView:UIView?
    
    static func showHUD(HUDStyle:HUDStyle, animationStyle:HUDAnimationStyle){
        //弹出
        print("弹出")
        
        DispatchQueue.main.async {
            
            let hudVC = createHudVc()
            
            let HUDStyleView = HUDStyle.createHUDView()
            presentedHudStyleView = HUDStyleView
            
            hudVC.HUDStyleView = HUDStyleView
            hudVC.HUDAnimationStyle = animationStyle
            hudVC.view .addSubview(HUDStyleView)
            
            topVC.addChildViewController(hudVC)
            topVC.view .addSubview(hudVC.view)
            
            presentedVC = hudVC
            currentAnimationStyle = animationStyle
        }
    
    }
    
    static func hideHUD(){
        //消失
        if let presented = presentedVC {
            
            LKHUD.currentAnimationStyle!.hideAnimation(completed: { 
                presented.dismiss(completed: { (vc) in
                    print("消失")
                    vc.view.removeFromSuperview()
                    vc.removeFromParentViewController()
                })
            })
        }
    }
    
}
