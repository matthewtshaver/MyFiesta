//
//  ColorHistoryTableViewCell.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 12/13/17.
//  Copyright © 2017 Matthew Shaver. All rights reserved.
//

import UIKit

class ColorHistoryTableViewCell: UITableViewCell {
	
	@IBOutlet var colorNameLabel: UILabel!
	@IBOutlet var colorYearLabel: UILabel!
	@IBOutlet var thumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
