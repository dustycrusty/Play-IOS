//
//  mainPageButton.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 21..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

@IBDesignable

class mainPageButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: String? {
        didSet {
            layer.borderColor = hexStringToUIColor(hex: borderColor!).cgColor
        }
    }
    
    @IBInspectable var fillColor: UIColor? {
        didSet {
            layer.backgroundColor = fillColor?.cgColor
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
