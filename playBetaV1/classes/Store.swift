//
//  File.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 16..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation
import GeoFire
import Firebase

struct Store:Codable{
    var about: String?
    var score: Double
    let address: String
    var condition: [String]?
    let lat: Double
    let lng: Double
    let name: String
    var priceInfo: [String]?
    let reviewCount: Int
    var spec: [String]?
    let type: String
//    let review: [String:Review]?
    let paid: String
    let extraInfo: String?
    var distance: Double?
    var storeid: String
    var image: [String:Bool]?
    var event: [String:Bool]?
    var phoneNumber: String?
    
    mutating func setDistance(userloc:CLLocation, loc: CLLocation){
        self.distance = userloc.distance(from: loc)
    }
    
    nonmutating func getImageData(imageuid: [String:Bool], completionHandler:@escaping (([UIImage])-> Void)){
        
       let dg = DispatchGroup()
       let uidArray = Array(imageuid.keys)
        var returnArray:[UIImage] = []
        for uid in uidArray{
           dg.enter()
            Storage.storage().reference().child("store").child(self.type).child(self.storeid).child("\(uid).jpeg").getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("errored in getting imageData", error)
                    dg.leave()
                } else {
                    // Data for "images/island.jpg" is returned
                    let image = UIImage(data: data!)
                    returnArray.append(image!)
                    dg.leave()
                }
            }
        }
        dg.notify(queue: .main) {
            completionHandler(returnArray)
        }
    }
    
}
