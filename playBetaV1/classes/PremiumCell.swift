//
//  PremiumCell.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 4. 28..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

class PremiumCell: UITableViewCell {

    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var storeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.rating.textColor = .white
        self.address.textColor = .white
        self.name.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
