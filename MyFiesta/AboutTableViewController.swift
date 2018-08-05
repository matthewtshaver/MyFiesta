//
//  AboutTableViewController.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 5/17/18.
//  Copyright © 2018 Matthew Shaver. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
	
	//Section for data in the About
	var sectionTitles = ["About VistosoPro", "Feedback"]
	var sectionContent = [["Version 1.0", "© NEO Media", "Matthew T. Shaver • Developer & Designer"],
					  ["Facebook", "Apple App Store"]]
	
	//Get these links working before pub.
	var links = ["https://facebook.com/TBA", "https://AppleAppStore.TBA"]

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.tableFooterView = UIView(frame: CGRect.zero)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return sectionTitles.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return sectionContent[section].count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sectionTitles[section]
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		// Configure the cell...
		cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
		// Leave us feedback section
		case 0:
			if indexPath.row == 0 {
				if let url = URL(string: "http://www.apple.com/itunes/charts/paid-apps/") {
					UIApplication.shared.open(url)
				}
			} else if indexPath.row == 1 {
				performSegue(withIdentifier: "showWebView", sender: self)
			}
			
		// Follow us section
		case 1:
			if let url = URL(string: links[indexPath.row]) {
				let safariController = SFSafariViewController(url: url)
				present(safariController, animated: true, completion: nil)
			}
			
		default:
			break
		}
		
		tableView.deselectRow(at: indexPath, animated: false)
	}


}
