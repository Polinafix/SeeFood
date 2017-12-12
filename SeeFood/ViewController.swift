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
    
    func detect(image: CIImage) {
        //create an object called 'model' using the VNCoreModel container
        //create a new object of Inceptionv3 and get its model property
        //This model will be used to classify our image
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML Model failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process the image")
            }
            
            print(result)
        }
        //specify which image u want to specify
        let handler = VNImageRequestHandler(ciImage: image)
        //perform the request
        do {
           try handler.perform([request])
        }catch {
            print(error)
        }
        
    }
    //after the image was picked
    //picker = imagePicker
    //inside the info parameter is contained the image that the user picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //1.check that the image was indeed picked - use the key for the original image
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //set the image view to the image that was picked
            imageView.image = userPickedImage
            
            //convert it into a special type of image recognizable by CoreML
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CIImage")
            }
            detect(image: ciImage)
            
            
        }
        
        //dismiss imagePicker
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    //method for processing the ciimage
    
    

}

