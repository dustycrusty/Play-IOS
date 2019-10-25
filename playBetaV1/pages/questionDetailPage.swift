//
//  questionDetailPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 6. 3..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

class questionDetailPage: UIViewController {
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var message: UITextView!
    
    var questionObj:commonQuestion?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        questionTitle.text = (questionObj?.title)!
        type.text = (questionObj?.type)!
        message.text = (questionObj?.message)!
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
