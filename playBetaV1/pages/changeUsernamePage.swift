//
//  changeUsernamePage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 27..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase

class changeUsernamePage: UIViewController {

    @IBOutlet weak var userIdField: UITextField!
    @IBOutlet weak var duplicateTestResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        self.hideKeyboardWhenTappedAround()
        userIdField.setBottomBorder()
        
        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func checkForDuplicateTapped(_ sender: Any) {
        firebaseCheckRefForId { (exists) in
            if exists == true{
                self.duplicateTestResult.text = "중복하는 아이디가 없습니다."
                self.duplicateTestResult.textColor = UIColor.green
                self.usernameChecked = true
            }
            else{
                self.duplicateTestResult.text = "중복하는 아이디가 있습니다."
                self.duplicateTestResult.textColor = UIColor.red
                self.usernameChecked = false
            }
        }
        
    }
    
    func firebaseCheckRefForId(completionHandler: @escaping ((Bool)  -> Void)){
        Database.database().reference().child("id").child(userIdField.text!).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.value == nil{
                completionHandler(false)
            }
            else{
                completionHandler(true)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        fullCheck()
    }
    func updateId(){
        let user = Auth.auth().currentUser
        let changeRequest = user?.createProfileChangeRequest()
        
        changeRequest?.displayName = self.userIdField.text!
        changeRequest?.commitChanges { error in
            if let error = error {
                errorPopup(vc: self, error: error, errorName: "회원생성 에러")
                return
            } else {
                createUserDataRef(uid: (user?.uid)!, username: self.userIdField.text!)
                
                let alert = UIAlertController(title: "닉네임 변경 성공!", message: "닉네임을 변경했습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
   
    
    var usernameChecked:Bool = false
    
    func fullCheck(){
        
        let unCheck = "중복체크를 눌러주세요."
        
        if self.usernameChecked == false{
            let alert = UIAlertController(title: "정보 확인", message: unCheck, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            updateId()
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
