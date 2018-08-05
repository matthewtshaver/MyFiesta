//
//  ColorHistoryTableViewController.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 12/13/17.
//  Copyright © 2017 Matthew Shaver. All rights reserved.
//

import UIKit

class ColorHistoryTableViewController: UITableViewController {
	
	var colors:[Color] = [
		
		Color(name: "Vintage Antique Gold", year: "1969-1972", image: "vinantiquegold.jpg"),
		
		Color(name: "Vintage Blue ", year: "1936-1951", image: "vinblue.jpg"),
		
		Color(name: "Vintage Chartreuse", year: "1951-1959", image: "vinchartreuse.jpg"),
		
		Color(name: "Vintage Forest Green", year: "1951-1959", image: "vinforestgreen.jpg"),
		
		Color(name: "Vintage Gray", year: "1951-1959", image: "vingray.jpg"),
		
		Color(name: "Vintage Green (Light)", year: "1936-1951", image: "vingreenlight.jpg"),
		
		Color(name: "Vintage Mango Red", year: "1959-1972", image: "vinmangored.jpg"),
		
		Color(name: "Vintage Medium Green", year: "1959-1969", image: "vinmediumgreen.jpg"),
		
		Color(name: "Vintage Old Ivory", year: "1936-1951", image: "vinivory.jpg"),
		
		Color(name: "Vintage Red", year: "1936-1943", image: "vinred.jpg"),
		
		Color(name: "Vintage Rose", year: "1951-1959", image: "vinrose.jpg"),
		
		Color(name: "Vintage Turf Green", year: "1969-1972", image: "vinturfgreen.jpg"),
		
		Color(name: "Vintage Turquoise", year: "1937-1969", image: "vinturquiose.jpg"),
		
		Color(name: "Vintage Yellow", year: "1936-1969", image: "vinyellow.jpg"),
		
		Color(name: "Apricot", year: "1986-1998", image: "apricot.jpg"),
		
		Color(name: "Black", year: "1986 - 2015", image: "black.jpg"),
		
		Color(name: "Chartreuse", year: "1997-1999", image: "chartreuse.jpg"),
		
		Color(name: "Chocolate", year: "2008 - 2012", image: "chocolate.jpg"),
		
		Color(name: "Cinnebar", year: "2000 - 2010", image: "cinnebar.jpg"),
		
		Color(name: "Claret", year: "2016-2018", image: "claret.jpg"),
		
		Color(name: "Cobalt Blue", year: "1986-Present", image: "cobaltblue.jpg"),
		
		Color(name: "Daffodil", year: "2017-Present", image: "daffodil.jpg"),
		
		Color(name: "Evergreen", year: "2007-2009", image: "evergreen.jpg"),
		
		Color(name: "Flamingo", year: "2012-2014", image: "flamingo.jpg"),
		
		Color(name: "Heather", year: "2006-2009", image: "heather.jpg"),
		
		Color(name: "Ivory", year: "2008-Present", image: "ivory.jpg"),
		
		Color(name: "Juniper", year: "1999-2001", image: "juniper.jpg"),
		
		Color(name: "Lapis", year: "2013-Present", image: "lapis.jpg"),
		
		Color(name: "Lemongrass", year: "2009-Present", image: "lemongrass.jpg"),
		
		Color(name: "Lilac", year: "1993-1995", image: "lilac.jpg"),
		
		Color(name: "Marigold", year: "2011-2012", image: "marigold.jpg"),
		
		Color(name: "Mulberry", year: "2018-Present", image: "mulberry.jpg"),
		
		Color(name: "Paprika", year: "2010-2017", image: "paprika.jpg"),
		
		Color(name: "Peacock", year: "2005-2015", image: "peacock.jpg"),
		
		Color(name: "Pearl Gray", year: "1999-2001", image: "pearlgray.jpg"),
		
		Color(name: "Periwinkle Blue", year: "1989-2006", image: "periwinkle.jpg"),
		
		Color(name: "Persimmon", year: "1995-2008", image: "persimmon.jpg"),
		
		Color(name: "Plum", year: "2002-2016", image: "plum.jpg"),
		
		Color(name: "Poppy", year: "2014-Present", image: "poppy.jpg"),
		
		Color(name: "Rose", year: "1986-2005", image: "rose.jpg"),
		
		Color(name: "Sage", year: "2015-Present", image: "sage.jpg"),
		
		Color(name: "Sapphire", year: "1996-1997", image: "sapphire.jpg"),
		
		Color(name: "Scarlet", year: "2004-Present", image: "scarlet.jpg"),
		
		Color(name: "Sea Mist Green", year: "1991-2005", image: "seamistgreen.jpg"),
		
		Color(name: "Shamrock", year: "2002-Present", image: "shamrock.jpg"),
		
		Color(name: "Slate", year: "2015-Present", image: "slate.jpg"),
		
		Color(name: "Sunflower", year: "2001-Present", image: "sunflower.jpg"),
		
		Color(name: "Tangerine", year: "2003-2017", image: "tangerine.jpg"),
		
		Color(name: "Turquoise", year: "1988-Present", image: "turquoise.jpg"),
		
		Color(name: "White", year: "1986-Present", image: "white.jpg"),
		
		Color(name: "Yellow", year: "1986-2002", image: "yellow.jpg"),
	]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellIdentifier = "colorCell"
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ColorHistoryTableViewCell
		
		// Configure the cell...
		cell.colorNameLabel.text = colors[indexPath.row].name
		cell.thumbnailImageView.image = UIImage(named: colors[indexPath.row].image)
		cell.colorYearLabel.text = colors[indexPath.row].year
		
		return cell
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return colors.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
