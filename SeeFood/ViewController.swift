//
//  ViewController.swift
//  SeeFood
//
//  Created by Polina Fiksson on 12/12/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    //new object
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    //after the image was picked
    //picker = imagePicker
    //inside the info parameter is contained the image that the user picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //1.check that the image was indeed picked - use the key for the original image
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //set the image view to the image that was picked
            imageView.image = userPickedImage
        }
        
        //dismiss imagePicker
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    

}

