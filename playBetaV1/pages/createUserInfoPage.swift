//
//  createUserInfoPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 6..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase
class createUserInfoPage: UIViewController {

    @IBOutlet weak var emailIdField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var checkPasswordField: UITextField!
    @IBOutlet weak var userIdField: UITextField!
    
    @IBOutlet weak var duplicateTestResult: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailIdField.setBottomBorder()
        passwordField.setBottomBorder()
        checkPasswordField.setBottomBorder()
        userIdField.setBottomBorder()
        self.hideKeyboardWhenTappedAround()
        
        
        // Do any additional setup after loading the view.
    }

   
    @IBAction func checkForDuplicateTapped(_ sender: Any) {
        print("tapped")
        self.duplicateTestResult.text = "확인중..."
        firebaseCheckRefForId { (exists) in
            if exists == true{
                
                self.duplicateTestResult.text = "중복하는 아이디가 없습니다."
                self.duplicateTestResult.textColor = UIColor.blue
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
            print("hello")
            if snapshot.exists(){
                print("is Nil")
                completionHandler(false)
        }
            else{
                 print("is NOT Nil")
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
    func createUserFunc(){
    let sv = UIViewController.displaySpinner(onView: self.view)
        Auth.auth().createUser(withEmail: emailIdField.text!, password: passwordField.text!) { (user, error) in
            if let error = error{
                errorPopup(vc: self, error: error, errorName: "회원가입 정보 확인")
                UIViewController.removeSpinner(spinner: sv)
            }
            else{
                let defaults = UserDefaults.standard
                defaults.set(self.emailIdField.text!, forKey: "id")
                defaults.set(self.passwordField.text!, forKey: "password")
                let changeRequest = user?.createProfileChangeRequest()
                
                changeRequest?.displayName = self.userIdField.text!
                changeRequest?.commitChanges { error in
                    if let error = error {
                        errorPopup(vc: self, error: error, errorName: "회원생성 에러")
                        UIViewController.removeSpinner(spinner: sv)

                        return
                    } else {
                        UIViewController.removeSpinner(spinner: sv)
                        createUserDataRef(uid: (user?.uid)!, username: self.userIdField.text!)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "submitPage")
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
        
                
            }
        }
    }
    
    
    func checkPwFields(pw1:String, pw2:String) -> Bool{
        if pw1 == pw2{
            return true
        }
        else{
            return false
        }
    }

    var usernameChecked:Bool = false
    
    func fullCheck(){
        
        let pwValid = "비밀번호를 다시 확인해주세요."
        let unCheck = "중복체크를 눌러주세요."
        
        if self.usernameChecked == false{
            let alert = UIAlertController(title: "정보 확인", message: unCheck, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if checkPwFields(pw1: passwordField.text!, pw2: checkPasswordField.text!) == false{
            let alert = UIAlertController(title: "정보 확인", message: pwValid, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            createUserFunc()
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

