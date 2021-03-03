//
//  ClickableTextView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/2/28.
//

import UIKit

class ClickableTextView: UITextView {
    
    var didClick: ((URL) -> Void)?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.contentInset = .zero
        self.textContainerInset = .zero
        self.textContainer.lineFragmentPadding = 0
        self.delegate = self
        self.isEditable = false
        self.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ClickableTextView:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        didClick?(URL)
        return false
    }
}
