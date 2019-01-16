//
//  PhotoDetailViewController.swift
//  PhotoJornal
//
//  Created by Jason on 1/14/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var PostText: UITextView!
    @IBOutlet weak var Picture: UIImageView!
    private var imageSelecter: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setupImagePickerViewController()
        // Do any additional setup after loading the view.
    }
    func savePost(image: UIImage, text: String, date: String){
        
        if let imageSave = image.jpegData(compressionQuality: 0.5){
            
            let userEntry = PictureModel.init(createdAt: "no date", imageData: imageSave, description: PostText.text)
            
            PhotoHelpers.saveTheEntry(typeOfFileSaving: userEntry)
        }
    }
    private func showImageSelect (){
        present(imageSelecter, animated: true, completion: nil)
    }
    @IBAction func Dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SavePost(_ sender: UIBarButtonItem) {
        savePost(image: Picture.image ?? UIImage.init(contentsOfFile: "placeholder")!, text: PostText?.text ?? "" , date: "no date")
        
        // i do not know if this works twice
    }
    
    
    @IBAction func PhotoAlbum(_ sender: UIBarButtonItem) {
       imageSelecter.sourceType = .photoLibrary
        showImageSelect()
    }
    
    @IBAction func CameraButton(_ sender: UIBarButtonItem) {
    }
    
    private func setupImagePickerViewController(){
        imageSelecter = UIImagePickerController()
        imageSelecter.delegate = self
        
//        if !UIImagePickerController.isSourceTypeAvailable(.camera){
//            cameraButtonOutlet.isEnabled = false
//        }
    }
    
}

extension PhotoDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            Picture.image = image
//            savePhotoJornal(image: image)
        }
        else{
            print("original Image is nil")
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
}
