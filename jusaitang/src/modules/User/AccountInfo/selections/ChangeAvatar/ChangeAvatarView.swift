//
//  ChangeAvatarView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import SnapKit

enum ChangeAvatar {
    case takePicture
    case choosePhotos
}

class ChangeAvatarView: UIView {
    
    var completion: ((UIImage?) -> Void)? = nil
    
    let containerView: UIView = {
        var view = UIView(frame: CGRect(x: 0, y: App.screenHeight - App.safeAreaBottom, width: App.screenWidth, height: 150 + App.safeAreaBottom))
        view.backgroundColor = .white
        return view
    }()
    
    let bkgs: [UIButton] = {
        var views: [UIButton] = []
        for index in 0 ..< 3 {
            let view = UIButton()
            view.backgroundColor = .white
            views.append(view)
        }
        return views
    }()
    
    let selections: [UILabel] = {
        var views: [UILabel] = []
        for index in 0 ..< 3 {
            let view = UILabel()
            view.textAlignment = .center
            view.font = UIFont.pf_medium(18)
            view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            switch index {
            case 0:
                view.text = "拍照"
            case 1:
                view.text = "从手机相册选择"
            case 2:
                view.text = "取消"
                view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            default:
                break
            }
            
            views.append(view)
        }
        return views
    }()
    
    let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        return view
    }()
    
    let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        for index in 0 ..< 3 {
            containerView.addSubview(bkgs[index])
            containerView.addSubview(selections[index])
        }
        containerView.addSubview(lineView1)
        containerView.addSubview(lineView2)
        makeConstraints()
        
        bkgs[0].addAction {
            [weak self] in
            self?.didClick(way: .takePicture)
        }
        bkgs[1].addAction {
            [weak self] in
            self?.didClick(way: .choosePhotos)
        }
        bkgs[2].addTarget(self, action: #selector(popView), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func popView(){
        UIView.animate(withDuration: 0.35, animations: {
            self.containerView.frame.origin.y = App.screenHeight
            self.backgroundColor = UIColor.black.withAlphaComponent(0)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    func makeConstraints() {
        bkgs[2].snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-App.safeAreaBottom)
            make.height.equalTo(45)
        }
        
        lineView2.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bkgs[2].snp.top)
            make.height.equalTo(5)
        }
        
        bkgs[1].snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(lineView2.snp.top)
            make.height.equalTo(50)
        }
        
        lineView1.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bkgs[1].snp.top)
            make.height.equalTo(1)
        }
        
        bkgs[0].snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(lineView1.snp.top)
            make.height.equalTo(50)
        }
        
        for index in 0 ..< 3 {
            selections[index].snp.makeConstraints { (make) in
                make.center.equalTo(bkgs[index])
                make.width.lessThanOrEqualTo(140)
                make.height.equalTo(25)
            }
        }
    }
    
    func show(completion: ((UIImage?) -> Void)? = nil) {
        self.completion = completion
        
        guard let window = UIApplication.shared.windows.first else {return}
        window.addSubview(self)
        UIView.animate(withDuration: 0.25) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.containerView.frame.origin.y = App.screenHeight - 150 - App.safeAreaBottom
        }
    }
    
    func didClick(way: ChangeAvatar) {
        if way == .takePicture {
            takePicture()
        } else if way == .choosePhotos {
            choosePhotos()
        }
    }
    
    func takePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        App.navigationController?.show(picker, sender: self)
    }
    
    func choosePhotos() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        App.navigationController?.show(picker, sender: self)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let rect = CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight - containerView.height)
        if rect.contains(point) {
            return bkgs[2]
        }
        return super.hitTest(point, with: event)
    }
}

extension ChangeAvatarView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        completion?(image)
        picker.dismiss(animated: true, completion: nil)
        self.removeFromSuperview()
//        let imageData = image.jpegData(compressionQuality: 0.1) ?? Data()
//        CommonAPI.uploadImage(image: UIImage(data: imageData)!.fixOrientation(), path: "/x/api/avatar") {[weak self] (res, error) in
//            if let error = error {
//                ErrorAlertView.show(error: error, style: .topError)
//                return
//            }
//            guard let res = res else {return}
//            let req = MineAPI.ChangeNameOrAvatarReq()
//            req.avatar = res.url
//            MineAPI.changeNameOrAvatar(request: req) { (error) in
//                if let error = error {
//                    ErrorAlertView.show(error: error, style: .topError)
//                    return
//                }
//            }
//            self?.completion!(res.url)
//        }
    }
}
