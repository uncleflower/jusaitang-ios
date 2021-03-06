//
//  UserCenterVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa

class UserCenterVC: BaseViewController {
    
    let logoutButton: UIButton = {
        let view = UIButton()
        view.setTitle("退出登录", for: .normal)
        view.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        view.titleLabel?.font = UIFont.pf_semibold(24)
        return view
    }()
    
    let avatarImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.borderColor = UIColor(hexString: "#E5E5E5")
        view.cornerRadius = 36
        return view
    }()
    
    let usernameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_semibold(16)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    let smallTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(12)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        return view
    }()
    
    let myInfoButton: MyHeadSelectionView = {
        let view = MyHeadSelectionView()
        view.iconView.image = UIImage(named: "mine_order")
        view.titleLabel.text = "账号信息"
        view.addAction {
            Router.openAccountInfo()
        }
        return view
    }()
    
    let myCompetitionButton: MyHeadSelectionView = {
        let view = MyHeadSelectionView()
        view.iconView.image = UIImage(named: "mine_dynamic")
        view.titleLabel.text = "我的比赛"
        view.addAction {
        }
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#E5E5E5")
        return view
    }()
    
    let mySelectionViews: [MySelectionView] = {
        var views: [MySelectionView] = []
        for index in 0 ..< 3 {
            let view = MySelectionView()
            switch index {
            case 0:
                view.selectionImg.image = UIImage(named: "mine_invite")
                view.selectionLabel.text = "邀请好友"
            case 1:
                view.selectionImg.image = UIImage(named: "mine_feedback")
                view.selectionLabel.text = "意见反馈"
                view.addAction {
                    Router.openFeedback()
                }
            case 2:
                view.selectionImg.image = UIImage(named: "mine_aboutus")
                view.selectionLabel.text = "关于我们"
                view.addAction {
                    Router.openAboutUs()
                }
            default:
                break
            }
            views.append(view)
        }
        return views
    }()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(avatarImg)
        view.addSubview(usernameLabel)
        view.addSubview(smallTitle)
        view.addSubview(myInfoButton)
        view.addSubview(myCompetitionButton)
        view.addSubview(lineView)
        for index in 0 ..< mySelectionViews.count {
            view.addSubview(mySelectionViews[index])
        }
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        avatarImg.snp.makeConstraints { (make) in
            make.top.equalTo(App.navigationBarHeight + 29)
            make.centerX.equalToSuperview()
            make.width.equalTo(72)
            make.height.equalTo(72)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImg.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(300)
            make.height.equalTo(22)
        }
        
        smallTitle.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(300)
            make.height.equalTo(17)
        }
        
        myInfoButton.snp.makeConstraints { (make) in
            make.top.equalTo(smallTitle.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(App.screenWidth / 5)
            make.width.equalTo(45)
            make.height.equalTo(66)
        }
        
        myCompetitionButton.snp.makeConstraints { (make) in
            make.top.equalTo(smallTitle.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-App.screenWidth / 5)
            make.width.equalTo(45)
            make.height.equalTo(66)
        }
        
        for index in 0 ..< mySelectionViews.count {
            if index == 0 {
                mySelectionViews[index].snp.makeConstraints { (make) in
                    make.top.equalTo(myInfoButton.snp.bottom).offset(20)
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.height.equalTo(60)
                }
            } else if index == 1 {
                lineView.snp.makeConstraints { (make) in
                    make.top.equalTo(mySelectionViews[index-1].snp.bottom).offset(5)
                    make.leading.equalToSuperview().offset(16)
                    make.trailing.equalToSuperview().offset(-16)
                    make.height.equalTo(0.5)
                }
                mySelectionViews[index].snp.makeConstraints { (make) in
                    make.top.equalTo(lineView.snp.bottom).offset(4)
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.height.equalTo(60)
                }
            } else {
                mySelectionViews[index].snp.makeConstraints { (make) in
                    make.top.equalTo(mySelectionViews[index-1].snp.bottom)
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.height.equalTo(60)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = DataManager.shared.user else {return}
        avatarImg.setImage(url: apiHost + user.avatar)
        usernameLabel.text = "\(user.name) \(user.college.collegeName)"
        smallTitle.text = "\(user.period)级 \(user.userClassName)"
        
        mySelectionViews[0].addAction {
            let shareSeleView = ShareAppView(frame: CGRect.init(x: 0, y: 0, width: App.screenWidth, height:  App.screenHeight))
            shareSeleView.show { (share) in
                print(share)
            }
        }
    }
}
