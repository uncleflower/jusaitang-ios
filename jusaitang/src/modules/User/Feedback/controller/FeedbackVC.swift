//
//  FeedbackVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/5.
//

import UIKit
import RxSwift
import RxCocoa

class FeedbackVC: BaseViewController {
    
    private let disposeBag = DisposeBag()
    
    let viewModel = FeedbackVM()
    
    let dismissButon: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.contentMode = .center
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let opinionTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.text = "问题和意见"
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return view
    }()
    
    let opinionTextView: TextViewWithPh = {
        let view = TextViewWithPh()
        view.placeholder = "请尽可能详细的描述问题以使我们提供更好的帮助，如果是闪退或BUG，请您详细说明下是点击什么地方出现的，最好前后相关联页面的操作都说明一下，以便我们更好的复现问题，及时处理，非常感谢您的支持，谢谢！"
        view.placeholderColor = UIColor(hexString: "#C0C0C0")
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10);
        view.backgroundColor = .white
        view.font = UIFont.pf_medium(14)
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    let wordsCount: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.text = "0/200"
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return view
    }()
    
    let imgTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.text = "图片（选填，提供问题截图）"
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return view
    }()
    
    let imgCount: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.text = "0/4"
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return view
    }()
    
    let submitBtn: UIButton = {
        let btn = UIButton()
        btn.cornerRadius = 10
        btn.setTitle("提交反馈", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.pf_semibold(14)
        btn.backgroundColor = UIColor.default
        return btn
    }()
    
    let collection: UICollectionView
    
    override func loadView() {
        super.loadView()
        
        self.navigationView.backgroundColor = .white
        self.navigationView.leftView = dismissButon
        self.navigationView.titleLabel.text = "意见反馈"
        self.navigationView.titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.navigationView.titleLabel.font = UIFont.pf_medium(16)
        
        view.addSubview(opinionTitle)
        view.addSubview(wordsCount)
        view.addSubview(opinionTextView)
        view.addSubview(imgTitle)
        view.addSubview(imgCount)
        view.addSubview(collection)
        view.addSubview(submitBtn)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        opinionTitle.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(App.naviStatusHeight+15)
            make.width.equalTo(65)
            make.height.equalTo(17)
        }
        
        wordsCount.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(opinionTitle)
            make.width.lessThanOrEqualTo(70)
            make.height.equalTo(17)
        }
        
        opinionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(opinionTitle.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(200)
        }
        
        imgTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(opinionTitle)
            make.top.equalTo(opinionTextView.snp.bottom).offset(15)
            make.width.equalTo(157)
            make.height.equalTo(17)
        }
        
        imgCount.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(imgTitle)
            make.width.equalTo(22)
            make.height.equalTo(17)
        }
        
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(imgTitle.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(105)
        }
        
        submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(collection.snp.bottom).offset(30)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(44)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = FeedbackVM.itemSize
        collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
        
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = false
        collection.allowsSelection = true
        collection.contentInset = UIEdgeInsets.init(top: 16, left: 10, bottom: 15, right: 10)
        collection.register(FeedbackImgCell.self, forCellWithReuseIdentifier: "FeedbackImgCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.dismissButon.addGestureRecognizer(dismissTap)
        opinionTextView.delegate = self
        
        KeyboardManager.shared.didAppear = {
            let hideTap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
            self.view.addGestureRecognizer(hideTap)
        }
        KeyboardManager.shared.didDisappear = {
            self.view.removeGestureRecognizers()
        }
        
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func bindViewModel() {
        opinionTextView.rx.text.orEmpty.subscribe(onNext: {[weak self] (str) in
            self?.wordsCount.text = "\(str.count)/200"
        }).disposed(by: disposeBag)
        
        viewModel.imgCellVMsObservable.subscribe(onNext: {[weak self] (vms) in
            self?.collection.reloadData()
            self?.imgCount.text = "\(vms.count)/4"
        }).disposed(by: disposeBag)
        
        submitBtn.rx.tap.subscribe(onNext: {[weak self] (_) in
            
            if self?.opinionTextView.text.count == 0 {
                let alert = SlightAlert(title: "输入不能为空")
                alert.show()
                return
            }
            
            guard let vms = try? self?.viewModel.imgCellVMsObservable.value() else {return}
            var imageInfoModels: [ImageInfoModel] = []
            let group = DispatchGroup()
            let dispatchQueue = DispatchQueue(label: "uploadImg")
            var indicatorView: ActivityIndicatorView?
            
            if vms.count != 0 {
                indicatorView = ActivityIndicatorView.show(title: "正在上传图片", style: .fullScreen)
            }
            for index in 0 ..< vms.count {
                group.enter()
                dispatchQueue.async {
//                    CommonAPI.uploadImage(image: vms[index].model.image!, path: "comment") { (res, error) in
//                        if let error = error {
//                            indicatorView?.dismiss()
//                            let alert = SlightAlert(title: "网络崩溃了，提交失败")
//                            alert.show()
//                            ErrorAlertView.show(error: error, style: .center)
//                            return
//                        }
//                        guard let res = res else {return}
//                        imageInfoModels.append(res)
//                        group.leave()
//                    }
                }
            }
            
            group.notify(queue: .main) {
                self?.viewModel.sendSuggest(description: (self?.opinionTextView.text)!, images: imageInfoModels, { (error) in
                    if let error = error {
                        indicatorView?.dismiss()
                        let alert = SlightAlert(title: "网络崩溃了，提交失败")
                        alert.show()
                        ErrorAlertView.show(error: error, style: .topError)
                        return
                    }
                    indicatorView?.dismiss()
                    let alert = SlightAlert(title: "提交成功")
                    alert.show()
                    self?.dismissView()
                })
            }
        }).disposed(by: disposeBag)
    }
    
}

extension FeedbackVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let limit = 200
        guard let text = textView.text else{
            return true
        }
        
        if text.count > limit{
            textView.text = String(text[..<text.index(text.startIndex, offsetBy: 200)])
        }

        return true
    }
}

extension FeedbackVC: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FeedbackImgCell
        if cell.isEmpty {
            var imgs: [ImageModel] = []
            let vms = try? viewModel.imgCellVMsObservable.value()
            for vm in vms! {
                imgs.append(vm.model)
            }
            let vc = ImagePickerVC.init(limitPhotos: 4, selectedImgs: imgs)
            App.navigationController?.show(vc, sender: true)
            vc.completion = {[weak self] imageModels in
                guard let imageModels = imageModels else {return}
                var vms: [FeedbackImgCellVM] = []
                for imageModel in  imageModels {
                    let vm = FeedbackImgCellVM.init(model: imageModel)
                    vms.append(vm)
                }
                cell.isEmpty = false
                self?.viewModel.imgCellVMsObservable.onNext(vms)
            }
        }
    }
}

extension FeedbackVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = try? viewModel.imgCellVMsObservable.value().count else {return 0}
        if count == 4 {
            return count
        } else {
            return count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedbackImgCell", for: indexPath) as! FeedbackImgCell
        guard let vms = try? viewModel.imgCellVMsObservable.value() else {return cell}
        if vms.count != indexPath.item {
            cell.bindViewModel(viewModel: vms[indexPath.item])
        } else if vms.count == 4 {
            cell.bindViewModel(viewModel: vms[indexPath.item])
        } else {
            cell.setEmptyImg(img: UIImage(named: "empty_img_big")!)
        }
        
        return cell
    }
    
    
}
