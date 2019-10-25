//
//  reviewCellType.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 4..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class customerReviewObj{
    var author:String?
    var message: String?
    var time: String?
    var reply: Bool?
    var uid: String?
    
    init(uid:String, author:String, message: String, time: String,  reply: Bool){
        self.author = author
        self.message = message
        self.time = time
        self.reply = reply
        self.uid = uid
    }
    
}

class ReplyObj{
    let author = "사장님 답변"
    var time:String?
    var message:String?
    
    init(time: String, message: String){
        self.time = time
        self.message = message
    }
}

class reviewCellArray{
    
    var cellArray:[Any]!
    
    func previewReviews(storeID: String, completionHandler: @escaping (([Any]) -> Void)){
        var cellArray:[Any] = []
        let query = Database.database().reference().child("store/pccafe/\(storeID)/review").queryLimited(toFirst: 3)
        query.observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else { return }
            let dg = DispatchGroup()
            do {
                dg.enter()
                for x in (value as? [Any])!{
                let model = try FirebaseDecoder().decode(Review.self, from: x)
                    
                    if model.response != nil{
                        cellArray.append(self.extractCustomerReview(review: model))
                        cellArray.append(self.extractReply(review: model))
                        dg.leave()
                    }
                    else{
                        cellArray.append(self.extractCustomerReview(review: model))
                        dg.leave()
                    }
                }
            } catch let error {
                print(error)
            }
            dg.notify(queue: .main, execute: {
                completionHandler(cellArray)
            })
        }
        
    }
    
    
    func extractReply(review:Review) -> ReplyObj{
        return ReplyObj(time: (review.response?.time)!, message: (review.response?.message)!)
    }
    
    func extractCustomerReview(review:Review) -> customerReviewObj{
        var responseExists:Bool = false
        if review.response != nil {
            responseExists = true
        }
        return customerReviewObj(uid: review.uid, author: review.username, message: review.message, time: review.time, reply: responseExists)
    }
    
    init(storeID: String, previewReview:Bool){
        if previewReview == true{
            previewReviews(storeID: storeID) { (cellArray) in
                self.cellArray = cellArray
            }
        }
    }
}
