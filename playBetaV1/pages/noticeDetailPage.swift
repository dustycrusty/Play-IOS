//
//  noticeDetailPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 12..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

class noticeDetailPage: UIViewController {
    
    var notice:Notice?

    @IBOutlet weak var noticeTitle: UILabel!
    @IBOutlet weak var noticeTime: UILabel!
    @IBOutlet weak var noticeMessage: UITextView!
   
    override func viewWillAppear(_ animated: Bool) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTitle.text = notice?.noticeTitle
        noticeMessage.text = notice?.noticeMessage
        noticeTime.text = notice?.time
        
//        noticeTime.text = notice?.time.replacingOccurrences(of: "_b", with: "\n")
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
