//
//  ImagePickerVC.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/25.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImagePickerVC: BaseViewController {
    
    var completion: (([ImageModel]?) -> Void)? = nil
    
    private let disposeBag = DisposeBag()
    
    var limitPhotos: Int = 0
    
    let viewModel: ImagePickerVM = .init()
    
    var collection: UICollectionView
    
    let dismissBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let selectAlbumBtn: UIButton = {
        let view = UIButton()
        view.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
        view.setTitle("最近照片", for: .normal)
        view.titleLabel?.font = UIFont.pf_medium(16)
        return view
    }()
    
    let selectAlbumView: SelectAlbumView = {
        let view = SelectAlbumView(frame: CGRect(x: 0, y: -180 + App.naviStatusHeight, width: App.screenWidth, height: 180))
        return view
    }()
    
    let bkgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    let confirmBtn: UIButton = {
        let view = UIButton()
        view.setTitle("确定", for: .normal)
        view.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
        view.titleLabel?.font = UIFont.pf_medium(14)
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(collection)
        view.addSubview(bkgView)
        view.addSubview(selectAlbumView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        collection.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func bindViewModel() {
        selectAlbumView.bindViewModel(viewModels: self.viewModel.albumLibrarys)
        
        viewModel.selectedAlbumObservable.subscribe(onNext: {[weak self] (album) in
            self?.selectAlbumBtn.setTitle(album.title, for: .normal)
            self?.collection.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView.leftView = dismissBtn
        navigationView.rightView = confirmBtn
        dismissBtn.addTarget(self, action: #selector(popView), for: .touchUpInside)
        selectAlbumBtn.addTarget(self, action: #selector(showAlbum), for: .touchUpInside)
        confirmBtn.addTarget(self, action: #selector(didClick), for: .touchUpInside)
        navigationView.backgroundColor = .white
        navigationView.centerView = selectAlbumBtn
        
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        collection.contentInset = UIEdgeInsets.init(top: App.navigationBarHeight, left: 0, bottom: 0, right: 0)
        collection.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    @objc func showAlbum() {
        let albumLibrarys = self.viewModel.albumLibrarys
        
        prepare()
        selectAlbumView.bindViewModel(viewModels: albumLibrarys)
        selectAlbumView.didSelect = {
            albumVM in
            guard let albumVM = albumVM else {return}
            _ = self.viewModel.albumLibrarys.map { (albumVM) in
                albumVM.isSelect = false
                self.hideSelectAlubmView()
            }
            albumVM.isSelect = true
            self.viewModel.selectedAlbumObservable.onNext(albumVM)
        }
        
        UIView.animate(withDuration: 0.35) {
            self.bkgView.alpha = 0.5
            self.selectAlbumView.frame.origin.y = App.naviStatusHeight
        }
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didClick() {
        completion?(viewModel.selectedImgs)
        popView()
    }
    
    func hideSelectAlubmView() {
        bkgView.snp.remakeConstraints { (make) in
            make.bottom.equalToSuperview().offset(App.screenHeight)
        }
        
        UIView.animate(withDuration: 0.35, animations: {
            self.selectAlbumView.frame.origin.y = -self.selectAlbumView.height
        })
        
        for index in 0 ..< 4 {
            selectAlbumView.albumSelectionVs[index].isSelectedImg.isHidden = true
        }
        bkgView.alpha = 0
    }
        
    func prepare() {
        bkgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        selectAlbumView.frame.origin.y = -selectAlbumView.height
    }
    
    init(limitPhotos: Int,selectedImgs: [ImageModel]? = nil) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.itemSize = ImagePickerVM.itemSize
        collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        
        self.limitPhotos = limitPhotos
        if let selectedImgs = selectedImgs {
            self.viewModel.selectedImgs = selectedImgs
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ImagePickerVC: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        
        guard
            let viewModel = cell.viewModel,
            let isSelected = try? viewModel.isSelectObservable.value()
            else {return}
        if isSelected {
            self.viewModel.selectedImgs = self.viewModel.selectedImgs.filter({ (model) -> Bool in
                model.id == viewModel.model.id
            })
            viewModel.isSelectObservable.onNext(false)
        }else{
            if self.viewModel.selectedImgs.count < limitPhotos {
                self.viewModel.selectedImgs.append(viewModel.model)
                viewModel.isSelectObservable.onNext(true)
            }
        }
    }
}

extension ImagePickerVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let images = try? viewModel.selectedAlbumObservable.value() {
            return images.images.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let albumVM = try? viewModel.selectedAlbumObservable.value()
        cell.bindViewModel(viewModel: albumVM!.images[indexPath.item])
        
        return cell
    }
}
