//
//  advDetail.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 7. 9..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

class advDetail: UIViewController {

    @IBOutlet weak var sv: UIScrollView!
    @IBOutlet weak var advView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       let newImage =  #imageLiteral(resourceName: "jehue").scaled(to: CGSize(width: self.view.frame.width, height:(self.view.frame.width)*6))
//        let newImage = #imageLiteral(resourceName: "jehue").scaled(to: CGSize(width: UIScreen.main.bounds.size.width, height:(UIScreen.main.bounds.size.width)*6), scalingMode: .aspectFit)
        let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        newImageView.image = newImage
        newImageView.contentMode = .top
        self.sv.addSubview(newImageView)
        sv.contentSize = newImage.size
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
