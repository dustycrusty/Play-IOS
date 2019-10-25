//
//  Geofire.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 22..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import Foundation
import Firebase
import GeoFire
import CodableFirebase


public class Geofire_funcs: NSObject{
    

    typealias StoreClosure = (Store?) -> Void
    
    typealias storesClosure = ([Store]?) -> Void
    
    class func getFirebaseStore(key: String, completionHandler: @escaping StoreClosure){
        
        let ref: DatabaseReference! = Database.database().reference()
        ref.child("store").child("pccafe").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
            guard let value = snapshot.value else { return }
            do {
                let store = try FirebaseDecoder().decode(Store.self, from: value)
                print(store)
                completionHandler(store)
            } catch let error {
                
                print("ERRORED in pccafe", error)
            }
            }
            else{
                ref.child("store").child("poolcafe").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists(){
                        print("in poolcafe")
                        guard let value = snapshot.value else { return }
                        do {
                            let store = try FirebaseDecoder().decode(Store.self, from: value)
                            print(store)
                            completionHandler(store)
                        } catch let error {
                            print("ERRORED in poolcafe", error)
                            
                        }
                    }
                    else{
                ref.child("store").child("bowlingcafe").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                                guard let value = snapshot.value else { return }
                                do {
                                    let store = try FirebaseDecoder().decode(Store.self, from: value)
                                    print(store)
                                    completionHandler(store)
                                } catch let error {
                                    print("ERRORED in bowlingcafe", error)
                                }
                            
                        })
                    }
                })
                }
            })
    }
    
    typealias StoreArrayClosure = (Array<String>?) -> Void

    class func getKeys(coordinate: CLLocation, completionHandler: @escaping StoreArrayClosure){
        let geofireRef = Database.database().reference().child("geofire")
        let geoFire = GeoFire(firebaseRef: geofireRef)
        let geoquery = geoFire.query(at: coordinate, withRadius: 100)
        var storeTemp:[String] = []
        geoquery.observe(.keyEntered) { (key, location)  in
            print(key)
            storeTemp.append(key)
            
        }
        geoquery.observeReady {
            if storeTemp.isEmpty{
                print("STORE TEMP WAS EMPTY")
                completionHandler(nil)
            }
            else{
                completionHandler(storeTemp)
                
            }
        }
    }
    class func getNearByStores(coordinate: CLLocation, completionHandler:@escaping (storesClosure)){
        var keys = [String]()
        
        let geoFire = GeoFire(firebaseRef: Database.database().reference().child("geofire"))
        let myLoc = coordinate
        let circleQuery = geoFire.query(at: myLoc, withRadius: 0.6)
        
        // Populate list of keys
        circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!)  in
            print("Key '\(key)' entered the search area and is at location '\(location)'")
            keys.append(key)
        })
        
        // Do something with list of keys.
        circleQuery.observeReady({
            print("All initial data has been loaded and events have been fired!")
            if keys.count > 0 {
                print(keys)
                var stores:[Store] = []
                let dG = DispatchGroup()
                for x in keys{
                    print(x)
                    dG.enter()
                    getFirebaseStore(key: x, completionHandler: { (store) in
                        var mutStore:Store = store!
                        mutStore.setDistance(userloc: coordinate, loc: (CLLocation(latitude: (store?.lat)!, longitude:(store?.lng)!)))
                        stores.append(mutStore)
                        print("MUTSTORE")
                        dG.leave()
                    })
                    
                }
                
                dG.notify(queue: .main, execute: {
                    print("In notify")
                    completionHandler(stores)
                    
                })

            }
            else{
                let stores:[Store] = []
                completionHandler(stores)
            }
            
        })
}
    
    class func getListStores(coordinate: CLLocation, completionHandler: @escaping (storesClosure)){
        var keys = [String]()
        
        let geoFire = GeoFire(firebaseRef: Database.database().reference().child("geofire"))
        let myLoc = coordinate
        let circleQuery = geoFire.query(at: myLoc, withRadius: 5)
        
        // Populate list of keys
        circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!)  in
            print("Key '\(key)' entered the search area and is at location '\(location)'")
            keys.append(key)
        })
        
        // Do something with list of keys.
        circleQuery.observeReady({
            var stores:[Store] = []

            print("All initial data has been loaded and events have been fired!")
            if keys.count > 0 {
                print(keys)
                let dG = DispatchGroup()
                for x in keys{
                    print(x)
                    dG.enter()
                    getFirebaseStore(key: x, completionHandler: { (store) in
                        var mutStore:Store = store!
                        mutStore.setDistance(userloc: coordinate, loc: (CLLocation(latitude: (store?.lat)!, longitude:(store?.lng)!)))
                        stores.append(mutStore)
                        print("MUTSTORE")
                        dG.leave()
                    })
                    
                }
                dG.notify(queue: .main, execute: {
                    print("In notify")
                    completionHandler(stores)
                    
                    
                })
                
                
            }
            else{
                completionHandler(stores)
            }
            
            
        })
    }
}


