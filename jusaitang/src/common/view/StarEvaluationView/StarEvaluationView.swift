//
//  StarEvaluationView.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/23.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

//block回调
typealias StarEvaluationTapBlock = (_ starEvaluationView: StarEvaluationView,_ index : Int) ->()

class StarEvaluationView: UIView {
    
    //block回调

    var starEvaluationTapBlock: StarEvaluationTapBlock!
    
    //默认图片
    var defaultImage: UIImage?
    
    //高亮图片
    var lightImage: UIImage?
    
    
    
    /// 星级评定
    ///
    /// - Parameters:
    ///   - frame: 视图frame
    ///   - starIndex: 评定星级级别
    ///   - starWidth: 每个星星的宽度
    ///   - starSpace: 星星之间的间隔
    ///   - normalImage: 默认状态图片
    ///   - lightImage: 高亮状态图片
    ///   - isCanTap: 上方可以编辑
    init(frame: CGRect, index starIndex: Int, width starWidth: CGFloat = 20, space starSpace: CGFloat = 5, normalImage defaultImage: UIImage = UIImage(named: "star_evaluation_normal")!,selectImage lightImage: UIImage = UIImage(named: "star_evaluation_light")!, isCanEdit isCanTap: Bool) {
        super.init(frame: frame)
        self.defaultImage = defaultImage
        self.lightImage = lightImage
        
        setupUI(index: starIndex, width: starWidth, space: starSpace, isTap: isCanTap)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(index starIndex: Int, width starWidth: CGFloat, space starSpace: CGFloat, isTap isCanTap: Bool){
        for i in 0..<5 {
            let btn = UIButton()
            btn.frame = CGRect(x: CGFloat(i) * (starWidth + starSpace), y: 0, width: starWidth, height: self.height)
            btn.tag = i + 1
            if isCanTap {
                btn.addTarget(self, action: #selector(starTapBtn(_:)), for: .touchDown)
            }
            btn.imageEdgeInsets = UIEdgeInsets(top: (self.height - starWidth) * 0.5, left: 0, bottom: (self.height - starWidth) * 0.5, right: 0)
            if i < starIndex {
                btn.setImage(self.lightImage, for: .normal)
            } else {
                btn.setImage(self.defaultImage, for: .normal)
            }
            btn.adjustsImageWhenHighlighted = false
            self.addSubview(btn)
            
            self.width = (starWidth + starSpace) * 5
        }
    }
    
    func setStars(count: Int) {
        for i in 1...5 {
            let btn = self.viewWithTag(i) as! UIButton
            if i <= count {
                btn.setImage(self.lightImage, for: .normal)
            } else {
                btn.setImage(self.defaultImage, for: .normal)
            }
        }
    }
    
    @objc func starTapBtn(_ sender: UIButton) {
        for i in 1...5  {
            let starBtn = self.viewWithTag(i) as! UIButton
            if i <= sender.tag {
                starBtn.setImage(self.lightImage, for: .normal)
            } else {
                starBtn.setImage(self.defaultImage, for: .normal)
            }
        }
        
        if starEvaluationTapBlock != nil {
            starEvaluationTapBlock(self, sender.tag)
        }
    }
}
