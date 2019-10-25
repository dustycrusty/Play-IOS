//
//  uploadReviewPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 4..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class uploadReviewPage: UIViewController {

    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewText: UITextView!
    
//    var storeid:String?
    let uid = Auth.auth().currentUser?.uid
    var store:Store?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        reviewText.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    func getDateString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let currentDateTime = Date()
        return formatter.string(from: currentDateTime)
//        let someDateTime = formatter.date(from: "2016/10/08 22:31")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uploadReview(_ sender: Any) {
        if (reviewText.text == ""){
            let alert = UIAlertController(title: "리뷰 내용이 없습니다!", message: "리뷰를 올리려면 내용이 필요합니다.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
           
        else{
            let rating = ratingView.rating
            let message = reviewText.text
            let time = getDateString()
          
            
            let reviewUploadRef = Database.database().reference().child("store/\(String(describing: (store?.type)!))").child((store?.storeid)!).child("review").childByAutoId()
            
            let key = reviewUploadRef.key
            
            
            let model = Review(username: (Auth.auth().currentUser?.displayName)!, uid: (Auth.auth().currentUser?.uid)!, message: message!, rating: rating, time: time, response: nil, reviewId: key)
           
            let data = try! FirebaseEncoder().encode(model)
            
            let updates = [
                "store/\(String(describing: (store?.type)!))/\((store?.storeid)!)/review/\(key)":data,
                "user/\(String(describing: (uid)!))/history/\(String(describing: (store?.type)!))/\((store?.storeid)!)/\(key)":data
            ]
            Database.database().reference().updateChildValues(updates) { (error, ref) in
                if (error != nil){
                    let alert = UIAlertController(title: "에러 발생", message: "업로드 중 에러가 발생했습니다. 다시 시도해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let alert = UIAlertController(title: "업로드 성공 ><", message: "업로드에 성공했습니다!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{(action) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
}
