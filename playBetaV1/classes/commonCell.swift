//
//  commonCell.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 12..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit

class commonCell: UITableViewCell {

    @IBOutlet weak var commonLength: UILabel!
    @IBOutlet weak var commonTitle: UILabel!
    @IBOutlet weak var commonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
