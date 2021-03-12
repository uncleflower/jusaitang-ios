//
//  ShareAppView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/6.
//

import UIKit
import SnapKit

class ShareAppView: UIView {
    
    var complete: ((String) -> Void)? = nil
    
    var viewModel: ShareAppVM = .init()
    
    let smallTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(14)
        view.text = "分享"
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return view
    }()
    
    let bkgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight))
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: App.screenWidth, height: 184))
        view.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    var collection: UICollectionView
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.itemSize = ShareAppVM.itemSize
        collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = false
        collection.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        collection.register(ShareAppCell.self, forCellWithReuseIdentifier: "ShareAppCell")
        backgroundColor = UIColor(hexString: "#000000", alpha: 0)
        
        addSubview(bkgView)
        addSubview(containerView)
        containerView.addSubview(smallTitle)
        containerView.addSubview(collection)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimiss))
        bkgView.addGestureRecognizer(tap)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        
        smallTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(smallTitle.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func show(_ complete:((String) -> Void)? = nil) {
        self.complete = complete
        prepare()
        
        guard let window = UIApplication.shared.windows.first else {return}
        window.addSubview(self)
        
        UIView.animate(withDuration: 0.35) {
            self.backgroundColor = UIColor(hexString: "#000000", alpha: 0.5)
            self.containerView.frame.origin.y = App.screenHeight - self.containerView.frame.height
        }
    }
    
    func prepare() {
        containerView.frame.origin.y = App.screenHeight
    }
    
    func share(scene: shareScene) {
        let webpageObject = WXWebpageObject()
        let share = ConfigCenter.shared.share
        webpageObject.webpageUrl = "https://www.tracys.cn/"
        let message = WXMediaMessage()
        message.title = share.title
        message.description = share.detail
        message.setThumbImage(UIImage(named: "AppIcon")!)

        message.mediaObject = webpageObject
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        switch scene {
        case .wechat:
            req.scene = Int32(WXSceneSession.rawValue)
        case .moment:
            req.scene = Int32(WXSceneTimeline.rawValue)
        default:
            break
        }
        WXApi.send(req) { (_) in
            self.dimiss()
        }
    }
    
    @objc func dimiss() {
        UIView.animate(withDuration: 0.35, animations: {
            self.backgroundColor = UIColor(hexString: "#000000", alpha: 0)
            self.containerView.frame.origin.y = App.screenHeight
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}


extension ShareAppView: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if WXApi.isWXAppInstalled() {
            let cell = collectionView.cellForItem(at: indexPath) as! ShareAppCell
            share(scene: cell.viewModel.scene)
        } else {
            let alert = SlightAlert(title: "你尚未安装微信，不可使用此功能")
        //        let alert = SlightAlert(title: "功能正在开发中")
            alert.show()
        }
    }
}

extension ShareAppView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.shareAppCellVMs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareAppCell", for: indexPath) as! ShareAppCell
        cell.bindViewModel(viewModel: viewModel.shareAppCellVMs[indexPath.item])
        return cell
    }
    
}
