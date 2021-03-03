//
//  InputBackgroundView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/2/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class InputBackgroundView: UIView {
    
    var didTextChanged: ((String) -> Void)?
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
//        textField.clearButtonMode = .whileEditing
        textField.resignFirstResponder()
//        textField.keyboardType = .phonePad
        textField.font = UIFont.pf_medium(14)
        textField.textColor = UIColor(hexString: "#333333")
        return textField
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#F7F7F7")
        view.cornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundView)
        backgroundView.addSubview(textField)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        textField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(16)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func setUp(placeholder: String, isSecureTextEntry: Bool, keyboardType: UIKeyboardType) {
        textField.isSecureTextEntry = isSecureTextEntry
        let str = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor:UIColor(hexString: "#C0C0C0")!,NSAttributedString.Key.font:UIFont.pf_medium(14)])
        textField.attributedPlaceholder = str
        textField.keyboardType = keyboardType
    }
}

extension InputBackgroundView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        didTextChanged?(textField.text ?? "")
        return false
    }
}
