//
//  avatarImageDatasource.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 7..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation
import AvatarImageView
import Firebase
import Kingfisher

struct avatarImageDatasource: AvatarImageViewDataSource {
    var name: String
    var avatar: UIImage?
    
    init() {
        name = avatarImageDatasource.randomName()
    }
    
    
    static func randomName() -> String {
//        let charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
//        let charSetArray = charSet.characters.map { String($0) }
//
//        var string = ""
//
//        for _ in 0..<5 {
//            string += charSetArray[Int(arc4random()) % charSetArray.count]
//        }
//
//        string += " "
//
//        for _ in 0..<5 {
//            string += charSetArray[Int(arc4random()) % charSetArray.count]
//        }
//
//        return string
        
        return "^ ^"
    }
}
