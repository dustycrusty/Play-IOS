//
//  reviewCellOriginal.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 18..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import AvatarImageView
import Dropper
import Firebase

class reviewCellOriginal: UITableViewCell, DropperDelegate {

    @IBOutlet weak var dropperButton: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var uploadedTime: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var profilePic: AvatarImageView!
    
    let dropper = Dropper(width: 75, height: 200)

    @IBAction func dropDownAction(_ sender: Any) {
        print("dropdownAction")
        if dropper.status == Dropper.Status.hidden {
            print("triggered")
            
            
            checkUserId(id: self.username.text!) { (equal) in
                if equal == true{
                    self.dropper.items = ["삭제"]
                    self.dropper.theme = Dropper.Themes.white
                    self.dropper.cornerRadius = 3
                    self.dropper.showWithAnimation(0.15, options: Dropper.Alignment.center, button: self.dropperButton)
                    
                }
                else{
                    self.dropper.items = ["신고하기"]
                    self.dropper.theme = Dropper.Themes.white
                    self.dropper.cornerRadius = 3
                    self.dropper.showWithAnimation(0.15, options: Dropper.Alignment.center, button: self.dropperButton)
                    
                }
            }
        } else {
            print("triggered")
            dropper.hideWithAnimation(0.1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.rating.isUserInteractionEnabled = false
        self.rating.backgroundColor = UIColor.clear
        
        
        dropper.delegate = self
        
       
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reportedMessage(){
        let alert = UIAlertController(title: "신고 접수", message: "신고가 접수되었습니다!", preferredStyle: .alert)
        if let myViewController = parentViewController as? storeDetailPage_unpaid {
            myViewController.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
        else if let myViewController = parentViewController as? storeDetailPage{
            myViewController.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
        else if let myViewController = parentViewController as? allReviewsPage{
            myViewController.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
    }
    
    func deletedMessage(){
        let alert = UIAlertController(title: "리뷰 삭제", message: "리뷰가 삭제되었습니다!", preferredStyle: .alert)
        if let myViewController = parentViewController as? storeDetailPage_unpaid {
            myViewController.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
        else if let myViewController = parentViewController as? storeDetailPage{
            myViewController.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
        else if let myViewController = parentViewController as? allReviewsPage{
            myViewController.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
    }
    
    func submitReport(){
        if let myVC = parentViewController as? storeDetailPage_unpaid{
            print("in1")
            let ref = Database.database().reference().child("reviewReport").child((myVC.store?.type)!).child((myVC.store?.storeid)!)
            
            let reportAddition = ["message":self.message.text, "id":self.username.text, "uploadedTime": self.uploadedTime.text, "rating":self.rating.text] as [String : Any]
            
            ref.updateChildValues([self.uploadedTime.text!:reportAddition])
            reportedMessage()
        }
        else if let myVC = parentViewController as? storeDetailPage{
            print("in2")

            let ref = Database.database().reference().child("reviewReport").child((myVC.store?.type)!).child((myVC.store?.storeid)!)
            
            let reportAddition = ["message":self.message.text!, "id":self.username.text!, "uploadedTime":self.uploadedTime.text!, "rating":self.rating.text!] as [String : Any]
            
            ref.updateChildValues([self.uploadedTime.text!:reportAddition])
            reportedMessage()
        }
        
        else if let myVC = parentViewController as? allReviewsPage{
            print("in2")
            
            let ref = Database.database().reference().child("reviewReport").child((myVC.store?.type)!).child((myVC.store?.storeid)!)
            
            let reportAddition = ["message":self.message.text!, "id":self.username.text!, "uploadedTime":self.uploadedTime.text!, "rating":self.rating.text!] as [String : Any]
            
            ref.updateChildValues([self.uploadedTime.text!:reportAddition])
            reportedMessage()
        }
    }
    
    @objc(DropperSelectedRow:contents:) func DropperSelectedRow(_ path: IndexPath, contents: String) {
        checkUserId(id: self.username.text!) { (equal) in
            if equal == true{
                self.deleteReview(row: path.row)
            }
            else{
                self.submitReport()
            }
        }
    }
    
    
    func deleteReview(row:Int){
        if let myVC = parentViewController as? storeDetailPage_unpaid{
            let rId = myVC.review[row].reviewId
            print("in1")
            let ref = Database.database().reference().child("store").child((myVC.store?.type)!).child((myVC.store?.storeid)!).child("review").child(rId!)
            deletedMessage()
            ref.removeValue()
            
        }
        else if let myVC = parentViewController as? storeDetailPage{
            let rId = myVC.review[row].reviewId
            print("in2")
            let ref = Database.database().reference().child("store").child((myVC.store?.type)!).child((myVC.store?.storeid)!).child("review").child(rId!)
            print(rId!)
            deletedMessage()
            ref.removeValue()
            
           
        }
        else if let myVC = parentViewController as? allReviewsPage{
            let rId = myVC.review[row].reviewId
            print("in3")
            let ref = Database.database().reference().child("store").child((myVC.store?.type)!).child((myVC.store?.storeid)!).child("review").child(rId!)
            print(rId!)
            deletedMessage()
            ref.removeValue()
        }
    }
    
    func checkUserId(id:String,  completionHandler:@escaping ((Bool) -> Void)){
   let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("user").child(uid!).child("username").observeSingleEvent(of: .value) { (snapshot) in
        let idfield = snapshot.value as! String
        if idfield == id{
            completionHandler(true)
        }
        else{
            completionHandler(false)
        }
    }
    
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}


