//
//  BaseScrollView.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/18.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

class BaseScrollView: UIScrollView {
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
//    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
//        if view.isKind(of: UIButton.self) {
//            return true
//        }
//        if view.isKind(of: UIControl.self) {
//            return true
//        }
//        return super.touchesShouldBegin(touches, with: event, in: view)
//    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton || view is UIControl || view is UILabel {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
    fileprivate func commonInit(){
        backgroundColor = .white
        showsVerticalScrollIndicator = true
        showsHorizontalScrollIndicator = true
        if #available(iOS 11.0, *){
            contentInsetAdjustmentBehavior = .never
            contentInset = .zero
            scrollIndicatorInsets = self.contentInset
        }
        contentInset = .zero
    }
    func bindTo(viewController: UIViewController) {
        if #available(iOS 11.0, *) {
            
        }else{
            viewController.automaticallyAdjustsScrollViewInsets = false
        }
        viewController.edgesForExtendedLayout = []
    }
}
