//
//  changePhoneNumberPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 27..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase

class changePhoneNumberPage: UIViewController {
    
        @IBOutlet weak var phoneNumber: UITextField!
        @IBOutlet weak var authCode: UITextField!
        
        @IBOutlet weak var remainingTime: UILabel!
        
        var seconds = 180
        
        var timer = Timer()
        
        var isTimerRunning = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.navigationBar.tintColor = UIColor.white

            self.hideKeyboardWhenTappedAround()
            Auth.auth().languageCode = "ko"
            phoneNumber.setBottomBorder()
            authCode.setBottomBorder()
            // Do any additional setup after loading the view.
        }
    
   
        
        @IBAction func checkButtonTapped(_ sender: Any) {
            checkForLoginValidity(code: authCode.text!) { (validity) in
                if validity == true{
                    let alert = UIAlertController(title: "확인", message: "성공!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                        self.navigationController?.popViewController(animated: true)
                        print("PHONE NUMBER ", Auth.auth().currentUser?.phoneNumber)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    self.resetTimer()
                }
                else{
                    
                    self.resetTimer()
                }
            }
            
        }
        @IBAction func sendButtonTapped(_ sender: UIButton) {
            if isTimerRunning == false {
                phoneNumber.textColor = UIColor.darkGray
                phoneNumber.isUserInteractionEnabled = false
                runTimer()
                phoneNumberAuthentication(phoneNumber: phoneNumber.text!)
            }
        }
        
        
        func checkForLoginValidity(code:String, completionHandler: @escaping ((Bool) -> Void)){
            let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID!,
                verificationCode: code)
            
            Auth.auth().currentUser?.updatePhoneNumber(credential, completion: { (error) in
                if let error = error {
                    print(error)
                    let alert = UIAlertController(title: "인증 실패", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.resetTimer()
                    completionHandler(false)
                }
                else{
                    completionHandler(true)
                }
            })
            
            
        }
        
        
        func resetTimer(){
            self.phoneNumber.textColor = UIColor.black
            self.phoneNumber.isUserInteractionEnabled = true
            self.isTimerRunning = false
            timer.invalidate()
            seconds = 180
            remainingTime.text = ""
        }
        func phoneNumberAuthentication(phoneNumber:String){
            var pn = phoneNumber
            let index = pn.index(pn.startIndex, offsetBy: 0)
            if pn[index] == "0"{
                pn.remove(at: index)
            }
            pn = "+82\(pn)"
            PhoneAuthProvider.provider().verifyPhoneNumber(pn, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    let alert = UIAlertController(title: "인증 실패", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                if UserDefaults.standard.string(forKey: "authVerificationID") != verificationID {
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                }
                
            }
        }
        
        func runTimer() {
            isTimerRunning = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        }
        
        @objc func updateTimer() {
            if seconds < 1 {
                phoneNumber.textColor = UIColor.black
                phoneNumber.isUserInteractionEnabled = true
                isTimerRunning = false
                timer.invalidate()
                seconds = 180
                remainingTime.text = ""
                
                let alert = UIAlertController(title: "시간 초과", message: "시간을 초과했습니다. 다시 시도해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            seconds -= 1     //This will decrement(count down)the seconds.
            remainingTime.text = timeString(time: TimeInterval(seconds))
        }
        
        func timeString(time:TimeInterval) -> String {
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return "\(minutes):\(seconds)"
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
