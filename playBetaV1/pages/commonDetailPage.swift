//
//  commonDetailPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 12..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import FirebaseStorageUI
import Firebase

class commonDetailPage: UIViewController {

    var obj:Common?
    
    @IBOutlet weak var commonDetailTitle: UILabel!
    @IBOutlet weak var commonDetailmage: UIImageView!
    
    @IBOutlet weak var commonDetailMessage: UILabel!
    @IBOutlet weak var commonDetailLength: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Storage.storage().reference().child((obj?.commonMainImageURL)!)
        commonDetailTitle.text = obj?.title
        let url = URL(string: (obj?.commonMainImageURL)!)
        commonDetailmage.sd_setImage(with: url, placeholderImage: UIImage())
        commonDetailMessage.text = obj?.message
        commonDetailLength.text = "\( obj!.fromTime)~\(obj!.toTime)"
        // Doany additional setup after loading the view.
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
