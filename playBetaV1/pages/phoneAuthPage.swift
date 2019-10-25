//
//  phoneAuthPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 6..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import FirebaseAuth

class phoneAuthPage: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var authCode: UITextField!
    
    @IBOutlet weak var remainingTime: UILabel!
    
    var seconds = 180
    
    var timer = Timer()
    
    var isTimerRunning = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.phoneNumber.isFirstResponder || self.authCode.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
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
            if UserDefaults.standard.string(forKey: "authVerificationID") == nil{
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
extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    open override func draw(_ rect: CGRect) {
        if self.superclass != UITextField.self{
            print(self.superclass as Any)
            setBottomBorder()
        }
    }
}

public func errorPopup(vc:UIViewController, error: Error, errorName:String){
    let alert = UIAlertController(title: "인증 실패", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}

extension UITableView{
    
    open override func draw(_ rect: CGRect) {
        self.tableFooterView = UIView()
        }
    }


