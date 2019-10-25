//
//  notice.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 12..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation

struct Notice:Codable{
    let time:String
    let noticeType:String
    let noticeTitle:String
    let noticeMessage:String
}
