//
//  commonQuestionsPage.swift
//  
//
//  Created by 이승윤 on 2018. 5. 20..
//

import UIKit
import Firebase
import CodableFirebase

class commonQuestionsPage: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var questionData:[commonQuestion]? = nil
    let searchController = UISearchController(searchResultsController: nil)

    var filteredQuestion = [commonQuestion]()
    //CHANGE TO QUESTION OBJECT
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getQuestions()
        self.navigationController?.navigationBar.tintColor = UIColor.white

    }
    
    func getQuestions(){
        Database.database().reference().child("commonQuestion").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                let model = try FirebaseDecoder().decode([String:commonQuestion].self, from: value)
                
                self.questionData = Array(model.values)
                self.tableView.reloadData()
                print(model)
            } catch let error {
                print(error)
            }
        })
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredQuestion = questionData!.filter({( question : commonQuestion) -> Bool in
            let doesCategoryMatch = (scope == "All") || (question.type == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && question.title.lowercased().contains(searchText.lowercased())
            }
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
            self.hideKeyboardWhenTappedAround() 
            searchController.searchBar.scopeButtonTitles = ["전체", "로그인", "결제", "서비스"]

            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            
            
                searchBar = searchController.searchBar
                searchBar.delegate = self
            searchController.searchBar.placeholder = "검색"
            
            definesPresentationContext = true
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
        if questionData != nil
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "정보가 없습니다!"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if questionData == nil{
            return 0
        }
        
        if isFiltering() {
            return filteredQuestion.count
        }
        
        return questionData!.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cqCell", for: indexPath)
        let categoryLabel = cell.viewWithTag(1) as! UILabel
        let questionLabel = cell.viewWithTag(2) as! UILabel
        let question: commonQuestion
        if isFiltering() {
            question = filteredQuestion[indexPath.row]
        } else {
            question = questionData![indexPath.row]
        }
        categoryLabel.text = question.type
        questionLabel.text = question.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionObj = questionData![indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "questionDetailPage") as? questionDetailPage
        //PASS DATA
        vc?.questionObj = questionObj
        self.navigationController?.pushViewController(vc!, animated: true)
        
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

extension commonQuestionsPage: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)

    }
}

extension commonQuestionsPage: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}


