//
//  CollectionDetailViewController.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 11/16/17.
//  Copyright © 2017 Matthew Shaver. All rights reserved.
//

import UIKit

class CollectionDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var photoImageView:UIImageView!
    
    @IBOutlet var tableView:UITableView!
    
    var collections:CollectionMO!
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
	
	

        if let collectionImage = collections.photo {
            photoImageView.image = UIImage(data: collectionImage as Data)
        }
	
        //Change the background color of the table
        tableView.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue:
            0/255.0, alpha: 0.0)
        
        //Remove the separators of empty rows.
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Change the separator color.
        tableView.separatorColor = UIColor(red: 156.0/255.0, green: 132.0/255.0, blue:
            109.0/255.0, alpha: 0.0)
        
        //Enabling self sizing cells for our detail view:
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Place name in NavBar.
		let titleBrand = collections.brand
		let titleName = collections.name
		title = titleBrand! + " " + titleName!
		//title = collections.brand
	

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Populate the table with the information from the TableView of the previous screen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return 13 }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:
                indexPath) as! CollectionDetailTableViewCell
            // Configure the cell...
            switch indexPath.row {
            case 0:
                cell.fieldLabel.text = "Brand: "
                cell.valueLabel.text = collections.brand
            case 1:
                cell.fieldLabel.text = "Name: "
                cell.valueLabel.text = collections.name
            case 2:
                cell.fieldLabel.text = "Color: "
                cell.valueLabel.text = collections.color
            case 3:
                cell.fieldLabel.text = "Other Color: "
                cell.valueLabel.text = collections.othercolor
            case 4:
                cell.fieldLabel.text = "Purchased / gifted from: "
                cell.valueLabel.text = collections.sourcefrom
            case 5:
                cell.fieldLabel.text = "Date procured: "
                cell.valueLabel.text = collections.yearprocured
            case 6:
                cell.fieldLabel.text = "MSRP or Est. Value: "
                cell.valueLabel.text = collections.condition
            case 7:
                cell.fieldLabel.text = "Condition: "
                cell.valueLabel.text = collections.condition
            case 8:
                cell.fieldLabel.text = "Quantity "
                cell.valueLabel.text = collections.quantity
            case 9:
                cell.fieldLabel.text = "Size: "
                cell.valueLabel.text = collections.size
            case 10:
                cell.fieldLabel.text = "On my wish  list: "
			cell.valueLabel.text = (collections.wish) ? "Yes." : "No."
            case 11:
                cell.fieldLabel.text = "Item retired: "
			cell.valueLabel.text = (collections.retired) ? "Yes." : "No."
            case 12:
                cell.fieldLabel.text = "Personal Notes: "
                cell.valueLabel.text = collections.notes
            default:
                cell.fieldLabel.text = ""
                cell.valueLabel.text = ""
            }
            
            //Change color of the table with information.
            cell.backgroundColor = UIColor.clear
            
            //Show the table cell information to the user.
            return cell
            
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
