//
//  CycleScrollView.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/9/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit


protocol CycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: CycleScrollView, cellForItemAt item: Int) -> CycleScrollViewCell
}
protocol CycleScrollViewDataSource {
    func numberOfItems(_ collectionView: UICollectionView) -> Int
}

class CycleScrollView: UIView {
    var delegate:CycleScrollViewDelegate?
    var dataSource:CycleScrollViewDataSource?
    
    
    let collectionView: UICollectionView
    
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints { (view) in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }
    
    func reloadData(){
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String){
         collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    open func dequeueReusableCell(withReuseIdentifier identifier: String, for item: Int) -> CycleScrollViewCell{
        return self.collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: IndexPath(item: item, section: 0)) as! CycleScrollViewCell
    }
}


extension CycleScrollView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = delegate?.cycleScrollView(self, cellForItemAt: indexPath.item){
            return cell
        }
        return CycleScrollViewCell.init()
    }
}


extension CycleScrollView:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = dataSource?.numberOfItems(collectionView){
            return count
        }
        return 0
    }
}
