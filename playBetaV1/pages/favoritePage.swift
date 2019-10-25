//
//  favoritePage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 27..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class favoritePage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var handle:DatabaseHandle?
    
    var data:[[Store]] = [[],[],[]]
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationItem.title = "즐겨찾기"
        getInitialData()

    }
    
    fileprivate func updateData(_ snapshot: (DataSnapshot), sv:UIView) {
        
       
            let value = snapshot.value as? [String:Bool]
        let keyArray:[String] = Array((value!.keys))
        if keyArray.isEmpty == false{
            print("empty false")
            let dG = DispatchGroup()
            for x in keyArray{
                dG.enter()
                Geofire_funcs.getFirebaseStore(key: x, completionHandler: { (store) in
                    if store!.paid == "premium"{
                        self.data[0].append(store!)
                         dG.leave()
                    }
                    else if store!.paid == "paid"{
                        self.data[1].append(store!)
                         dG.leave()
                    }
                    else{
                        self.data[2].append(store!)
                         dG.leave()
                    }
                   
                })
            }
            dG.notify(queue: DispatchQueue.main, execute: {
                print("in notify")

                self.tableView.reloadData()
                UIViewController.removeSpinner(spinner: sv)
            })
        }
        else{
            print("empty true")
            UIViewController.removeSpinner(spinner: sv)
        }
    }
    
    func getInitialData(){
        let user = Auth.auth().currentUser
        Database.database().reference().child("user").child((user?.uid)!).child("favorite").observeSingleEvent(of: .value) { (snapshot) in
            self.data = [[], [], []]
            let sv = UIViewController.displaySpinner(onView: self.view)
            if snapshot.exists(){
            self.updateData(snapshot, sv: sv)
            }
            else{
                UIViewController.removeSpinner(spinner: sv)
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.view.setNeedsLayout()
        self.navigationController?.view.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data[section].count
    }
    
   
    
    
    
    fileprivate func sectionCheckReturnCell(_ section: Int, _ tableView: UITableView, _ dataForm: inout Array<Array<Store>>?, _ row: Int) -> UITableViewCell {
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "premiumCell") as! PremiumCell
            cell.address.text = dataForm![section][row].address
            cell.name.text = dataForm![section][row].name
            cell.rating.text = String(describing: dataForm![section][row].score)
            cell.rating.rating = dataForm![section][row].score
            return cell
        }
        else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "paidCell") as! paidCell
            cell.address.text = dataForm![section][row].address
            cell.title.text = dataForm![section][row].name
            cell.rating.text = String(describing: dataForm![section][row].score)
            
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
        dataForm = data
        return sectionCheckReturnCell(section, tableView, &dataForm, row)
    }
    func arrayCount(array:[[Store]]) -> Int{
        return array[0].count + array[1].count + array[2].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        print(arrayCount(array: data))
        if arrayCount(array: data) != 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 3
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "즐겨찾기한 피시방이 없어요ㅠ.ㅠ"
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
        dataForm = data
        
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
        self.navigationController?.navigationBar.tintColor = UIColor.white

        self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#F3713D")
        definesPresentationContext = true
        
        self.tableView.register(UINib(nibName: "paidCell", bundle: nil), forCellReuseIdentifier: "paidCell")
        self.tableView.register(UINib(nibName: "normalCell", bundle: nil), forCellReuseIdentifier: "normalCell")
        
       
        
        //        self.tableView.estimatedRowHeight = 44.0
        //        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        // Do any additional setup after loading the view.
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
