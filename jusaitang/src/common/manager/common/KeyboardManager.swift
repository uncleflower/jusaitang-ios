//
//  KeyboardManager.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/5.
//

import UIKit

class KeyboardManager: NSObject {
    
    static let shared = KeyboardManager()
    
    var duartion:TimeInterval = 0.25
    
    var height:CGFloat = 0
    
    var willAppear:(()->())?
    
    var didAppear:(()->())?
    
    var processOffset:((CGFloat)->())?
    
    var willDisappear:(()->())?
    
    var didDisappear:(()->())?
    
    override init() {
        super.init()
        self.registNotification()
    }
    
    func registNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        // 通知传参
        let userInfo  = notification.userInfo
        // 取出键盘boundsguard
       guard let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else {return}
        self.height = height
        
        self.duartion = (notification as NSNotification).userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        // 动画模式
        let options = UIView.AnimationOptions(rawValue:
         (userInfo![UIResponder.keyboardAnimationCurveUserInfoKey]) as! UInt)
        // 动画
        self.willAppear?()
        let animations:(() -> Void) = {
            self.processOffset?(-height)
        }
        // 判断是否需要动画
        if
        self.duartion > 0 {
            UIView.animate(withDuration:
            self.duartion, delay: 0, options:options, animations: animations, completion: {
                _ in
                self.didAppear?()
            })
        }else{
            
            animations()
        }
    }
    // 将要收起
    @objc func keyboardWillHide(notification:NSNotification){
        let userInfo  = notification.userInfo
     
        self.duartion = (notification as NSNotification).userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval

        guard let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else {return}
        self.height = height
        
        self.willDisappear?()
        
        if self.processOffset == nil {
            self.didDisappear?()
            return
        }
        let animations:(() -> Void) = {
            self.processOffset?(height)
        }
        if
        self.duartion > 0 {
            let options = UIView.AnimationOptions(rawValue:
            (userInfo![UIResponder.keyboardAnimationCurveUserInfoKey]) as! UInt)
            
            UIView.animate(withDuration:
            self.duartion, delay: 0, options:options, animations: animations, completion: {
                _ in
                self.didDisappear?()
            })
        }else{
            animations()
            self.didDisappear?()
        }

    }
}
