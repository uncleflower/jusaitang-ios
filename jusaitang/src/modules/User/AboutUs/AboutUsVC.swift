//
//  AboutUsVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxSwift
import RxCocoa

class AboutUsVC: BaseViewController {
    
    private let disposeBag = DisposeBag()
    
    let dismissButon: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.contentMode = .center
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let icon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "logo")
        view.contentMode = .scaleAspectFill
        view.cornerRadius = 15
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        return view
    }()
    
    let bigTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_semibold(18)
        view.text = "聚赛堂"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    let versionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(13)
        view.text = "版本号 V\((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "")"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return view
    }()
    
    let lineViews: [UIView] = {
        var views: [UIView] = []
        for index in 0 ..< 3 {
            let view = UIView()
            view.backgroundColor = UIColor(hexString: "#E5E5E5")
            views.append(view)
        }
        return views
    }()
    
    let arrows: [UIImageView] = {
        var views: [UIImageView] = []
        for index in 0 ..< 2 {
            let view = UIImageView()
            view.image = UIImage(named: "login_arrow")
            views.append(view)
        }
        return views
    }()
    
    let leftBtns: [UIButton] = {
        var views: [UIButton] = []
        for index in 0 ..< 2 {
            let view = UIButton()
            view.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
            view.titleLabel?.font = UIFont.pf_medium(14)
            view.contentHorizontalAlignment = .left
            if index == 0{
                view.setTitle("版本更新", for: .normal)
            } else {
                view.setTitle("去评价", for: .normal)
            }
            views.append(view)
        }
        return views
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(icon)
        view.addSubview(bigTitle)
        view.addSubview(versionLabel)
        for index in 0 ..< 3 {
            view.addSubview(lineViews[index])
        }
        for index in 0 ..< 2 {
            view.addSubview(arrows[index])
            view.addSubview(leftBtns[index])
            leftBtns[index].addAction {
                [weak self] in
                self?.gotoAppStore()
            }
        }
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        icon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(App.naviStatusHeight + 56)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        bigTitle.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(55)
            make.height.equalTo(25)
        }
        
        versionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bigTitle.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(18)
        }
        
        for index in 0 ..< 3 {
            if index == 0 {
                lineViews[index].snp.makeConstraints { (make) in
                    make.top.equalTo(versionLabel.snp.bottom).offset(50)
                    make.leading.equalToSuperview().offset(30)
                    make.trailing.equalToSuperview().offset(-30)
                    make.height.equalTo(0.5)
                }
            } else {
                lineViews[index].snp.makeConstraints { (make) in
                    make.top.equalTo(lineViews[index-1].snp.bottom).offset(50)
                    make.leading.equalToSuperview().offset(30)
                    make.trailing.equalToSuperview().offset(-30)
                    make.height.equalTo(0.5)
                }
            }
        }
        
        for index in 0 ..< 2 {
            leftBtns[index].snp.makeConstraints { (make) in
                make.top.equalTo(lineViews[index].snp.bottom).offset(15)
                make.leading.equalTo(lineViews[index].snp.leading)
                make.trailing.equalTo(lineViews[index].snp.trailing)
                make.height.equalTo(20)
            }
            arrows[index].snp.makeConstraints { (make) in
                make.centerY.equalTo(leftBtns[index])
                make.trailing.equalToSuperview().offset(-40)
                make.width.equalTo(5)
                make.height.equalTo(10.5)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationView.leftView = dismissButon
        self.navigationView.titleLabel.text = "关于我们"
        self.navigationView.titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.navigationView.titleLabel.font = UIFont.pf_medium(16)
        
        self.dismissButon.addTarget(self, action: #selector(popView), for: .touchUpInside)
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func gotoAppStore() {
//        let urlString = "itms-apps://itunes.apple.com/app/id1527068188"
//        guard let url = URL(string: urlString) else { return }
//        UIApplication.shared.open(url, options:[:], completionHandler: nil)
    }
    
}
