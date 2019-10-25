//
//  reviewCellWithReply.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 18..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

class reviewCellWithReply: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var uploadedTime: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var ownerView: UIImageView!
    
    @IBOutlet weak var ownerUploadedTime: UILabel!
    @IBOutlet weak var ownerMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ownerView.image = #imageLiteral(resourceName: "bubble")
        self.rating.isUserInteractionEnabled = false
        self.rating.backgroundColor = UIColor.clear
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
