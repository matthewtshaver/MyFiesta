//
//  CollectionTableViewCell.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 11/16/17.
//  Copyright © 2017 Matthew Shaver. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
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
