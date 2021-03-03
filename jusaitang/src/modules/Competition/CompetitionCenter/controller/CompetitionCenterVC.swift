//
//  CompetitionCenterVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa

class CompetitionCenterVC: BaseViewController {
    
    let chatButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "communicate"), for: .normal)
        view.imageView?.contentMode = .center
        view.imageView?.clipsToBounds = true
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
    }
    
    override func makeConstraints() {
        super.makeConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "#F7F7FB")
        self.navigationView.rightView = chatButton
        self.navigationView.titleLabel.text = "竞赛中心"
    }
    
}
