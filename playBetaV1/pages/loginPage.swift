//
//  loginPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 17..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage
import GoogleSignIn
import FBSDKLoginKit

public func navigateToMainPage(pvc:UIViewController){
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "mainTab")
    pvc.present(vc, animated: true, completion: nil)
}

class loginPage: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    var sv:UIView? = nil
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            errorPopup(vc: self, error: error, errorName: "페이스북 로그인 에러")
                return
        }
        
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error{
                errorPopup(vc: self, error: error, errorName: "페이스북 로그인 에러")
                return
            }
            
            self.userObjectCheckforFacebook(uid: (Auth.auth().currentUser?.uid)!)
            
        }
      
        
    }
    @IBOutlet weak var container: UIView!
    @IBAction func emailLoginTapped(_ sender: Any) {
    UIView.animate(withDuration: 0.5) {
        self.container.alpha = 1
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        return
    }
    
    

    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var googleSignInBut: GIDSignInButton!
    fileprivate func checkForLoginStatus() {
//        if Auth.auth().currentUser == nil {
//            print("no user")
//            if KOSession.shared().isOpen() {
//                requestFirebaseJwt(accessToken: KOSession.shared().accessToken)
//            }
//
//        } else if Auth.auth().currentUser != nil{
//            print("with user")
//                self.performSegue(withIdentifier: "loginSegue", sender: self)
//            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        facebookLoginButton.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // Obtain all constraints for the button:
        let layoutConstraintsArr = facebookLoginButton.constraints
        // Iterate over array and test constraints until we find the correct one:
        for lc in layoutConstraintsArr { // or attribute is NSLayoutAttributeHeight etc.
            if ( lc.constant == 28 ){
                // Then disable it...
                lc.isActive = false
                break
            }
        }
        
        if Auth.auth().currentUser != nil{
GIDSignIn.sharedInstance().signOut()
        }
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        checkForLoginStatus()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        KOSession.shared().close()
        KOSession.shared().open(completionHandler: { (error) in
            self.sv = UIViewController.displaySpinner(onView: self.view)
            print("in1")
            if KOSession.shared().isOpen() {
                print("in")
                self.requestFirebaseJwt(accessToken: KOSession.shared().accessToken)
            } else {
                print("login failed: \(error!)")
            }
        }, authTypes: [1, 3])
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
    func requestFirebaseJwt(accessToken: String) {
        let url = URL(string: String(format: "%@/verifyToken", Bundle.main.object(forInfoDictionaryKey: "VALIDATION_SERVER_URL") as! String))!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let token = KOSession.shared().accessToken!
        let parameters: [String: String] = ["token": token]
        
        do {
            let jsonParams = try JSONSerialization.data(withJSONObject: parameters, options: [])
            urlRequest.httpBody = jsonParams
            
        } catch {
            print("Error in adding token as a parameter: \(error)")
            UIViewController.removeSpinner(spinner: sv!)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                UIViewController.removeSpinner(spinner: self.sv!)
                print("Error in request token verifying: \(error!)")
                return
            }
            do {
                print(data)
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as! [String: String]
                let firebaseToken = jsonResponse["firebase_token"]!
                self.signInToFirebaseWithToken(firebaseToken: firebaseToken)
            } catch let error {
                errorPopup(vc: self, error: error,
                           errorName: "로그인 에러")
                print("Error in parsing token: \(error)")
                UIViewController.removeSpinner(spinner: self.sv!)
            }
            
            }.resume()
    }
    
    /**
     Sign in to Firebse with the custom token generated from the validation server.
     
     Performs segue if signed in successfully.
     */
    func signInToFirebaseWithToken(firebaseToken: String) {
        Auth.auth().signIn(withCustomToken: firebaseToken) { (user, error) in
            if let authError = error {
                UIViewController.removeSpinner(spinner: self.sv!)
                print(authError)
            } else {
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.userObjectCheckforKT(uid: (Auth.auth().currentUser?.uid)!)
            }
        }
    }
    
    func userObjectCheckforKT(uid:String){
        Database.database().reference().child("user").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                UIViewController.removeSpinner(spinner: self.sv!)
                navigateToMainPage(pvc: self)
            }
            else{
                UIViewController.removeSpinner(spinner: self.sv!)
                navigateToRegCheckPage_short(pvc: self)
            }
    }
    }
        
    
    func userObjectCheckforFacebook(uid:String){
        Database.database().reference().child("user").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                navigateToMainPage(pvc: self)
            }
            else{
                let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"short_name, picture"], tokenString: FBSDKAccessToken.current().tokenString, version: nil, httpMethod: "GET")
                req?.start{(_, result, error) -> Void in
                    if(error == nil){
                        print("result \(result)")
                        let r = result as! NSDictionary
                        let name = r["short_name"]
                        var image:String = ""
                        if let imageDic = r["picture"] as? NSDictionary{
                            if let data = imageDic["data"] as? NSDictionary{
                                if let urlString = data["url"] as? String{
                                    image = urlString
                                    print("image ", image)
                                }
                            }
                        }
                        let user = Auth.auth().currentUser
                        print("IN USER")
                        let changeRequest = user?.createProfileChangeRequest()
                        
                        changeRequest?.displayName = name as? String
                        if image != ""{
                            changeRequest?.photoURL =
                                URL(string: image)
                        }
                        
                        changeRequest?.commitChanges { error in
                            if let error = error {
                                errorPopup(vc: self, error: error, errorName: "회원생성 에러")
                                return
                            } else {
                                navigateToRegCheckPage_short(pvc: self)
                            }
                        }
                        
                    }
                    else{
                        errorPopup(vc: self, error: error!, errorName: "토큰 에러")
                        return
                    }
                }
                
            }
        }
    }
    
}

public func createUserDataRef(uid:String, username: String){
    Database.database().reference().child("user").child(uid).child("username").setValue(username)
    Database.database().reference().child("id").child(uid).setValue(true)
}

    public func navigateToRegCheckPage_short(pvc: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "regCheckPage_short")
        pvc.present(vc, animated: true)
        
}


