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
    case upDown
   
    func showAnimation() {
        switch self {
            case .fade:
                showFadeAnimationStyle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { 
                    LKHUD.hideHUD()
                })
            break
            
        case .upDown:
            showUpDownAnimationStyle()
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
        case .upDown:     
            hideUpDownAnimationStyle {
                 completed()
            }
            break
        }
    }
    
//------------------------------------渐隐动画---------------------------------------------------
    private func showFadeAnimationStyle(){
        LKHUD.presentedHudStyleView?.alpha = 0
        UIView.animate(withDuration: 0.5) { 
            LKHUD.presentedHudStyleView?.alpha = 1
        }
    }
    
    private func hideFadeAnimationStyle(completed:@escaping () -> ()){
        UIView.animate(withDuration: 0.3, animations: { 
            LKHUD.presentedHudStyleView?.alpha = 0
        }) { (c) in
            completed()
        }
    }
//------------------------------------渐隐动画---------------------------------------------------
    
    
//------------------------------------从上落下---------------------------------------------------
    private func showUpDownAnimationStyle(){
        
        let hudShowView = LKHUD.presentedHudStyleView!
        let screenHeight = UIScreen.main.bounds.height

        hudShowView.center = CGPoint(x: hudShowView.center.x, y:-hudShowView.frame.height)
        hudShowView.transform = CGAffineTransform(rotationAngle: -.pi/10)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions(rawValue: 0), animations: { 
            LKHUD.presentedHudStyleView?.center = CGPoint(x: hudShowView.center.x, y:screenHeight/2)
            hudShowView.transform = .identity
        }) { (completed) in
            
        }
    }
    
    private func hideUpDownAnimationStyle(completed:@escaping () -> ()){
        
        let hudShowView = LKHUD.presentedHudStyleView!
        let screenHeight = UIScreen.main.bounds.height
       
        UIView.animate(withDuration: 0.3, animations: { 
            LKHUD.presentedHudStyleView?.center = CGPoint(x: hudShowView.center.x, y:screenHeight+hudShowView.frame.height)
            hudShowView.transform = CGAffineTransform(rotationAngle: -.pi/10)
        }) { (c) in
            completed() 
        }
    }
//------------------------------------从上落下---------------------------------------------------

}

enum HUDStyle:HUDViewFactory {
    
    case prompt(String)  //提示信息样式
    case alert(String,String,()->())  //提示信息样式(带确定按钮)
    case option(String,String,String,()->(),String,()->())  //带有取消确认选项样式

    func createHUDView() -> UIView {
        switch self {
            //提示信息
            case .prompt(let title): 
                let promptStyleView = Bundle.main.loadNibNamed("PromptStyleView", owner: nil, options: nil)?.last as! PromptStyleView
                promptStyleView.configTitle(title: title)
                return promptStyleView
            
            //警告提示信息
        case .alert(let title, let desc, let handle): 
                let alertConfirmView = Bundle.main.loadNibNamed("AlertConfirmView", owner: nil, options: nil)?.last as! AlertConfirmView
                alertConfirmView.configAlertConfirm(titleStr: title, descStr: desc, handle: handle)
                return alertConfirmView
        case .option(_, _, _, _, _, _):
            return UIView()
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
