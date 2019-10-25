//
//  twoPictureButton.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 7..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

@IBDesignable
class twoPictureButton: UIButton {
    
    
    @IBInspectable var leftHandImage: UIImage? {
        didSet {
            leftHandImage = leftHandImage?.withRenderingMode(.alwaysTemplate)
            setupImages()
        }
    }
    @IBInspectable var rightHandImage: UIImage? {
        didSet {
            rightHandImage = rightHandImage?.withRenderingMode(.alwaysTemplate)
            setupImages()
        }
    }
   
  

    func setupImages() {
        if let leftImage = leftHandImage {
            let leftImageView = UIImageView(image:leftImage)
            
            let height = self.frame.height - 8
            let width = height
            
            let xPos = 4
            let yPos = 4
            
            leftImageView.frame = CGRect(x: CGFloat(xPos), y: CGFloat(yPos), width: width, height: height)
//            self.setImage(leftImage, for: .normal)
            self.addSubview(leftImageView)
//            self.imageView?.contentMode = .scaleAspectFit
            
        }
        
        if let rightImage = rightHandImage {
            let rightImageView = UIImageView(image: rightImage)
            rightImageView.tintColor = UIColor.black
            
            let height = self.frame.height / 3
            let width = height
            let xPos = self.frame.width - width - 8
            let yPos = (self.frame.height - height) / 2
            
            rightImageView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
            self.addSubview(rightImageView)
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

