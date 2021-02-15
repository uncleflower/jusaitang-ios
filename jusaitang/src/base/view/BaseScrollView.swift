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
