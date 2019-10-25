//
//  submittedError.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 26..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation

struct submittedError:Codable{
    let errorMessage:String
    let title:String
    let type:String
    let uid:String
    let username:String
    let email:String
    
}
