//
//  UIControlExtension.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/5/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

class ClosureSleeve {
    let closure: () -> ()
    var fireAt:TimeInterval = .zero
    init(attachTo: AnyObject, closure: @escaping () -> ()) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc func invoke(){
        
        let current = Date().timeIntervalSince1970
        if current > (fireAt + 1){
            self.closure()
            self.fireAt = current
        }
    }
}
extension UIControl{
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, action: @escaping () -> ()) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
    
    func removeAction(){
        self.removeTarget(nil, action: nil, for: .allEvents)
    }
}
