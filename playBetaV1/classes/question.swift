//
//  question.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 25..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation

struct Question:Codable{
    let questionTitle:String
    let questionMessage:String
    let type:String
    let answer:String?
    let uid:String
    let username:String
    let email:String
}
