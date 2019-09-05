//
//  UIButtonExtension.swift
//  Calculatorr
//
//  Created by hasanberk yigit on 17.08.2019.
//  Copyright © 2019 hasanberk yigit. All rights reserved.
//

import UIKit

private let orange = UIColor(red: 254/255, green: 148/255, blue: 0/255, alpha: 1)

extension UIButton {
    
  
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    

    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
    
    func selectOperation(_ selected: Bool) {
        backgroundColor = selected ? .white : orange
        setTitleColor(selected ? orange : .white, for: .normal)
    }
    
}
