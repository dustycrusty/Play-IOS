//
//  storeDetailPage_unpaid.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 28..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import CodableFirebase
import Dropper

class storeDetailPage_unpaid: UIViewController, UITableViewDelegate, UITableViewDataSource, DropperDelegate{

    @IBOutlet weak var facilityInfo: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var score: CosmosView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var store:Store? = nil
    let dropper = Dropper(width: 75, height: 200)

    var review:[Review] = []
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (review[indexPath.row].response != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCellWithReply", for: indexPath) as! reviewCellWithReply
            cell.layoutSubviews()
            cell.backgroundColor = hexStringToUIColor(hex: "#FFF6E5")
//            cell.profilePic
            cell.message.text = review[indexPath.row].message
            cell.rating.rating = review[indexPath.row].rating
            cell.rating.text = String(describing: review[indexPath.row].rating)
            cell.uploadedTime.text = review[indexPath.row].time
            cell.username.text = review[indexPath.row].username
            
            cell.ownerMessage.text = review[indexPath.row].response?.message
            cell.ownerUploadedTime.text = review[indexPath.row].response?.time
//            assignbackground(view: cell.ownerView)
            
            return cell
        }
        else{
            print(indexPath.row)
            print(review)
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCellOriginal", for: indexPath) as! reviewCellOriginal
            cell.layoutSubviews()
            cell.backgroundColor = hexStringToUIColor(hex: "#FFF6E5")

            cell.message.text = review[indexPath.row].message
            cell.rating.rating = review[indexPath.row].rating
        
//            cell.dropperButton.tag = indexPath.row
//            cell.dropperButton.addTarget(self, action: #selector(dropTap(sender:)), for: .touchUpInside)
            cell.rating.text = String(describing: review[indexPath.row].rating)
            cell.uploadedTime.text = review[indexPath.row].time
            cell.username.text = review[indexPath.row].username
            
            return cell
//            cell.profilePic
        }
        
//        if ((review[indexPath.row] as? Review) != nil){
//
//        }
//        else if ((review[indexPath.row] as? Response) != nil){
//
//        }
//        else{
//
//        }
    }
    

    
    
   
    func showAlert() {
        let alert = UIAlertController(title: "기능 해결", message: "현재 개발중에 있습니다. 추후 업데이트를 기다려주세용><", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewHeight.constant = self.tableView.contentSize.height
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review.count
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.review.removeAll()
        let nib2 = UINib(nibName: "reviewCellWithReply", bundle: nil)
        self.tableView.register(nib2, forCellReuseIdentifier: "reviewCellWithReply")
        let nib = UINib(nibName: "reviewCellOriginal", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "reviewCellOriginal")
        print((store?.type)!, (store?.storeid)!)
        let recentReviewsQuery = Database.database().reference().child("store/\((store?.type)!)/\((store?.storeid)!)/review").queryLimited(toFirst: 5)
        recentReviewsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                let dg = DispatchGroup()
                print("exists!")
                let value = snapshot.value as? [String:Any]
                for x in (value?.values)!{
                    dg.enter()
                    do {
                        let reviewObject = try FirebaseDecoder().decode(Review.self, from: x)
                        
                        self.review.append(reviewObject)
                        print("appended")
                        dg.leave()
                    }
                    catch let error {
                        print("errored")
                        print(error)
                        self.tableView.reloadData()
                        self.tableViewHeight.constant = self.tableView.contentSize.height
                        dg.leave()
                        break
                    }
                }
                dg.notify(queue: DispatchQueue.main, execute: {
                    self.tableView.reloadData()
                    self.tableViewHeight.constant = self.tableView.contentSize.height

                })
            }
            else{
                print("doesnt exist")
                self.tableView.reloadData()
                self.tableViewHeight.constant = self.tableView.contentSize.height
                self.tableView.rowHeight = UITableViewAutomaticDimension

            }
            
            
            print("reloaded")
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        checkUserFavorite(storeUid: (self.store?.storeid)!) { (favorite) in
            if favorite{
                self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "Star_filled").withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tapToUnfavorite)), animated: true)
            }
            else{
                self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "Star_empty").withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tapToFavorite)), animated: true)
            }
        }
        
        setup()
        self.navigationItem.title = "내 주변"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        let store_marker = GMSMarker()
        store_marker.position = CLLocationCoordinate2D(latitude: Double((store?.lat)!), longitude: Double((store?.lng)!))
        store_marker.map = mapView
        mapView.camera = GMSCameraPosition.camera(withTarget: store_marker.position, zoom: 18)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapToFavorite(){
        setUserFavorite(storeUid: (self.store?.storeid)!)
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "Star_filled").withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tapToUnfavorite)), animated: true)
    }
    
    @objc func tapToUnfavorite(){
        unsetUserFavorite(storeUid: (self.store?.storeid)!)
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "Star_empty").withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tapToFavorite)), animated: true)
    }
    
    @IBAction func uploadReviewTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  storyboard.instantiateViewController(withIdentifier: "uploadReviewPage") as! uploadReviewPage
        vc.store = store
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setup(){
        if self.store?.condition != nil{
            var text = "\n\n"
            for cond in (self.store?.condition)!{
                text.append("-" + cond + "\n")
            }
            self.facilityInfo.text = text + "\n"
        }
        
        self.name.text = (self.store?.name)!
        self.score.text = String(describing: (self.store?.score)!)

        self.score.rating = (self.store?.score)!
        self.address.text = (self.store?.address)!
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func showAlert1() {
        let alert = UIAlertController(title: "전화번호 정보 없음", message: "전화번호가 없습니다 ㅠ.ㅠ", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }

    @IBAction func tappedPayment(_ sender: Any) {
        if self.store?.phoneNumber?.isEmpty == false{
            self.store?.phoneNumber!.makeAColl()
        }
        else{
            showAlert1()
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

    @IBAction func moreReviewTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "allReviewsPage") as? allReviewsPage
        vc?.store = self.store
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

public func checkUserFavorite(storeUid:String, completionHandler: @escaping ((Bool) -> Void)){
    let user = Auth.auth().currentUser
    Database.database().reference().child("user").child((user?.uid)!).child("favorite").observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists(){
            if let value = snapshot.value as? [String:Bool]{
                if Array((value.keys)).contains(storeUid){
                    completionHandler(true)
                }
                else{
                    completionHandler(false)
                }
            }
        }
        else{
            completionHandler(false)
        }
    }
}


public func setUserFavorite(storeUid:String){
    let user = Auth.auth().currentUser
    
    Database.database().reference().child("user").child((user?.uid)!).child("favorite").updateChildValues([storeUid:true])
}

public func unsetUserFavorite(storeUid:String){
    let user = Auth.auth().currentUser
    Database.database().reference().child("user").child((user?.uid)!).child("favorite").child(storeUid).removeValue()
}

extension String {
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeAColl() {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    print("here")
                    UIApplication.shared.open(url)
                } else {
                    print("2")
                    UIApplication.shared.openURL(url)
                }
            }
            else{
                print("url error")
            }
        
        
    }
}

