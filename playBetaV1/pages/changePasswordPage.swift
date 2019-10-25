//
//  changePasswordPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 27..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase

class changePasswordPage: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var checkPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        self.hideKeyboardWhenTappedAround()
        passwordField.setBottomBorder()
        checkPasswordField.setBottomBorder()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        fullCheck()
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func updatePw(){
        let defaults = UserDefaults.standard
        if isKeyPresentInUserDefaults(key: "id") && isKeyPresentInUserDefaults(key: "password"){
             let credential = EmailAuthProvider.credential(withEmail: defaults.string(forKey: "id")!, password: defaults.string(forKey: "password")!)
            Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (error) in
                if (error != nil){
                    errorPopup(vc: self, error: error!, errorName: "비밀번호 변경 오류")
                }
                else{
                    self.changePw()
                }
            })
        }
        else{
            let alert = UIAlertController(title: "비밀번호 변경 불가능", message: "저희 서비스 고유 유저만 비밀번호를 바꿀 수 있습니다.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            self.navigationController?.popViewController(animated: true)
            }
            ))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func changePw(){
        Auth.auth().currentUser?.updatePassword(to: self.passwordField.text!, completion: { (error) in
            if let error = error{
                errorPopup(vc: self, error: error, errorName: "비밀번호 변경 오류")
            }
            else{
                let alert = UIAlertController(title: "비밀번호 변경 성공!", message: "비밀번호를 변경했습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        })
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
        
        if checkPwFields(pw1: passwordField.text!, pw2: checkPasswordField.text!) == false{
            let alert = UIAlertController(title: "정보 확인", message: pwValid, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            updatePw()
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
