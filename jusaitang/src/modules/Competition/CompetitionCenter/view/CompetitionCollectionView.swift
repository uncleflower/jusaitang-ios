//
//  CompetitionCollectionView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CompetitionCollectionView: UIView {
    
    var viewModel: CompetitionCollectionVM!
    
    var collection: UICollectionView
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        layout.scrollDirection = .horizontal
        layout.itemSize = CompetitionCollectionVM.itemSize
        collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        collection.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        collection.register(CompetitionCollectionCell.self, forCellWithReuseIdentifier: "CompetitionCollectionCell")
        
        addSubview(collection)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        collection.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func bindViewModel(viewModel: CompetitionCollectionVM) {
        self.viewModel = viewModel
        
        self.viewModel.getCompetitionByType { (error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
        }
        
        self.viewModel.competitionCollectionCellVMs.subscribe(onNext: {[weak self] vms in
            self?.collection.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension CompetitionCollectionView: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension CompetitionCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = try? viewModel.competitionCollectionCellVMs.value().count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CompetitionCollectionCell", for: indexPath) as! CompetitionCollectionCell
        if let vm = try? viewModel.competitionCollectionCellVMs.value()[indexPath.item] {
            cell.bindViewModel(viewModel: vm)
            cell.addShadow(ofColor: UIColor.black, radius: 5, offset: CGSize(width: 0.5, height: 0.5), opacity: 0.5)
        }
        return cell
    }
    
    
}


