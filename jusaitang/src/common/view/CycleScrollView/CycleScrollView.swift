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
    func cycleScrollView(_ cycleScrollView: CycleScrollView, didSelectItemAt item: Int)
    func cycleScrollViewDidScroll(_ cycleScrollView: CycleScrollView)
}
protocol CycleScrollViewDataSource {
    func numberOfItems(_ collectionView: CycleScrollView) -> Int
}

class CycleScrollView: UIView {
    var delegate:CycleScrollViewDelegate?
    var dataSource:CycleScrollViewDataSource?
    
    var time:Timer!
    
    let collectionView: UICollectionView
    
    var page:Int {
        return collectionView.horizontalPage
    }
    
    
    var contentOffset:CGPoint {
        return collectionView.contentOffset
    }
    
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
    
    func autoScroll(){
        if time == nil{
            time = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(_autoScroll), userInfo: nil, repeats: true)
        }

    }
    
    @objc func _autoScroll(){
        guard let count = self.dataSource?.numberOfItems(self) else {return}
        
        var current = collectionView.horizontalPage
        if current == count - 1 {
            current = 0
        }else{
            current += 1
        }
        collectionView.scrollToHorizontalPage(page: current)
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
        collectionView.contentOffset.x = 0
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleScrollView(self, didSelectItemAt: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.cycleScrollViewDidScroll(self)
    }
}


extension CycleScrollView:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = dataSource?.numberOfItems(self){
            return count
        }
        return 0
    }
}
