//
//  CompetitionsView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/3.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CompetitionsView: UITableViewCell {
    
    var viewModel: CompetitionsVM!
    
    var disposeBag = DisposeBag()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 8
        return view
    }()
    
    let competitionSelectionsView: [CompetitionSelectionView] = {
        var views: [CompetitionSelectionView] = []
        for i in 0 ..< 4 {
            let view = CompetitionSelectionView()
            views.append(view)
        }
        return views
    }()
    
    let competitionCollectionView: CompetitionCollectionView = {
        let view = CompetitionCollectionView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(hexString: "#F7F7FB")
        contentView.addSubview(containerView)
        for index in 0 ..< 4 {
            containerView.addSubview(competitionSelectionsView[index])
        }
        containerView.addSubview(competitionCollectionView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        let width = Int(App.screenWidth) - 30 - competitionSelectionsView.count * 60
        let space = width / (competitionSelectionsView.count + 1)
        let orgin = space
        
        for index in 0 ..< competitionSelectionsView.count {
            if index == 0 {
                competitionSelectionsView[index].snp.makeConstraints { (make) in
                    make.leading.equalToSuperview().offset(orgin)
                    make.top.equalToSuperview().offset(22)
                    make.width.equalTo(60)
                    make.height.equalTo(62)
                }
            } else {
                competitionSelectionsView[index].snp.makeConstraints { (make) in
                    make.leading.equalTo(competitionSelectionsView[index-1].snp.trailing).offset(space)
                    make.top.equalToSuperview().offset(22)
                    make.width.equalTo(60)
                    make.height.equalTo(62)
                }
            }
        }
        
        competitionCollectionView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }
    }
    
    func bindViewModel(viewModel: CompetitionsVM) {
        self.viewModel = viewModel
        competitionCollectionView.bindViewModel(viewModel: viewModel.competitionCollectionVM)
        
        viewModel.selectionModels.subscribe(onNext: {[weak self] models in
            guard models.count != 0 else {return}
            for index in 0 ..< self!.competitionSelectionsView.count {
                self?.competitionSelectionsView[index].loadData(model: models[index])
                self?.competitionSelectionsView[index].removeAction()
                self?.competitionSelectionsView[index].addAction { [weak self] in
                    self?.getCompetitionByType(competitionTypeID: models[index].type)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func getCompetitionByType(competitionTypeID: String) {
        viewModel.competitionCollectionVM.getCompetitionByType(competitionTypeID: competitionTypeID) { (error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
        }
    }
    
}
