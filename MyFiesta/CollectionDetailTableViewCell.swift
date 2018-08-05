//
//  CollectionDetailTableViewCell.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 11/16/17.
//  Copyright © 2017 Matthew Shaver. All rights reserved.
//

import UIKit

class CollectionDetailTableViewCell: UITableViewCell {
    
    //Create the necessary variables for both field and value.
    @IBOutlet var fieldLabel:UILabel!
    @IBOutlet var valueLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
