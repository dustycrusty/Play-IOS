//
//  loginContainerView.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 27..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase

class loginContainerView: UIViewController {

    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pw: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
       
        
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func loginTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: id.text!, password: pw.text!) { (user, error) in
            if let error = error{
                errorPopup(vc: self, error: error, errorName: "로그인 에러")
            }
            let defaults = UserDefaults.standard
            defaults.set(self.id.text!, forKey: "id")
            defaults.set(self.pw.text!, forKey: "password")
            navigateToMainPage(pvc: self)
            
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            let pvc = self.parent as? loginPage
            pvc?.container.alpha = 0
        }
    }
    @IBAction func resetpwTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sendResetPasswordPage")
        self.parent?.navigationController?.pushViewController(vc, animated: true)
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
