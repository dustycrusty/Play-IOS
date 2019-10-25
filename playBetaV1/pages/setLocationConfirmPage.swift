//
//  setLocationConfirmPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 19..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import GoogleMaps

class setLocationConfirmPage: UIViewController {
    
    var lat:Double?
    var lng:Double?
    
    var locName:String?
    var locDetail:String?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationDetail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationName.text = locName
        locationDetail.text = locDetail
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
        marker.map = mapView
        mapView.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 18)

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedConfirm(_ sender: Any) {
        
        self.performSegue(withIdentifier: "unwindToList", sender: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToList"{
            print("segued")
            if let vc = segue.destination as? listPage{
                print("in vc check")
            vc.isFirstMove = false
            vc.lat = lat
            vc.lng = lng
            vc.rewinded = true
            vc.data = [[],[],[]]
            vc.dataByDistance = [[],[],[]]
            vc.segmentio.selectedSegmentioIndex = 0
            vc.segmentedIndex = 0
            vc.firstChangeInSegment = true
            }
            else if let vc = segue.destination as? listPage_bowlingcafe{
                vc.isFirstMove = false
                vc.lat = lat
                vc.lng = lng
                vc.rewinded = true
                vc.data = [[],[],[]]
                vc.dataByDistance = [[],[],[]]
                vc.segmentio.selectedSegmentioIndex = 0
                vc.segmentedIndex = 0
                vc.firstChangeInSegment = true
            }
            else if let vc = segue.destination as? listPage_poolcafe{
                vc.isFirstMove = false
                vc.lat = lat
                vc.lng = lng
                vc.rewinded = true
                vc.data = [[],[],[]]
                vc.dataByDistance = [[],[],[]]
                vc.segmentio.selectedSegmentioIndex = 0
                vc.segmentedIndex = 0
                vc.firstChangeInSegment = true
        }
    }
    }
 

}
