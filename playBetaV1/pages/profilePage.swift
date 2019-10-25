//
//  profilePage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 7..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import AvatarImageView
import Kingfisher
import Firebase

    let menuItem = ["공지사항", "고객센터", "제휴문의", "로그아웃"]
let menuItemImage = [#imageLiteral(resourceName: "notice"),#imageLiteral(resourceName: "cC"),#imageLiteral(resourceName: "AD"),#imageLiteral(resourceName: "logout")]

class profilePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func tappedUsageHistory(_ sender: Any) {
        showAlert()
    }
    @IBAction func tappedCoupon(_ sender: Any) {
        showAlert()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var removeHeader:Bool = false
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if removeHeader {
//            return 0.0
//        } else {
//            let height = self.tableView.sectionHeaderHeight
//            return height
//        }
//    }
//    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! profilePageCell
        cell.title.text = menuItem[indexPath.row]
        cell.menuIcon.image = menuItemImage[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let identifierId = ["notice", "cC", "AD", "logout"]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if identifierId[indexPath.row] == "logout"{
            do{
                try Auth.auth().signOut()
                let alert = UIAlertController(title: "로그아웃", message: "로그아웃했습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                    let vc = storyboard.instantiateViewController(withIdentifier: "loginNavPage")
                    self.present(vc, animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            catch{
                errorPopup(vc: self, error: error, errorName: "로그아웃 에러")
            }

        }
        else if identifierId[indexPath.row] != "AD" && identifierId[indexPath.row] != "setting" {
            let vc = storyboard.instantiateViewController(withIdentifier: identifierId[indexPath.row])
            vc.navigationItem.title = menuItem[indexPath.row]
            vc.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if identifierId[indexPath.row] == "AD"{
            let vc = storyboard.instantiateViewController(withIdentifier: "advDetail")
            vc.navigationItem.title = "제휴문의"
            vc.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            showAlert()
        }
    
    }


    @IBOutlet weak var profilePic: AvatarImageView!{
        didSet {
            configureRoundAvatar() // Comment this line for a square avatar as that is the default.
            showInitials()
            showProfilePicture()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        showInitials()
        showProfilePicture()
        
    }

    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#F3713D")
        self.navigationController?.navigationBar.tintColor = hexStringToUIColor(hex: "#F3713D")
        username.text = Auth.auth().currentUser?.displayName
         self.tableView.tableFooterView = UIView()
//        removeSectionHeader()
        // Do any additional setup after loading the view.
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
    
    func removeSectionHeader() {
        removeHeader = true
        self.tableView.reloadData()
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
    public func showAlert() {
        let alert = UIAlertController(title: "기능 해결", message: "현재 개발중에 있습니다. 추후 업데이트를 기다려주세용><", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }

}
