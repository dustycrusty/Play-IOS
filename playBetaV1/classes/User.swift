//
//  User.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 16..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation

struct UserStruct:Codable{
    var username: String
    var uid: String
    var history: History?
    var phoneNumber:String
    
}

