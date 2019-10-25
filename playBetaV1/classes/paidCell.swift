//
//  paidCell.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 28..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

class paidCell: UITableViewCell {

    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var currentEvent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
