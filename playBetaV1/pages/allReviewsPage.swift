//
//  allReviewsPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 6. 3..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class allReviewsPage: UITableViewController {

    var store:Store?
    
    let itemsPerBatch = 15
    
    // Where to start fetching items (database OFFSET)
    var offset = 0
    
    // a flag for when all database items have already been loaded
    var reachedEndOfItems = false

    
    var review:[Review] = []
    
    fileprivate func getReviews() {
        let recentReviewsQuery = Database.database().reference().child("store/\((store?.type)!)/\((store?.storeid)!)/review")
        recentReviewsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                print("exists!")
            }
            else{
                print("doesnt exist")
            }
            guard let value = snapshot.value as? [String:Any] else { return }
            for x in value.values{
                do {
                    let reviewObject = try FirebaseDecoder().decode(Review.self, from: x)
                    
                    self.review.append(reviewObject)
                    print("appended")
                }
                catch let error {
                    print("errored")
                    print(error)
                }
            }
            self.tableView.reloadData()
            print("reloaded")
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.review.removeAll()
        let nib2 = UINib(nibName: "reviewCellWithReply", bundle: nil)
        self.tableView.register(nib2, forCellReuseIdentifier: "reviewCellWithReply")
        let nib = UINib(nibName: "reviewCellOriginal", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "reviewCellOriginal")
        
        getReviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return review.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.review.count - 1 {
            self.loadMore()
        }
     
     if review[indexPath.row].response != nil{
     let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCellWithReply", for: indexPath) as! reviewCellWithReply
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
     cell.message.text = review[indexPath.row].message
     cell.rating.rating = review[indexPath.row].rating
     
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
     
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func loadMore() {
        
        // don't bother doing another db query if already have everything
        guard !self.reachedEndOfItems else {
            return
        }
        
        // query the db on a background thread
        DispatchQueue.global(qos: .background).async {
            
            // determine the range of data items to fetch
            var thisBatchOfItems: [Review]?
            let start = self.offset
            let end = self.offset + self.itemsPerBatch
            
            // query the database
           
            Database.database().reference().child("store/\((self.store?.type)!)/\((self.store?.storeid)!)/review").queryStarting(atValue: start).queryEnding(atValue: end).observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.exists(){
                    print("exists!")
                }
                else{
                    print("doesnt exist")
                }
                guard let value = snapshot.value as? [String:Any] else { return }
                for x in value.values{
                    do {
                        let reviewObject = try FirebaseDecoder().decode(Review.self, from: x)
                        
                        self.review.append(reviewObject)
                        print("appended")
                    }
                    catch let error {
                        print("errored")
                        print(error)
                    }
                }
            })
                // SQLite.swift wrapper
               
            
            
            // update UITableView with new batch of items on main thread after query finishes
            DispatchQueue.main.async {
                
                if let newItems = thisBatchOfItems {
                    
                    // append the new items to the data source for the table view
                    self.review.append(contentsOf: newItems)
                    
                    // reload the table view
                    self.tableView.reloadData()
                    
                    // check if this was the last of the data
                    if newItems.count < self.itemsPerBatch {
                        self.reachedEndOfItems = true
                        print("reached end of data. Batch count: \(newItems.count)")
                    }
                    
                    // reset the offset for the next data query
                    self.offset += self.itemsPerBatch
                }
                
            }
        }
    }
}
