//
//  personalInfoChangePage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 27..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import AvatarImageView
import Kingfisher
import Firebase

class personalInfoChangePage: UIViewController {

    @IBOutlet weak var profilePic: AvatarImageView!{
        didSet {
            configureRoundAvatar() // Comment this line for a square avatar as that is the default.
            showInitials()
            showProfilePicture()
        }
    }
    
    func configureRoundAvatar() {
        struct Config: AvatarImageViewConfiguration { var shape: Shape = .circle }
        profilePic.configuration = Config()
    }
    func showProfilePicture() {
        var data = avatarImageDatasource()
        if Auth.auth().currentUser?.photoURL != nil{
            print("URL EXISTS")
            KingfisherManager.shared.retrieveImage(with: (Auth.auth().currentUser?.photoURL)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in

                if error == nil {
                    print("ERROR IS NIL")
                    data.avatar = image
                    self.profilePic.dataSource = data
                }
            })
        }
        
    }
    
    func showInitials() {
        profilePic.dataSource = avatarImageDatasource()
    }
    
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var password: UIButton!
    @IBOutlet weak var phoneNumber: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        setUpTexts()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        profilePic.addGestureRecognizer(tap)

    }
    
    @objc func handleTap(){
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            print("pickedImage..")

            guard let uid = Auth.auth().currentUser?.uid else {return}
            guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {return}
            let profileImgReference = Storage.storage().reference().child("profile_image_urls").child("\(uid).png")
            
            let uploadTask = profileImgReference.putData(imageData, metadata: nil) { (metadata, error) in
                print("uploading...")

                if let error = error {
                        errorPopup(vc: self, error: error, errorName: "이미지 업로드 에러")
                    }
                 else {
                    print("metadataExists ", (metadata != nil))
                    profileImgReference.downloadURL(completion: { (url, error) in
                        if let error = error{
                            errorPopup(vc: self, error: error, errorName: "업로드 에러")
                        }
                        print("downloadingUrl...")
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.photoURL = url
                        changeRequest?.commitChanges { (error) in
                            if let error = error{
                                errorPopup(vc: self, error: error, errorName: "정보 변경 에러")
                            }
                            else{
                                self.showInitials()
                                self.showProfilePicture()
                                print("committingChanges..")
                                let alert = UIAlertController(title: "성공", message: "프로파일 이미지 업로드를 성공했습니다!", preferredStyle: UIAlertControllerStyle.alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        
                        
                    })
                    
                    
                }
            }
            uploadTask.observe(.progress, handler: { (snapshot) in
                print(snapshot.progress?.fractionCompleted ?? "")
                // Here you can get the progress of the upload process.
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okTapped(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func setUpTexts(){
        if let email = Auth.auth().currentUser?.email{
            self.id.text = email
        }
        else{
            self.id.text = "이메일 아이디가 없습니다."
        }
       
    self.username.setTitle(Auth.auth().currentUser?.displayName, for: UIControlState.normal)
        
    self.username.titleLabel?.minimumScaleFactor = 0.5
    self.username.titleLabel?.adjustsFontSizeToFitWidth = true
    self.username.titleLabel?.numberOfLines = 1
        
        self.password.setTitle("눌러서 변경해주세요", for: UIControlState.normal)
        
        self.password.titleLabel?.minimumScaleFactor = 0.5
        self.password.titleLabel?.adjustsFontSizeToFitWidth = true
        self.password.titleLabel?.numberOfLines = 1
        
        self.phoneNumber.titleLabel?.minimumScaleFactor = 0.5
        self.phoneNumber.titleLabel?.adjustsFontSizeToFitWidth = true
        self.phoneNumber.titleLabel?.numberOfLines = 1
        
        if let ph = Auth.auth().currentUser?.phoneNumber{
            self.phoneNumber.setTitle(ph, for: UIControlState.normal)
        }
        else{
            self.phoneNumber.setTitle("전화번호가 없습니다. 눌러서 설정해주세요.", for: UIControlState.normal)
        }
    
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
