//
//  storeDetailPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 17..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import ImageSlideshow
import GoogleMaps
import Dropper

class storeDetailPage: UIViewController, UITableViewDataSource, UITableViewDelegate, DropperDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var seatInfo: UILabel!
    @IBOutlet weak var facilityInfo: UILabel!
    @IBOutlet weak var extraInfo: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var review:[Review] = []
    
    var store:Store? = nil
    let dropper = Dropper(width: 75, height: 200)

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if review[indexPath.row].response != nil{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCellWithReply", for: indexPath) as! reviewCellWithReply
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
    
    @objc func dropTap(sender:UIButton){
        print("TAPPED")
//        if dropper.status == Dropper.Status.hidden {
//            print("triggered1")
//            dropper.items = ["신고하기"] // Item displayed
//            dropper.theme = Dropper.Themes.white
//            dropper.cornerRadius = 3
////            dropper.showWithAnimation(0.15, options: Dropper.Alignment.center, button: sender)
//
//        } else {
//            print("triggered2")
//            dropper.hideWithAnimation(0.1)
//        }
    }
    
    
    func reportedMessage(){
        let alert = UIAlertController(title: "신고 접수", message: "신고가 접수되었습니다!", preferredStyle: .alert)
        
       
            self.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    func submitReport(tableViewCell:UITableViewCell){
            let ref = Database.database().reference().child("reviewReport").child((self.store?.type)!).child((self.store?.storeid)!)
            
//            ref.updateChildValues(reportAddition)
            reportedMessage()
    
    }
    
    func DropperSelectedRow(path: NSIndexPath, contents: String) {
        print(path.row)
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
    @objc func didTap() {
        slideShow.presentFullScreenController(from: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false

        slideShow.contentScaleMode = .scaleToFill
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        slideShow.addGestureRecognizer(gestureRecognizer)
        
        checkUserFavorite(storeUid: (self.store?.storeid)!) { (favorite) in
            if favorite{
                self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "Star_filled").withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tapToUnfavorite)), animated: true)
            }
            else{
                self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "Star_empty").withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tapToFavorite)), animated: true)
            }
        }
        
        setup()
        
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
    
    
    @IBAction func writeReviewTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  storyboard.instantiateViewController(withIdentifier: "uploadReviewPage") as! uploadReviewPage
        vc.store = store
        self.navigationController?.pushViewController(vc, animated: true)
    }
//    @IBAction func tappedReserve(_ sender: Any) {
//        showAlert()
//    }
    func showAlert1() {
        let alert = UIAlertController(title: "전화번호 정보 없음", message: "전화번호가 없습니다 ㅠ.ㅠ", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    @IBAction func tappedPaymentNow(_ sender: Any) {
        if self.store?.phoneNumber?.isEmpty == false{
            self.store?.phoneNumber!.makeAColl()
        }
        else{
            showAlert1()
        }
        
    }
    func showAlert() {
        let alert = UIAlertController(title: "기능 해결", message: "현재 개발중에 있습니다. 추후 업데이트를 기다려주세용><", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }

    func setup(){
//        let ref: DatabaseReference! = Database.database().reference()
//        ref.child("store").child("pccafe").child("-L9cz8QvJp7caOhd23l8").observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let value = snapshot.value else { return }
//            do {
//                self.store = try FirebaseDecoder().decode(Store.self, from: value)
//                print(self.store!)
//            } catch let error {
//                print(error)
//            }
            self.about.text = (self.store?.about)!
            
            self.address.text = (self.store?.address)!
            
            if self.store?.condition != nil{
                var text = "\n\n"
                for cond in (self.store?.condition)!{
                    text.append("       -" + cond + "\n\n")
                }
                self.facilityInfo.text = text + "\n"
            }
            if (self.store?.extraInfo)! != ""{
                var text = "\n\n"
                for cond in (self.store?.priceInfo)!{
                    text.append("       -" + cond + "\n\n")
                }
                self.extraInfo.text = text + "\n"
        }
        
            
            self.name.text = (self.store?.name)!
            self.starRating.rating = (self.store?.score)!
            self.starRating.text = String((self.store?.score)!)
            if self.store?.spec != nil{
                var text = "\n\n"
                for sp in (self.store?.spec)!{
                    text.append("       -" + sp + "\n\n")
                }
                self.seatInfo.text = text + "\n"
            }
        if store?.image == nil {
           self.slideShow.setImageInputs([ImageSource(image: #imageLiteral(resourceName: "noImage"))])
        }
        else{
            store?.getImageData(imageuid: (store?.image)!, completionHandler: { (imageArray) in
                if imageArray.isEmpty{
                    self.slideShow.setImageInputs([ImageSource(image: #imageLiteral(resourceName: "noImage"))])
                }
                else{
                    var inputSourceArray:[ImageSource] = []
                    for x in imageArray{
                    inputSourceArray.append(ImageSource(image: x))
                    }
                    
                    self.slideShow.setImageInputs(inputSourceArray)
                }
            })
        }
        
            
            
//        })
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
    @IBAction func moreReviewsTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "allReviewsPage") as? allReviewsPage
        vc?.store = self.store
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
