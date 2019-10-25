//
//  noticePage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 12..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class noticePage: UITableViewController {

    var objArray:[String:Notice]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfoFromNotice { (noticeObj) in
            self.objArray = noticeObj
            self.tableView.reloadData()
        }
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
        var numOfSections: Int = 0
        var x:[String:Notice] = [:]
        if objArray != nil
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "공지사항이 없습니다 ㅠ.ㅠ"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func getInfoFromNotice(completionHandler: @escaping ([String:Notice]) -> Void){
        Database.database().reference().child("notice").queryLimited(toFirst: 20).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value
            if snapshot.value != nil{
                print("in not nil")
            do {
                let model = try FirebaseDecoder().decode(([String:Notice]).self, from: value)
                print(model)
                completionHandler(model)
            } catch let error {
                print(error)
            }
            }
            else{
                print("in nil")
        }
        })
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if objArray?.count == nil || objArray?.count == 0 {
            return 0
        }
            // #warning Incomplete implementation, return the number of rows
        else{
            return (objArray?.count)!
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as! noticeCell
        let valArray = Array(objArray!.values) as [Notice]
        cell.noticeTitle.text = valArray[indexPath.row].noticeTitle
        cell.noticeType.text = valArray[indexPath.row].noticeType
        cell.time.text = valArray[indexPath.row].time

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "noticeDetailPage") as! noticeDetailPage
        let valArray = Array(objArray!.values) as [Notice]
        vc.notice = valArray[indexPath.row]
        vc.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.pushViewController(vc, animated: true)
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

}
