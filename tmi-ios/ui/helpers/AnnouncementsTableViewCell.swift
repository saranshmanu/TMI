//
//  AnnouncementsTableViewCell.swift
//  TMI
//
//  Created by Saransh Mittal on 15/12/17.
//  Copyright © 2017 Saransh Mittal. All rights reserved.
//

import UIKit

class AnnouncementsTableViewCell: UITableViewCell {

    @IBOutlet weak var messageTextField: UILabel!
    @IBOutlet weak var subjectTextField: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
