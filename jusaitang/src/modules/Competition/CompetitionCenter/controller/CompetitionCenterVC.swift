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
    
    let viewModel = CompetitionCenterVM()
    
    let chatButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "communicate"), for: .normal)
        view.imageView?.contentMode = .center
        view.imageView?.clipsToBounds = true
        return view
    }()
    
    let competitionsView: CompetitionsView = {
        let view = CompetitionsView()
        view.cornerRadius = 8
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(competitionsView)
        
        loadData()
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        competitionsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20 + App.naviStatusHeight)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(340)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundColor
        self.navigationView.rightView = chatButton
        self.navigationView.titleLabel.text = "竞赛中心"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        competitionsView.bindViewModel(viewModel: viewModel.competitionsVM)
    }
    
    func loadData() {
        viewModel.competitionsVM.getCompetitionTypes { (error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
        }
    }
    
}
