//
//  commonPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 12..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import FirebaseStorageUI

class commonPage: UITableViewController {
    
    var infoType:String?
    var objArray:[String:Common]?
    override func viewDidLoad() {
        super.viewDidLoad()
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text          = "로딩중"
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        tableView.backgroundView  = noDataLabel
        tableView.separatorStyle  = .none
        getInfoFromEventType(type: infoType!) { (dic) in
            self.objArray = dic
            self.tableView.reloadData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    func getInfoFromEventType(type: String, completionHandler: @escaping ([String:Common]) -> Void){
        Database.database().reference().child(type).queryLimited(toFirst: 20).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                let model = try FirebaseDecoder().decode(([String:Common]).self, from: value)
                print(model)
                completionHandler(model)
            } catch let error {
                print(error)
            }
        })
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "commonDetailPage") as! commonDetailPage
        vc.obj = Array(objArray!.values)[indexPath.row]
     self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var typeInK:String?
        if infoType == "event"{
            typeInK = "이벤트"
        }
        else{
            typeInK = "대회정보"
        }
        var numOfSections: Int = 0
        if objArray != nil
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "\(typeInK!)가 없습니다 ㅠ.ㅠ"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if objArray?.count == nil || objArray?.count == 0 {
            return 0
        }
        // #warning Incomplete implementation, return the number of rows
        else{
            return (objArray?.count)!
    }
}


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let values = Array(objArray!.values) as [Common]
        let cell = tableView.dequeueReusableCell(withIdentifier: "commonCell", for: indexPath) as! commonCell
        cell.commonTitle.text = values[indexPath.row].title
        cell.commonLength.text = "\(values[indexPath.row].fromTime) ~ \(values[indexPath.row].toTime)"
        
        
        //*****이미지삽입*****
        let storRef = Storage.storage().reference().child(values[indexPath.row].commonImageURL!)
        cell.commonImage.sd_setImage(with: URL(string: values[indexPath.row].commonImageURL!), placeholderImage: UIImage())

//        cell.commonImage.sd_setImage(with: storRef, placeholderImage: UIImage())

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
