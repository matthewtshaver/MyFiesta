//
//  FavoritesTableViewController.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 6/4/18.
//  Copyright © 2018 Matthew Shaver. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
	
	var collections:[CollectionMO] = []
	
	
	var fetchResultController: NSFetchedResultsController<CollectionMO>!

    override func viewDidLoad() {
        super.viewDidLoad()
	
	//Fetch the data.
	let fetchRequest: NSFetchRequest<CollectionMO> = CollectionMO.fetchRequest()
	let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
	fetchRequest.predicate = NSPredicate(format: "wish == TRUE" )
	fetchRequest.sortDescriptors = [sortDescriptor]
	if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
		let context = appDelegate.persistentContainer.viewContext
		fetchResultController = NSFetchedResultsController(fetchRequest:
			fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
		fetchResultController.delegate = self
		do {
			try fetchResultController.performFetch()
			if let fetchedObjects = fetchResultController.fetchedObjects {
				collections = fetchedObjects
			}
		} catch {
			print(error)
		}
	}
	
	//Search bar
//	searchController = UISearchController(searchResultsController: nil)
//	tableView.tableHeaderView = searchController.searchBar
//	//searchController.searchResultsUpdater = self
//	searchController.dimsBackgroundDuringPresentation = false
//	searchController.searchBar.placeholder = "Search your wish list..."
//	searchController.searchBar.tintColor = UIColor.white
//	searchController.searchBar.barTintColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
	

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//This method will be called every time a table row is displayed to the user.
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellIdentifier = "Cell"
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoritesTableViewCell
		
		//If a search is active, display the results.
		//let friend = (searchController.isActive) ? searchResults[indexPath.row] : friends[indexPath.row]
		
		// Reconfigure the cell.
		cell.nameLabel.text = collections[indexPath.row].name
		cell.colorLabel.text = collections[indexPath.row].color

		
		//NEW! CoreData MOD for the photos
		if let collectionImage = collections[indexPath.row].photo {
			cell.thumbnailImageView.image = UIImage(data: collectionImage as Data)
		}
		return cell
	}
	
	//Share Action and Delete Action Swipe
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete", comment: "Delete")) { (action, sourceView, completionHandler) in
			// Delete the row from the data store
			if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
				let context = appDelegate.persistentContainer.viewContext
				let restaurantToDelete = self.fetchResultController.object(at: indexPath)
				context.delete(restaurantToDelete)
				
				appDelegate.saveContext()
			}
			
			// Call completion handler with true to indicate
			completionHandler(true)
		}
		
		let shareAction = UIContextualAction(style: .normal, title: NSLocalizedString("Share", comment: "Share")) { (action, sourceView, completionHandler) in
			let defaultText = "I'm sharing my wished item " + self.collections[indexPath.row].name!
			
			let activityController: UIActivityViewController
			
			if let collectionImage = self.collections[indexPath.row].photo,
				let imageToShare = UIImage(data: collectionImage as Data) {
				activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
			} else  {
				activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
			}
			
			if let popoverController = activityController.popoverPresentationController {
				if let cell = tableView.cellForRow(at: indexPath) {
					popoverController.sourceView = cell
					popoverController.sourceRect = cell.bounds
				}
			}
			
			self.present(activityController, animated: true, completion: nil)
			completionHandler(true)
		}
		
		// Customize the action buttons
		deleteAction.backgroundColor = UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0)
		deleteAction.image = UIImage(named: "delete")
		shareAction.backgroundColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
		shareAction.image = UIImage(named: "share")
		
		let swipeConfiguration = UISwipeActionsConfiguration(actions: [shareAction, deleteAction])
		
		return swipeConfiguration
	}
	
		//Table removal
		override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
			if editingStyle == .delete {
				// Delete the row from the data source
				collections.remove(at: indexPath.row)
			}
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	

	
	override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let moveToCollection = UIContextualAction(style: .normal, title: NSLocalizedString("Add to Collection", comment: "Add to My Collection")) { (action, sourceView, completionHandler) in
			let cell = tableView.cellForRow(at: indexPath) as! FavoritesTableViewCell
			self.collections[indexPath.row].wish = (self.collections[indexPath.row].wish) ? false : true
			//cell.heartImageView.isHidden = self.collections[indexPath.row].wish ? false : true
			
			completionHandler(true)
		}
		
		// Customize the action button
		moveToCollection.backgroundColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
		moveToCollection.image = self.collections[indexPath.row].wish ? UIImage(named: "movecollection") : UIImage(named: "movecollection")
		
		let swipeConfiguration = UISwipeActionsConfiguration(actions: [moveToCollection])
		
		return swipeConfiguration
	}

	
	
	

    // MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		
	return collections.count
	}
	
	//NEW! CD MOD //This method changes the content as necessary and alters the table in SQL Lite.
	func controllerWillChangeContent(_ controller:
		NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.beginUpdates()
	}
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
				 didChange anObject: Any, at indexPath: IndexPath?, for type:
		NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		switch type {
			
		case .insert:
			if let newIndexPath = newIndexPath {
				tableView.insertRows(at: [newIndexPath], with: .fade)
			}
		case .delete:
			if let indexPath = indexPath {
				tableView.deleteRows(at: [indexPath], with: .fade)
			}
		case .update:
			if let indexPath = indexPath {
				tableView.reloadRows(at: [indexPath], with: .fade)
			} default:
				tableView.reloadData()
		}
		
		if let fetchedObjects = controller.fetchedObjects {
			collections = fetchedObjects as! [CollectionMO]
		}
	}
	func controllerDidChangeContent(_ controller:
		NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.endUpdates()
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

