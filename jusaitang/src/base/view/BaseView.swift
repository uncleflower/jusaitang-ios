//
//  BaseView.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/6.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//


import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func commonInit() { }
}

