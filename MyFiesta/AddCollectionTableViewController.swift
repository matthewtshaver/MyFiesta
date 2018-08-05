//
//  AddCollectionTableViewController.swift
//  VistosoPro
//
//  Created by Matthew Shaver on 11/19/17.
//  Copyright © 2017 Matthew Shaver. All rights reserved.
//

import UIKit
import CoreData

class AddCollectionTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var collections:CollectionMO!
	
	//Varliables for both wish list and retired colors.
	var wish = false
	var retired = false
	
	//Variable for the color in the picker
	var selectedColor = ""

    //Color Picker
    @IBOutlet var pickerView: UIPickerView!

	//Variables for the data entry section.
	@IBOutlet var photoImageView: UIImageView!
    @IBOutlet var brandTextField:UITextField!
    @IBOutlet var nameTextField:UITextField!
    //@IBOutlet var colorTextField:UITextField!
    @IBOutlet var othercolorTextField:UITextField!
    @IBOutlet var sourceTextField:UITextField!
    @IBOutlet var yearTextField:UITextField!
    @IBOutlet var msrpTextField:UITextField!
    @IBOutlet var actualpriceTextField:UITextField!
    @IBOutlet var conditionTextField:UITextField!
    @IBOutlet var quantityTextField:UITextField!
	@IBOutlet var wishYesButton: UIButton!
	@IBOutlet var wishNoButton: UIButton!
	@IBOutlet var retiredYesButton: UIButton!
	@IBOutlet var retiredNoButton: UIButton!
    @IBOutlet var sizeTextField:UITextField!
    @IBOutlet var notesTextField:UITextView!
    
    // Input data into the color array:
	// Last update made to accomodate Mulberry - 5.6.18
    let colors = ["Choose color", "Vintage Antique Gold", "Vintage Blue", "Vintage Chartreuse", "Vintage Forrest Green", "Vintage Gray", "Vintage Green (Light)", "Vintage Mango Red", "Vintage Medium Green", "Vintage Old Ivory", "Vintage Red", "Vintage Rose", "Vintage Turf Green", "Vintage Turquoise", "Vintage Yellow"," --- ", "Apricot", "Black", "Chartreuse", "Chocolate", "Cinnebar", "Claret ", "Cobalt Blue", "Daffodil", "Evergreen", "Flamingo", "Heather", "Ivory", "Juniper", "Lapis", "Lemongrass", "Lilac", "Marigold", "Mulberry", "Paprika", "Peacock", "Pearl Gray", "Periwinkle Blue", "Persimmon", "Plum", "Poppy", "Rose", "Sage", "Sapphire", "Scarlet", "Sea Mist Green", "Shamrock", "Slate", "Sunflower", "Tangerine", "Turquoise", "White", "Yellow"]

	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		return "\(colors[row])"
	}
	
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return colors.count
	}
	
	// Catpure the picker view selection
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedColor = colors[row]
		
		// This method is triggered whenever the user makes a change to the picker selection.
		// The parameter named row and component represents what was selected.
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		// Connect data:
		self.pickerView.delegate = self
		self.pickerView.dataSource = self
		
		//Setting the default value
		selectedColor = colors[0] // setting the default value

	}

    
    //Photo access to iOS photo library.
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			
			let photoSourceRequestController = UIAlertController(title: "", message: NSLocalizedString("Choose your photo source", comment: "Choose your photo source"), preferredStyle: .actionSheet)
			
			let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: "Camera"), style: .default, handler: { (action) in
				if UIImagePickerController.isSourceTypeAvailable(.camera) {
					let imagePicker = UIImagePickerController()
					imagePicker.delegate = self
					imagePicker.allowsEditing = true
					imagePicker.sourceType = .camera
					
					
					self.present(imagePicker, animated: true, completion: nil)
				}
			})
			
			let photoLibraryAction = UIAlertAction(title: NSLocalizedString("Photo library", comment: "Photo library"), style: .default, handler: { (action) in
				if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
					let imagePicker = UIImagePickerController()
					imagePicker.delegate = self
					imagePicker.allowsEditing = false
					imagePicker.sourceType = .photoLibrary
					
					self.present(imagePicker, animated: true, completion: nil)
				}
			})
			
			photoSourceRequestController.addAction(cameraAction)
			photoSourceRequestController.addAction(photoLibraryAction)
			
			present(photoSourceRequestController, animated: true, completion: nil)
			
		}
	}
	
	
	// MARK: - UIImagePickerControllerDelegate method
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			photoImageView.image = selectedImage
			photoImageView.contentMode = .scaleAspectFill
			photoImageView.clipsToBounds = true
		}
		
		let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
		leadingConstraint.isActive = true

		let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
		trailingConstraint.isActive = true

		let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
		topConstraint.isActive = true

		let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
		bottomConstraint.isActive = true
	
		dismiss(animated: true, completion: nil)
	}
	
	

	
	
	
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
//        IndexPath) {
//        if indexPath.row == 0 {
//            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//                let imagePicker = UIImagePickerController()
//                imagePicker.allowsEditing = false
//                imagePicker.sourceType = .photoLibrary
//                imagePicker.delegate = self
//                present(imagePicker, animated: true, completion: nil)
//            }
//        }
//    }
//
//    //This method chooses the image, places it into the table UIImageView.
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String : Any])
//    {
//        if let selectedImage = info[UIImagePickerControllerOriginalImage] as?
//            UIImage {
//            photoImageView.image = selectedImage
//            photoImageView.contentMode = .scaleAspectFill
//            photoImageView.clipsToBounds = true
//        }
//
//	let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
//	leadingConstraint.isActive = true
//
//	let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
//	trailingConstraint.isActive = true
//
//	let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
//	topConstraint.isActive = true
//
//	let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
//	bottomConstraint.isActive = true
//
//        dismiss(animated: true, completion: nil)
//    }

    
    //NEW CD MOD!  SAVE INFO TO DATA STRUCTURE
    @IBAction func save(sender: AnyObject) {
	
	
//	if brandTextField.text != "e.g. Fiesta" {
//		let alertController = UIAlertController(title: "CHANGE", message: "OH Good", preferredStyle: .alert)
//
//		let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//		alertController.addAction(alertAction)
//		present(alertController, animated: true, completion: nil)
//
//	}
	

	//Console Output
        print("Brand: \(brandTextField.text ?? "") ")
        print("Name: \(nameTextField.text ?? "")")
        //print("Color: \(selectedColor.colors ?? "")")
        print("Other Color: \(othercolorTextField.text ?? "")")
        print("Sourced From: \(sourceTextField.text ?? "")")
        print("Year Purchased: \(yearTextField.text ?? "")")
        print("MSRP: \(msrpTextField.text ?? "")")
        print("Actual Price: \(actualpriceTextField.text ?? "")")
        print("Condition: \(conditionTextField.text ?? "")")
        print("Quantity: \(quantityTextField.text ?? "")")
        print("Size: \(sizeTextField.text ?? "")")
        
        //SAVE!  FOR BOOLEAN PURPOSES!
        print("Item on wish list: \(wish)")
		print("Item retired: \(retired)")
        
        
        print("Notes: \(notesTextField.text ?? "")")
        

        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
		collections = CollectionMO(context: appDelegate.persistentContainer.viewContext)
		collections.brand = brandTextField.text
		collections.name = nameTextField.text
            collections.color = selectedColor
            collections.othercolor = othercolorTextField.text
            collections.sourcefrom = sourceTextField.text
            collections.yearprocured = yearTextField.text
            collections.msrp = msrpTextField.text
            collections.actualprice = actualpriceTextField.text
            collections.condition = conditionTextField.text
            collections.quantity = quantityTextField.text
		collections.wish = wish
		collections.retired = retired
            collections.size = sizeTextField.text
            collections.notes = notesTextField.text

		//Save the photo image.
		if let collectionImage = photoImageView.image {
			if let imageData = UIImageJPEGRepresentation(collectionImage, 0.75) {
				collections.photo = NSData(data: imageData) as Data
				
                }
            }
		print("Saving data to context ...")
            appDelegate.saveContext()

        }

	dismiss(animated: true, completion: nil)

}

	
	//Toggle the wish list button and color.
	@IBAction func toggleWishListButton(sender: UIButton) {
		// Yes button clicked
		if sender == wishYesButton {
			wish = true
			
			// Change the backgroundColor property of yesButton to green
			wishYesButton.backgroundColor = UIColor(red: 53.0/255.0, green: 129.0/255.0, blue: 34.0/255.0, alpha: 1.0)
			
			// Change the backgroundColor property of noButton to gray
			wishNoButton.backgroundColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
			
		} else if sender == wishNoButton {
			wish = false
			
			// Change the backgroundColor property of yesButton to gray
			wishYesButton.backgroundColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
			
			// Change the backgroundColor property of noButton to red
			wishNoButton.backgroundColor = UIColor(red: 228/255.0, green: 89.0/255.0, blue: 76.0/255.0, alpha: 1.0)
		}
	}
	
	
	//Toggle the retired  button and color.
	@IBAction func toggleRetiredButton(sender: UIButton) {
		// Yes button clicked
		if sender == retiredYesButton {
			retired = true
			
			// Change the backgroundColor property of yesButton to green
			retiredYesButton.backgroundColor = UIColor(red: 53.0/255.0, green: 129.0/255.0, blue: 34.0/255.0, alpha: 1.0)
			
			// Change the backgroundColor property of noButton to gray
			retiredNoButton.backgroundColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
			
		} else if sender == retiredNoButton {
			retired = false
			
			// Change the backgroundColor property of yesButton to gray
			retiredYesButton.backgroundColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
			
			// Change the backgroundColor property of noButton to red
			retiredNoButton.backgroundColor = UIColor(red: 228/255.0, green: 89.0/255.0, blue: 76.0/255.0, alpha: 1.0)
		}
	}
	
	
	
	

}
