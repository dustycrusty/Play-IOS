//
//  nearMePage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 22..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import GoogleMaps
import Segmentio

class nearMePage: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate  {


    @IBOutlet weak var storeTypeFilter: Segmentio!
    
    var content:[SegmentioItem] = [SegmentioItem(title: "PC방", image: nil), SegmentioItem(title: "당구장", image: nil),
                                   SegmentioItem(title: "볼링장", image:nil)]
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var markerDetailView: storeDetailCategory!
    @IBOutlet weak var storeTitle: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var storeScore: CosmosView!
    
    var isFirstMove = true
    var stores:[Store] = []
    var bounds = GMSCoordinateBounds()
    var locationManager = CLLocationManager()
     var markerDict:[String: GMSMarker] = [:]
    var index:Int?
    @IBOutlet weak var selectStoreButton: UIButton!
    var filteredStores:[[Store]] = [[],[],[]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "내 주변"

       filteredStores = [[],[],[]]
        selectStoreButton.backgroundColor = hexStringToUIColor(hex: "#F3713D")
        markerDetailView.alpha = 0
        segmentioSetup()
        segmentioItemConfigure()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        initializeTheLocationManager()
        self.mapView.isMyLocationEnabled = true
    }
    
    func segmentioItemConfigure(){
        
        storeTypeFilter.selectedSegmentioIndex = 0
        storeTypeFilter.valueDidChange = {segment, segmentIndex in
            print("value changed")
            self.setup(stores: self.filteredStores)
            UIView.animate(withDuration: 0.5) {
                self.markerDetailView.alpha = 0
            }
        }
    }
    func showAlert() {
    let alert = UIAlertController(title: "주변에 없습니다!", message: "주변에 선택된 종류의 매장이 없습니다ㅠ.ㅠ", preferredStyle: .alert)
    self.present(alert, animated: true, completion: nil)
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    func segmentioSetup(){
        let array = ["PC방", "당구장", "볼링장"]
        
        storeTypeFilter.setup(content: content, style: .onlyLabel, options: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
        mapView.isMyLocationEnabled = false
    }
    @IBAction func selectedStore(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if self.filteredStores[storeTypeFilter.selectedSegmentioIndex][self.index!].paid == "normal"{
            let controller = storyboard.instantiateViewController(withIdentifier: "storeDetailPage_unpaid") as! storeDetailPage_unpaid
            controller.store = self.filteredStores[storeTypeFilter.selectedSegmentioIndex][self.index!]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    
        else {
            let controller = storyboard.instantiateViewController(withIdentifier: "storeDetailPage_Paid") as! storeDetailPage
            controller.store = self.filteredStores[storeTypeFilter.selectedSegmentioIndex][self.index!]
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
    }
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("did update locations")
//        var location = locationManager.location?.coordinate
        if isFirstMove{
        if let location = locations.first{
            
        cameraMoveToLocation(location: location)
            isFirstMove = false
        }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
       
        if let i = filteredStores[storeTypeFilter.selectedSegmentioIndex].index(where: { $0.lat == marker.position.latitude && $0.lng == marker.position.longitude }) {
            index = i
//            if stores[i].type == "bowlingcafe"{
//                self.markerDetailView.borderColor = "#00FF00"
//            }
//            else if stores[i].type == "poolcafe"{
//                self.markerDetailView.borderColor = "#0000FF"
//            }
//            else if stores[i].type == "pccafe"{
//                self.markerDetailView.borderColor = "#F3713D"
//            }
            self.storeAddress.text = filteredStores[storeTypeFilter.selectedSegmentioIndex][i].address
            self.storeTitle.text = filteredStores[storeTypeFilter.selectedSegmentioIndex][i].name
            self.storeScore.text = String(filteredStores[storeTypeFilter.selectedSegmentioIndex][i].score)
            self.storeScore.rating = filteredStores[storeTypeFilter.selectedSegmentioIndex][i].score
            
        }
        
        UIView.animate(withDuration: 0.5) {
            self.markerDetailView.alpha = 1
        }
        self.mapView.animate(toLocation: marker.position)
        return true
        
    }
    
    func cameraMoveToLocation(location: CLLocation) {
            print("in camera move to location")
            mapView.camera = GMSCameraPosition.camera(withTarget:CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), zoom: 15)
            Geofire_funcs.getNearByStores(coordinate: location) { (stores) in
                print("in stores")
                let dg = DispatchGroup()

                for store in stores!{
                    dg.enter()
                    if store.type == "bowlingcafe"{
                        self.filteredStores[2].append(store)
                        dg.leave()
                    }
                    else if store.type == "poolcafe"{
                        self.filteredStores[1].append(store)
                        dg.leave()
                    }
                    else{
                        self.filteredStores[0].append(store)
                        dg.leave()
                    }
                }
                
                dg.notify(queue: .main, execute: {
                    print("notify")
                     self.setup(stores: self.filteredStores)
                })
               
//                self.stores = stores!
            }
    }

  
    

    
    func setup(stores:[[Store]]) {
       markerDict.removeAll()
        mapView.clear()
    bounds = GMSCoordinateBounds()
       bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!))
       print("in Setup")
//        mapView = GMSMapView.map(withFrame: self.view.frame, camera: GMSCameraPosition.camera(withLatitude: 51.050657, longitude: 10.649514, zoom: 5.5))
//        mapView?.delegate = self
//        mapView?.center = self.view.center
        if stores[storeTypeFilter.selectedSegmentioIndex].isEmpty == false{
        for store in stores[storeTypeFilter.selectedSegmentioIndex]{
            let store_marker = GMSMarker()
            store_marker.position = CLLocationCoordinate2D(latitude: Double(store.lat), longitude: Double(store.lng))
            bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: Double(store.lat), longitude: Double(store.lng)))
            store_marker.title = store.name
            store_marker.snippet = store.address
            store_marker.map = mapView
            store_marker.appearAnimation = .pop
//            if store.type == "poolcafe"{
//                store_marker.icon = GMSMarker.markerImage(with: .blue)
//            }
//            else if store.type == "bowlingcafe"{
//                store_marker.icon = GMSMarker.markerImage(with: .green)
//            }
//            else if store.type == "pccafe"{
//                store_marker.icon = GMSMarker.markerImage(with: hexStringToUIColor(hex: "#F3713D"))
//            }
            markerDict[store.name] = store_marker
        }
        }
        else{
            showAlert()
        }
        
        mapView!.animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsetsMake(50.0 , 50.0 ,50.0 ,50.0)))
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


