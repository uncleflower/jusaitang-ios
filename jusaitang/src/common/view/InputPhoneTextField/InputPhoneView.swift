//
//  InputPhoneView.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/3.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import SnapKit

class InputPhoneView: UIView {
    
    let phoneLimit = 11
    
    var didTextChanged: ((String) -> Void)?
    
    let areaCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "+86"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = UIColor.default
        return label
    }()
    
    let arrowView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "login_arrow"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.resignFirstResponder()
        textField.keyboardType = .phonePad
        textField.font = UIFont.pf_medium(18)
        let str = NSAttributedString(string: "请输入手机号码", attributes: [NSAttributedString.Key.foregroundColor:UIColor(hexString: "#C0C0C0")!,NSAttributedString.Key.font:UIFont.pf_medium(14)])
        textField.attributedPlaceholder = str
        textField.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(areaCodeLabel)
        addSubview(arrowView)
        addSubview(phoneNumberTextField)
        makeConstraints()
        
        phoneNumberTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        areaCodeLabel.snp.makeConstraints { (label) in
            label.centerY.equalToSuperview()
            label.leading.equalToSuperview()
            label.width.equalTo(24)
            label.height.equalTo(50)
        }
        
        arrowView.snp.makeConstraints { (imageView) in
            imageView.centerY.equalTo(areaCodeLabel)
            imageView.leading.equalTo(areaCodeLabel.snp.trailing).offset(8)
            imageView.height.equalTo(50)
            imageView.width.equalTo(5)
        }
        
        phoneNumberTextField.snp.makeConstraints { (textField) in
            textField.centerY.equalTo(areaCodeLabel)
            textField.leading.equalTo(arrowView.snp.trailing).offset(12)
            textField.trailing.equalToSuperview()
            textField.height.equalTo(50)
        }
    }
    
    func load(){
    }
}



extension InputPhoneView:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.compactMap({ Int(String($0)) }).count == string.count else { return false }
        let text = textField.text ?? ""
        if string.count == 0 {
            textField.text = String(text.dropLast()).phoneChunkFormatted()
        }
        else {
            let newText = String((text + string)
                .filter({ $0 != " " }).prefix(phoneLimit))
            textField.text = newText.phoneChunkFormatted()
        }
        
        didTextChanged?(textField.text ?? "")
        return false
        
    } 
}
