//
//  FavoritesTableViewCell.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 6/4/18.
//  Copyright © 2018 Matthew Shaver. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
	
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var colorLabel: UILabel!
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

