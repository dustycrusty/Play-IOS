//
//  regulationPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 6..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

class regulationPage: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var text:String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = " "
        self.textView.text = text
        self.textView.layer.cornerRadius = 8
        
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
