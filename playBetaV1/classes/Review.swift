//
//  Review.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 16..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation

struct Review: Codable{
    
    let username: String
    let uid: String
    let message: String
    let rating: Double
    let time: String
    var response: Response?
    var reviewId: String?

}
