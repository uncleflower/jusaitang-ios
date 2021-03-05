//
//  SlightAlert.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import UIKit
import SnapKit

class SlightAlert: UIView {
    
    var timer: Timer?
    var second = 1
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#4C4C4C")
        view.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let title: String?
    
    let image: String?
    
    init(title: String? = nil, image: String? = nil) {
        self.title = title
        self.image = image
        super.init(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight))
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(imageView)
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.lessThanOrEqualTo(300)
            make.height.lessThanOrEqualTo(300)
        }
                
        if image != nil {
            imageView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(containerView).offset(24)
                make.width.lessThanOrEqualTo(50)
                make.height.lessThanOrEqualTo(50)
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom).offset(13)
                make.leading.equalToSuperview().offset(33)
                make.trailing.equalToSuperview().offset(-33)
                make.height.equalTo(20)
                make.bottom.equalToSuperview().offset(-8)
            }
            return
        }
        
        if title != nil {
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(17)
                make.bottom.equalToSuperview().offset(-17)
                make.leading.equalToSuperview().offset(33)
                make.trailing.equalToSuperview().offset(-33)
            }
        }
    }
    
    func show() {
        makeConstraints()
        prepare()
        
        guard let window = UIApplication.shared.windows.first else {return}
        window.addSubview(self)
        
        UIView.animate(withDuration: 0.35) {
            self.containerView.alpha = 1
        }
    }
    
    func prepare() {
        titleLabel.text = title
        if let image = image {
            imageView.image = UIImage(named: image)
        }
        
        containerView.alpha = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideView), userInfo: nil, repeats: true)
        timer!.fire()
    }
    
    @objc func hideView() {
        if second > 0 {
            second -= 1
            return
        }
        
        UIView.animate(withDuration: 0.35, animations: {
            self.containerView.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
//            self.timer!.invalidate()
            self.timer = nil
        }
    }
}
