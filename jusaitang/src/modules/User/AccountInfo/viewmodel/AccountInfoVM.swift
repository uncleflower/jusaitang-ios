//
//  AccountInfoVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxCocoa
import RxSwift

class AccountInfoVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var userInfo: BehaviorSubject<User?> = BehaviorSubject(value: DataManager.readUser())
    
    var accountInfoCellVMs: [AccountInfoCellVM] = [
        AccountInfoCellVM(title: "头像"),
        AccountInfoCellVM(title: "姓名"),
        AccountInfoCellVM(title: "学号"),
        AccountInfoCellVM(title: "账号密码"),
        AccountInfoCellVM(title: "手机号码"),
        AccountInfoCellVM(title: "邮箱")
    ]
    
    override init() {
        super.init()
        bindViewModel()
    }
    
    func bindViewModel() {
        userInfo.asObserver().subscribe(onNext: { [weak self] (user) in
            guard let userInfo = user else {return}
            self?.accountInfoCellVMs[0].infoObservable.onNext(userInfo.avatar)
            self?.accountInfoCellVMs[1].infoObservable.onNext(userInfo.name)
            self?.accountInfoCellVMs[2].infoObservable.onNext(userInfo.studentNumber)
            self?.accountInfoCellVMs[3].infoObservable.onNext("修改密码")
            
            if userInfo.phone != "" {
                self?.accountInfoCellVMs[4].infoObservable.onNext(userInfo.phone)
            } else {
                self?.accountInfoCellVMs[4].infoObservable.onNext("设置号码")
            }
            
            if userInfo.email != "" {
                self?.accountInfoCellVMs[5].infoObservable.onNext(userInfo.email)
            } else {
                self?.accountInfoCellVMs[5].infoObservable.onNext("设置邮箱")
            }
            
        }).disposed(by: disposeBag)
    }
}

class AccountInfoCellVM: NSObject {
    
    var title: String = ""
    
    var infoObservable: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    init(title: String) {
        self.title = title
        super.init()
    }
}
