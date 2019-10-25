//
//  File.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 12..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation
import UIKit

struct Common:Codable{
    
    let fromTime:String
    let toTime:String
    var commonImageURL:String?
    var commonMainImageURL:String?
    let title:String
    let message:String
}
