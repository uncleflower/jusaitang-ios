//
//  UIScrollviewExtension.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/9.
//

import UIKit

extension UIScrollView {
    var horizontalPage:Int {
        get{
            if contentOffset.x <= 0 {
                return 0
            }
            else if (contentOffset.x < contentSize.width - frame.size.width / 2 ){
                return lroundf(Float(contentOffset.x / self.frame.size.width))
            }else{
                return Int(contentOffset.x / frame.size.width)
                
            }
        }set{
            let targetWidth = CGFloat(newValue) * frame.size.width
            if targetWidth < contentSize.width {
                self.contentOffset.x = targetWidth
            }else{
                self.contentOffset.x = contentSize.width
            }
        }
    }
    
    func scrollToBottom(animated: Bool = true) {
        if (self.contentSize.height + self.contentInset.top) >= self.frame.height {
            self.setContentOffset(CGPoint(x: self.contentOffset.x, y:self.contentSize.height + self.contentInset.bottom - self.frame.height), animated: animated)
        }
    }
    
    @objc func scrollToNextPage(animated: Bool = true) {
        let next = self.horizontalPage + 1
        self.scrollToHorizontalPage(page: next, animated: animated)
    }
    
    @objc func scrollToHorizontalPage(page: Int, animated: Bool = true) {
        if self.isDragging{
            return
        }
        
        var targetOffsetX = CGFloat(page) * self.frame.size.width
        if targetOffsetX > (self.contentSize.width - self.frame.size.width){
            targetOffsetX = (self.contentSize.width -  self.frame.size.width)
        }
        targetOffsetX = floor(targetOffsetX)
        self.setContentOffset(CGPoint.init(x: targetOffsetX, y: self.contentOffset.y), animated: animated)
    }
    
    func clearInset(){
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
}


