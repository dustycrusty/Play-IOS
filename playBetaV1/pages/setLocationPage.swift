//
//  setLocationPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 19..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import GooglePlaces

class setLocationPage: UIViewController {

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var selectedLat:Double?
    var selectedLng:Double?
    
    var selectedLocName:String?
    var selectedLocDetail:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "위치 선택"
        
        self.hideKeyboardWhenTappedAround() 
        resultsViewController = GMSAutocompleteResultsViewController()
        
//        resultsViewController?.autocompleteFilter?.country = "KR"

        resultsViewController?.delegate = self
        let filter = GMSAutocompleteFilter()
        filter.country = "KR"
        filter.type = .noFilter
//        resultsViewController?.autocompleteFilter?.country = "KR"
        resultsViewController?.autocompleteFilter = filter
        
        searchController = UISearchController(searchResultsController: resultsViewController)

        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.placeholder = "위치를 검색해주세요!"
       
        let subView = UIView(frame: CGRect(x:0, y:0, width: self.view.bounds.width, height: self.view.bounds.height))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        
        searchController?.hidesNavigationBarDuringPresentation = true
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        // Do any additional setup after loading the view.
        

    }

    func setSearchButtonText(text:String,searchBar:UISearchBar) -> UISearchBar {
        
        for subview in searchBar.subviews {
            for innerSubViews in subview.subviews {
                if let cancelButton = innerSubViews as? UIButton {
                    cancelButton.setTitleColor(UIColor.white, for: .normal)
                    cancelButton.setTitle(text, for: .normal)
                    return searchBar
                }
                return searchBar
            }
        }
     return searchBar
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConfirm"{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "setLocationConfirmPage") as! setLocationConfirmPage
            let vc = segue.destination as! setLocationConfirmPage
            vc.lat = self.selectedLat
            vc.lng = self.selectedLng
            vc.locName = self.selectedLocName
            vc.locDetail = self.selectedLocDetail
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

extension setLocationPage: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
//        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        self.selectedLng = place.coordinate.longitude
        self.selectedLat = place.coordinate.latitude
        self.selectedLocName = place.name
        self.selectedLocDetail = place.formattedAddress
        
        self.performSegue(withIdentifier: "toConfirm", sender: nil)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
