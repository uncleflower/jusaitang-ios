//
//  CycleScrollViewCell.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/9/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

class CycleScrollViewCell: UICollectionViewCell {
    
    var view:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView(cellClass: UIView.Type){
        if view == nil{
            
        }
    }
    
}

