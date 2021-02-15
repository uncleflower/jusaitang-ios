//
//  BaseTableView.swift
//  UWatChat
//
//  Created by Don.shen on 2020/5/14.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    override func awakeFromNib() {
       super.awakeFromNib()
       commonInit()
    }
    override init(frame: CGRect, style: UITableView.Style) {
       super.init(frame: frame, style: style)
       commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       commonInit()
    }
    fileprivate func commonInit(){
       backgroundColor = .white
       separatorStyle = .none
       showsVerticalScrollIndicator = true
       showsHorizontalScrollIndicator = true
       estimatedRowHeight = 0
       estimatedSectionFooterHeight = 0
       estimatedSectionHeaderHeight = 0
       if #available(iOS 11.0, *){
         contentInsetAdjustmentBehavior = .never
         contentInset = .zero
         scrollIndicatorInsets = self.contentInset
       }
       contentInset = .zero
       tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0.01))
    }
    func bindTo(viewController: UIViewController) {
       if #available(iOS 11.0, *) {

       }else{
           viewController.automaticallyAdjustsScrollViewInsets = false
       }
       viewController.edgesForExtendedLayout = []
    }
}
