//
//  mainPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 20..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import GeoFire
import Firebase
import CodableFirebase
import ImageSlideshow
import Kingfisher

class mainPage: UIViewController {

    @IBOutlet weak var storeSuggestion: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var noticePreview: UILabel!
    @IBOutlet weak var eventPreview: UILabel!
    @IBOutlet weak var competitionPreview: UILabel!
    
    @IBOutlet weak var bannerSlideshow: ImageSlideshow!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var competitionView: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
//        //그림자 없애기
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//
//        //색상 설정
        self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#F3713D")
//        self.navigationController?.navigationBar.tintColor = hexStringToUIColor(hex: "#F3713D")
//        self.navigationController?.navigationBar.isTranslucent = false
//
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    
//        if let navigationController = navigationController as? ScrollingNavigationController {
//            navigationController.showNavbar(animated: true)
//            navigationController.followScrollView(scrollView, delay: 0.0)
//        }
//        navigationController?.navigationBar
        self.navigationController?.isNavigationBarHidden = true

    }
    func getNoticePreview(completionHandler: @escaping ((String) -> Void)){
        Database.database().reference().child("notice").queryLimited(toFirst: 1).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                let model = try FirebaseDecoder().decode(([String:Notice]).self, from: value)
                print(model)
                let tmpArray = Array(model.values)
                completionHandler(tmpArray[0].noticeTitle)
            } catch let error {
                print(error)
            }
        }
    }
    

    
    func getEventPreview(completionHandler: @escaping ((String) -> Void)){
        Database.database().reference().child("event").queryLimited(toFirst: 1).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                let model = try FirebaseDecoder().decode(([String:Common]).self, from: value)
                print(model)
                let tmpArray = Array(model.values)
                completionHandler(tmpArray[0].title)
            } catch let error {
                print(error)
            }
        }
        }
        
    
    
    func getCompetitionPreview(completionHandler: @escaping ((String) -> Void)){
        Database.database().reference().child("competition").queryLimited(toFirst: 1).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                let model = try FirebaseDecoder().decode(([String:Common]).self, from: value)
                print(model)
                let tmpArray = Array(model.values)
                completionHandler(tmpArray[0].title)
            } catch let error {
                print(error)
            }
        }
    }
    
    
    func setupViews(){
    let tapNotice = UITapGestureRecognizer(target: self, action: #selector(self.noticeTapped))
    let tapEvent = UITapGestureRecognizer(target: self, action: #selector(self.eventTapped))
    let tapCompetition = UITapGestureRecognizer(target: self, action: #selector(self.competitionTapped))
    
    noticeView.addGestureRecognizer(tapNotice)
        eventView.addGestureRecognizer(tapEvent)
        competitionView.addGestureRecognizer(tapCompetition)
    }
    
    @objc func noticeTapped(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "notice") as! noticePage
        vc.navigationItem.title = "공지사항"
        vc.navigationItem.titleView?.tintColor = UIColor.white
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func eventTapped(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "commonPage") as! commonPage
        vc.infoType = "event"
        vc.navigationItem.title = "이벤트"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func competitionTapped(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "commonPage") as! commonPage
        vc.infoType = "competition"
        vc.navigationItem.title = "대회 정보"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setupBanner(){
        
        self.bannerSlideshow.contentScaleMode = .scaleToFill
        self.bannerSlideshow.slideshowInterval = 3.0
        self.bannerSlideshow.activityIndicator = DefaultActivityIndicator()
        getEventImages { (addr) in
            self.getImageUrls(addr: addr, completionHandler: { (source) in
                self.bannerSlideshow.setImageInputs(source)
            })
        }
       
    }
        
    
    func getImageUrls(addr:[String], completionHandler: @escaping (([ImageSource])->Void)){
        var imageUrls:[ImageSource] = []
        let Group = DispatchGroup()
        for ad in addr{
            Group.enter()
            KingfisherManager.shared.retrieveImage(with: URL(string: ad)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                print(image)
                if error != nil {
                    
                    // Uh-oh, an error occurred!
                    imageUrls.append(ImageSource(image:UIImage()))
                    Group.leave()
                } else {
                    // Data for "images/island.jpg" is returned
                    
                    let image = ImageSource(image:image!)
                    imageUrls.append(image)
                    Group.leave()
                    
                }
            })
            // Create a reference to the file you want to download
            let storRef = Storage.storage().reference()
            
            let islandRef = storRef.child(ad)
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//            islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                if error != nil {
//
//                    // Uh-oh, an error occurred!
//                    imageUrls.append(ImageSource(image:UIImage()))
//                    Group.leave()
//                } else {
//                    // Data for "images/island.jpg" is returned
//
//                    let image = ImageSource(image:UIImage(data: data!)!)
//                    imageUrls.append(image)
//                    Group.leave()
//
//                }
//
//            }
            
            
        }
        Group.notify(queue: .main) {
            completionHandler(imageUrls)
        }
    }
    func getEventImages(completionHandler: @escaping (([String])->Void)){
        Database.database().reference().child("event").queryLimited(toFirst: 4).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                let model = try FirebaseDecoder().decode([String:Common].self, from: value)
                let imageUrls = model.map{$0.value.commonImageURL}
                completionHandler(imageUrls as! [String])
                
            } catch let error {
                print(error)
            }
        }
    }
   
    
    @objc func storeClick(){
        //STORE JUMP
       print("storeJump")
        Database.database().reference().child("best").observeSingleEvent(of: .value) { (snapshot) in
            if let dic = snapshot.value as? [String:String]{
                print("in select touch")
                let storeUid = dic["pccafe"]
                Geofire_funcs.getFirebaseStore(key: storeUid!, completionHandler: { (store) in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let pclist = storyboard.instantiateViewController(withIdentifier: "listPage") as! listPage
                    let storePage = storyboard.instantiateViewController(withIdentifier: "storeDetailPage_Paid") as! storeDetailPage
                   storePage.store = store
                    let mp = storyboard.instantiateViewController(withIdentifier: "mainPage") as! mainPage
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                    self.navigationController?.isNavigationBarHidden = false
                    self.navigationController?.setViewControllers([mp, pclist, storePage], animated: true)
                    
                })
                
                
            }
            
        }
    }
    
    func bannerTapSetup(){
        let bt = UITapGestureRecognizer(target: self, action:  #selector(bannerClick))
        bannerSlideshow.addGestureRecognizer(bt)
    }
    
    @objc func bannerClick(){
       
        Database.database().reference().child("event").queryLimited(toFirst: 4).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                let model = try FirebaseDecoder().decode([String:Common].self, from: value)
             let vals = Array(model.values)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let cPage = storyboard.instantiateViewController(withIdentifier: "commonPage") as! commonPage
                cPage.infoType = "event"
                cPage.navigationItem.title = "이벤트"
                let cdPage = storyboard.instantiateViewController(withIdentifier: "commonDetailPage") as! commonDetailPage
                
                let mp = storyboard.instantiateViewController(withIdentifier: "mainPage") as! mainPage
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.navigationController?.isNavigationBarHidden = false
                
                cdPage.obj = vals[self.bannerSlideshow.currentPage]
                 self.navigationController?.setViewControllers([mp, cPage, cdPage], animated: true)
                
            } catch let error {
                print(error)
            }
        }
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupBanner()
        getSelectStore()
        setupViews()
        
        let ss = UITapGestureRecognizer(target: self, action:  #selector(storeClick))
        storeSuggestion.addGestureRecognizer(ss)
        bannerTapSetup()
        
        getEventPreview { (string) in
            self.eventPreview.text = string
        }
        getNoticePreview { (string) in
            self.noticePreview.text = string
        }
        
        getCompetitionPreview { (string) in
            self.competitionPreview.text = string
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        if let navigationController = self.navigationController as? ScrollingNavigationController {
//            navigationController.stopFollowingScrollView()
//        }
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventSegue"{
            let eventPage = segue.destination as! commonPage
            eventPage.infoType = "event"
            eventPage.navigationItem.title = "이벤트"
        }
        else if segue.identifier == "competitionSegue"{
            let competitionPage = segue.destination as! commonPage
            competitionPage.infoType = "competition"
            competitionPage.navigationItem.title = "대회정보"
            
        }
    }
    
    @IBOutlet weak var selectAddress: UILabel!
    @IBOutlet weak var selectRating: CosmosView!
    @IBOutlet weak var selectTitle: UILabel!
    @IBOutlet weak var selectImage: UIImageView!
    func getSelectStore(){
        Database.database().reference().child("best").observeSingleEvent(of: .value) { (snapshot) in
            if let dic = snapshot.value as? [String:String]{
            let storeUid = dic["pccafe"]
                Geofire_funcs.getFirebaseStore(key: storeUid!, completionHandler: { (store) in
                self.selectRating.rating = (store?.score)!
                self.selectTitle.text = store?.name
                self.selectAddress.text = store?.address
                    self.selectImage.tintColor = UIColor.lightGray
                    self.selectImage.backgroundColor = UIColor.lightGray
                    if store?.image == nil {
                        self.selectImage.image = #imageLiteral(resourceName: "noImage")
                    }
                    else{
                        self.selectImage.sd_setImage(with: Storage.storage().reference().child("store").child((store?.type)!).child(storeUid!).child("main.jpeg"))
//                        store?.getImageData(imageuid: (store?.image)!, completionHandler: { (imageArray) in
//                        if imageArray.isEmpty{
//                            self.selectImage.image = #imageLiteral(resourceName: "noImage")
//                        }
//                        else{
//                            self.selectImage.image =
//                        }
//                    })
                    }
//                    self.selectImage.sd_setImage(with: Storage.storage().reference().child("store").child("pccafe").child((store?.storeid)!).child("123.jpg"))
                })
                
            }
        }
            
        }
    
    

}
