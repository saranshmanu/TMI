//
//  AttandanceTableViewCell.swift
//  tmi-ios
//
//  Created by Saransh Mittal on 25/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import UIKit

class AttandanceTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
