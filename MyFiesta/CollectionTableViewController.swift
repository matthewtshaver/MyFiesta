//
//  CollectionTableViewController.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 11/16/17.
//  Copyright © 2017 Matthew Shaver. All rights reserved.
//

import UIKit
import CoreData

class CollectionTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
	
	var collections:[CollectionMO] = []
	
	var fetchResultController: NSFetchedResultsController<CollectionMO>!
	
	var searchController:UISearchController!
	
	var searchResults:[CollectionMO] = []
	

	//Cancel Function to unwind back to collectionView
	@IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		

		
		//Add the search controller system into the view to load on screen.
		searchController = UISearchController(searchResultsController: nil)
		tableView.tableHeaderView = searchController.searchBar
		
		//Fetch the data.
		let fetchRequest: NSFetchRequest<CollectionMO> = CollectionMO.fetchRequest()
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		fetchRequest.predicate = NSPredicate(format: "wish == FALSE" )
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
		searchController = UISearchController(searchResultsController: nil)
		tableView.tableHeaderView = searchController.searchBar
		//searchController.searchResultsUpdater = self
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search your collection..."
		searchController.searchBar.tintColor = UIColor.white
		searchController.searchBar.barTintColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
		
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
			let defaultText = "I'm sharing my collection " + self.collections[indexPath.row].name!
			
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
	
	//Move item to the Wish List
	override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let moveToWishList = UIContextualAction(style: .normal, title: NSLocalizedString("Add to Wish List", comment: "Add to Wish List")) { (action, sourceView, completionHandler) in
			let cell = tableView.cellForRow(at: indexPath) as! CollectionTableViewCell
			self.collections[indexPath.row].wish = (self.collections[indexPath.row].wish) ? false : true
			//cell.heartImageView.isHidden = self.collections[indexPath.row].wish ? false : true
			
			completionHandler(true)
		}
		
		// Customize the action button
		moveToWishList.backgroundColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
		moveToWishList.image = self.collections[indexPath.row].wish ? UIImage(named: "undo") : UIImage(named: "addwish")
		
		let swipeConfiguration = UISwipeActionsConfiguration(actions: [moveToWishList])
		
		return swipeConfiguration
	}
	
	
	
//	//DeleteAction & ShareAction
//	override func tableView(_ tableView: UITableView, editActionsForRowAt
//		indexPath: IndexPath) -> [UITableViewRowAction]? {
//		// Social Sharing Button
//		let shareAction = UITableViewRowAction(style:
//			UITableViewRowActionStyle.default, title: "Share", handler: { (action,
//				indexPath) -> Void in
//
//				//Copies/pasts text into social app
//				//let defaultText = "I'm hanging with " +
//
//				//NEW! CD MOD
//				let defaultText = "I'm sharing my collection " +
//					self.collections[indexPath.row].name!
//
//				//Accesses the name of the friend
//				//self.friends[indexPath.row].name
//
//				//If friend has an avatar, it will move that into the social app.
//				//if let imageToShare = UIImage(named:
//				//self.friends[indexPath.row].face) {
//
//				//NEW! CD MOD
//				if let photoImage = self.collections[indexPath.row].photo,
//					let imageToShare = UIImage(data: photoImage as Data) {
//
//
//
//					//Execute the UIAlertDialogSheet with text and image to share.
//					let activityController = UIActivityViewController(activityItems:
//						[defaultText, imageToShare], applicationActivities: nil)
//					self.present(activityController, animated: true, completion: nil)
//				}
//		})
//
//
//		// Delete button with the word Delete in the button.
//		let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
//
//			if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
//				let context = appDelegate.persistentContainer.viewContext
//				let friendToDelete = self.fetchResultController.object(at: indexPath)
//				context.delete(friendToDelete)
//
//				appDelegate.saveContext()
//			}
//
//		})
//
//		//Customize the colors of the share/delete buttons.  Red is default.
//		shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0,blue: 99.0/255.0, alpha: 1.0)
//		deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0,blue: 203.0/255.0, alpha: 1.0)
//		deleteAction.image = UIImage(named: "delete")
//
//		//Execute the deleteAtion and shareAction methods
//		return [deleteAction, shareAction]
//	}
//
	//Table removal
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			collections.remove(at: indexPath.row)
		}
		tableView.deleteRows(at: [indexPath], with: .fade)
	}
	
	//This method will be called every time a table row is displayed to the user.
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellIdentifier = "Cell"
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CollectionTableViewCell


		// Must reconfigure the cell.
		cell.brandLabel.text = collections[indexPath.row].brand
		cell.nameLabel.text = collections[indexPath.row].name



		//NEW! CD MOD
		if let collectionImage = collections[indexPath.row].photo {
			cell.thumbnailImageView.image = UIImage(data: collectionImage as Data)
		}
		return cell


	}


	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		 //Dispose of any resources that can be recreated.
	}
	
	 //MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		 //#warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		 //#warning Incomplete implementation, return the number of rows
		if searchController.isActive {
			return searchResults.count
		} else {
			return collections.count
		}
	}
	
	
	//Execute the segue between this screen and the detail screen.
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		//ID the segue to move to the correct "screen".
		if segue.identifier == "showCollectionDetail" {
			//Capture the table cell on 'tap'.
			if let indexPath = tableView.indexPathForSelectedRow {
				//Go to the detail view controller Swift file and connect information.
				let destinationController = segue.destination as! CollectionDetailViewController
				//Go to the above arrays and move the data into the detail view screen.
				destinationController.collections = (searchController.isActive) ? searchResults[indexPath.row] :
					collections[indexPath.row]
				
				//destinationController.friends = friends[indexPath.row]
				
			}
		}
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
	
	//Filter the search content for the searching system.
	func filterContent(for searchText: String) {
		searchResults = collections.filter({ (friend) -> Bool in
			if let name = friend.name{
				let isMatch = name.localizedCaseInsensitiveContains(searchText)
				return isMatch
			}
			return false
		})
	}
	
	//Update the search results.
	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text {
			filterContent(for: searchText)
			tableView.reloadData()
		}
	}
	
	//When search control is active, the cell is non-editable.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath:
		IndexPath) -> Bool {
		if searchController.isActive {
			return false
		} else {
			return true
		}
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

