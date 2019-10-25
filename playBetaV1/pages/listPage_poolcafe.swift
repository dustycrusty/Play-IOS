//
//  listPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 28..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import CoreLocation
import Segmentio
import Firebase

class listPage_poolcafe: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredStores:[[Store]] = [[],[],[]]
    
    var content:[SegmentioItem] = [SegmentioItem(title: "평점순", image: nil), SegmentioItem(title: "거리순", image: nil)]

    @IBOutlet weak var locationTap: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addressText: UILabel!
    @IBOutlet weak var segmentio: Segmentio!
    
    var data:[[Store]] = [[],[],[]]
    var dataByDistance:[[Store]] = [[], [], []]
    
    var lat:Double?
    var lng:Double?
    
    var rewinded:Bool?
    
    var segmentedIndex:Int = 0
    var isFirstMove = true
    var locationManager = CLLocationManager()
    
    var firstChangeInSegment = true
    
    override func viewWillAppear(_ animated: Bool) {
        let tap = UITapGestureRecognizer(target: self, action:  #selector(tappedChangeLocation))
        locationTap.addGestureRecognizer(tap)
        if rewinded != nil{
            print("in view will appear rewinded", " ", lat!, " ", lng!)
            
            getData(location: CLLocation(latitude: lat!, longitude: lng!))
            performGoogleSearch(lat: String(lat!), lng: String(lng!))
            
            print("isfirstmove", isFirstMove)
        }
        else{
            print("no rewind")
            initializeTheLocationManager()

        }
//        definesPresentationContext = true
//        self.view.layoutIfNeeded()
        
    }
    
   
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        let group = DispatchGroup()
        group.enter()
        if segmentio.selectedSegmentioIndex == 0{
            filteredStores[0] = data[0].filter { (store:Store) -> Bool in
                return store.name.lowercased().contains(searchText.lowercased())
            }
            filteredStores[1] = data[1].filter { (store:Store) -> Bool in
                return store.name.lowercased().contains(searchText.lowercased())
            }
            filteredStores[2] = data[2].filter { (store:Store) -> Bool in
                return store.name.lowercased().contains(searchText.lowercased())
            }
            
        
            group.leave()

//        tableView.reloadData()
        }
        else{
            filteredStores[0] = dataByDistance[0].filter { (store:Store) -> Bool in
                return store.name.lowercased().contains(searchText.lowercased())
            }
            filteredStores[1] = dataByDistance[1].filter { (store:Store) -> Bool in
                return store.name.lowercased().contains(searchText.lowercased())
            }
            filteredStores[2] = dataByDistance[2].filter { (store:Store) -> Bool in
                return store.name.lowercased().contains(searchText.lowercased())
            }
            group.leave()
//            tableView.reloadData()
            
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if searchController.isActive {
            self.searchController.dismiss(animated: true, completion: nil)
        }
        self.navigationController?.view.setNeedsLayout()
        self.navigationController?.view.layoutIfNeeded()
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            return filteredStores[section].count
        }
        return data[section].count
    }
    
    func performGoogleSearch(lat:String, lng:String) {
        
        var components = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json")!
        let key = URLQueryItem(name: "key", value: "******************************")
        let address = URLQueryItem(name: "latlng", value: "\(lat),\(lng)")
        let language = URLQueryItem(name: "language", value: "ko")
        let resultType = URLQueryItem(name: "result_type", value: "street_address")
        components.queryItems = [key, address, language,resultType]
        
        let task = URLSession.shared.dataTask(with: components.url!) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                print(String(describing: response))
                print(String(describing: error))
                return
            }
            
            guard let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("not JSON format expected")
                print(String(data: data, encoding: .utf8) ?? "Not string?!?")
                return
            }
            
            guard let results = json["results"] as? [[String: Any]],
                let status = json["status"] as? String,
                status == "OK" else {
                    print("no results")
                    print(String(describing: json))
                    return
            }
            
            DispatchQueue.main.async {
                var streetNumber:String = ""
                var route:String = ""
                let first = results[0]["address_components"] as! [[String:Any]]
                
                for x in first{
                    if let type = x["types"] as? [String]{
                        print("in if let")
                        print(type)
                        if type.contains("sublocality_level_2"){
                            streetNumber = (x["short_name"] as? String)!
                            print("contains")
                        }
                        else if type.contains("sublocality_level_1"){
                            route = (x["short_name"] as? String)!
                            print("contains2")

                        }
                    }
                }
                
                // now do something with the results, e.g. grab `formatted_address`:
//                let strings = results.compactMap { $0["formatted_address"] as? String }
//                self.addressText.text = strings[0]
                print("searched")
                self.addressText.text = "\(route) \(streetNumber)"
            }
        }
        
        task.resume()
    }
    
    @objc func tappedChangeLocation(){
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("tapped")
        let vc = storyboard.instantiateViewController(withIdentifier: "setLocationPage") as! setLocationPage
        vc.navigationItem.title = "위치 설정"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func segmentioSetup(){
        segmentio.setup(content: content, style: .onlyLabel, options: nil)
        
    }
    let segmentioWorker1 = DispatchQueue(label: "1")
   
    let segmentioWorkerF = DispatchQueue(label: "Reload")
    
    func segmentioItemConfigure(){
        segmentio.selectedSegmentioIndex = 0
        segmentio.valueDidChange = {segment, segmentIndex in
            print("value changed")
            if segmentIndex == 0{
               
                self.segmentedIndex = segmentIndex
                self.tableView.reloadData()

//                for x in self.data{
//                    self.segmentioWorker1.sync(execute: {
//                        print("synced1")
//                        print(count)
//
//                        self.data[count] = x.sorted(by: { (store1:Store, store2:Store) -> Bool in
//                            return store1.score > store2.score
//                        })
//                        count += 1
//                    })
//                    print("reloaded")
//
//                     self.tableView.reloadData()
//                }
            }
            else if segmentIndex == 1{
                let sv = UIViewController.displaySpinner(onView: self.view)
                self.searchController.searchBar.isUserInteractionEnabled = false

                if self.firstChangeInSegment == true{
                    self.firstChangeInSegment = false
                    
                    var count = 0
                    
                    for x in self.data{
                        self.segmentioWorker2.sync {
                            print("synced2")
                            print(count)
                            self.dataByDistance[count] = x.sorted(by: { (store1:Store, store2:Store) -> Bool in
                                return Int(store1.distance!) < Int(store2.distance!)
                            })
                            count += 1
                        }
                        
                        
                    }
                }
                self.segmentedIndex = segmentIndex
                
                print("reloaded")
                UIViewController.removeSpinner(spinner: sv)
                self.searchController.searchBar.isUserInteractionEnabled = true

                self.tableView.reloadData()
            }
        }
        
        
        
    }
    
    
    fileprivate func sectionCheckReturnCell(_ section: Int, _ tableView: UITableView, _ dataForm: inout Array<Array<Store>>?, _ row: Int) -> UITableViewCell {
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "premiumCell") as! PremiumCell
            cell.address.text = dataForm![section][row].address
            cell.name.text = dataForm![section][row].name
            cell.rating.text = String(describing: dataForm![section][row].score)
            cell.rating.rating = dataForm![section][row].score
            if dataForm![section][row].image == nil {
                cell.storeImage.image = #imageLiteral(resourceName: "noImage")
            }
            else{
                let keys = Array((dataForm![section][row].image?.keys)!)
                let store = dataForm![section][row]
                print("KEY : \(keys[0])")
                cell.storeImage.sd_setImage(with: Storage.storage().reference().child("store").child(store.type).child(store.storeid).child("main.jpeg"), placeholderImage: #imageLiteral(resourceName: "noImage"))
            }
            return cell
        }
        else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "paidCell") as! paidCell
            cell.address.text = dataForm![section][row].address
            cell.title.text = dataForm![section][row].name
            cell.rating.text = String(describing: dataForm![section][row].score)
            var x = Measurement(value:dataForm![section][row].distance!, unit: UnitLength.meters)
            x.convert(to:UnitLength.kilometers)
            let n = NumberFormatter()
            n.maximumFractionDigits = 2
            n.locale = Locale(identifier: "ko_KR")
            let m = MeasurementFormatter()
            m.numberFormatter = n
            m.locale = Locale(identifier: "ko_KR")
            cell.distance.text = m.string(from: x)
            if dataForm![section][row].image == nil {
                cell.storeImage.image = #imageLiteral(resourceName: "noImage")
            }
            else{
                let keys = Array((dataForm![section][row].image?.keys)!)
                let store = dataForm![section][row]
                print("KEY : \(keys[0])")
                cell.storeImage.sd_setImage(with: Storage.storage().reference().child("store").child(store.type).child(store.storeid).child("main.jpeg"), placeholderImage: #imageLiteral(resourceName: "noImage"))
            }
            if dataForm![section][row].event != nil{
                cell.currentEvent.text = "현재 이벤트 중!"
            }
            else{
                cell.currentEvent.text = ""
            }
            
            cell.rating.rating = dataForm![section][row].score
            return cell
            
        }
            
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell") as! normalCell
            cell.address.text = dataForm![section][row].address
            cell.name.text = dataForm![section][row].name
            cell.rating.text = String(describing: dataForm![section][row].score)
            cell.rating.rating = dataForm![section][row].score
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        var dataForm:[[Store]]?
        if segmentedIndex == 0{
            if isFiltering(){
            dataForm = filteredStores
            }
            else{
                dataForm = data
            }
        }
        else{
            if isFiltering(){
                dataForm = filteredStores
            }
            else{
                dataForm = dataByDistance
            }
        }
        return sectionCheckReturnCell(section, tableView, &dataForm, row)
    }
    func arrayCount(array:[[Store]]) -> Int{
        return array[0].count + array[1].count + array[2].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
       
        if arrayCount(array: data) != 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 3
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "주변에 당구장을 못찾았어요ㅠ.ㅠ"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headers = ["프리미엄 매장 >", "제휴 매장 >", "일반 매장 >"]
        return headers[section]
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var dataForm:[[Store]]?
        if segmentedIndex == 0{
            if isFiltering(){
                dataForm = filteredStores
            }
            else{
                dataForm = data
            }
        }
        else{
            if isFiltering(){
                dataForm = filteredStores
            }
            else{
                dataForm = dataByDistance
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 || indexPath.section == 1{
            let controller = storyboard.instantiateViewController(withIdentifier: "storeDetailPage_Paid") as! storeDetailPage
            controller.store = dataForm![indexPath.section][indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else{
            let controller = storyboard.instantiateViewController(withIdentifier: "storeDetailPage_unpaid") as! storeDetailPage_unpaid
            controller.store = dataForm![indexPath.section][indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "가게 검색"
        self.navigationItem.titleView = searchController.searchBar
//        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
//    self.view.addSubview(searchController.searchBar)
        definesPresentationContext = true
        
        self.tableView.register(UINib(nibName: "paidCell", bundle: nil), forCellReuseIdentifier: "paidCell")
        self.tableView.register(UINib(nibName: "normalCell", bundle: nil), forCellReuseIdentifier: "normalCell")
        
        segmentioSetup()
        segmentioItemConfigure()

//        self.tableView.estimatedRowHeight = 44.0
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        // Do any additional setup after loading the view.
    }

    let dispatch_group = DispatchGroup()
    let asianWorker = DispatchQueue(label: "getList")
    let brownWorker = DispatchQueue(label: "getStore")
    let segmentioWorker2 = DispatchQueue(label: "2")
    
    func getData(location: CLLocation){
        let sv = UIViewController.displaySpinner(onView: self.view)
        self.searchController.searchBar.isUserInteractionEnabled = false
        Geofire_funcs.getListStores(coordinate: (location)) { (stores) in
            self.asianWorker.sync(execute: {
                for store in stores!{
                    if store.type == "poolcafe"{
                    if store.paid == "premium"{
                        self.data[0].append(store)
                    }
                    else if store.paid == "paid"{
                        self.data[1].append(store)
                        
                    }
                    else{
                        self.data[2].append(store)
                    }
                    }
            }
            })
           
            
            
        
            self.brownWorker.sync(execute: {
                print("reloaded in getData")
                self.tableView.reloadData()
                UIViewController.removeSpinner(spinner: sv)
                self.searchController.searchBar.isUserInteractionEnabled = true

            })
            
            

        }
        }
        
        
    
    
    
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
//    let DG = DispatchGroup()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("called")
        if isFirstMove{
        if let location = locations.first{
            performGoogleSearch( lat: String(location.coordinate.latitude), lng: String(location.coordinate.longitude))
        getData(location: location)
            isFirstMove = false
        }
        }
        
        //        var location = locationManager.location?.coordinate
        
    }
    
    @IBAction func unwindToList(segue:UIStoryboardSegue){
        
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
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

extension listPage_poolcafe: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)

    }
}


