//
//  PhotoDetailViewController.swift
//  PhotoJornal
//
//  Created by Jason on 1/14/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var savepostoutlet: UIBarButtonItem!
    @IBOutlet weak var PostText: UITextView!
    @IBOutlet weak var Picture: UIImageView!
    private var imageSelecter: UIImagePickerController!
    
     var photos: [PictureModel]!
    
    public var isEditingPictureModel = false
    public var photo: PictureModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()
        // Do any additional setup after loading the view.
        
        
        // if editing
        if isEditingPictureModel {
            DispatchQueue.global().async {
                let image = UIImage(data: self.photo.imageData)
                DispatchQueue.main.async {
                    self.Picture.image = image
                }
            }
            PostText.text = photo.description
        }
    }

    func savePost(image: UIImage, text: String, date: String){
        
        if let imageSave = image.jpegData(compressionQuality: 0.5){
            let id = UUID().uuidString // creates a unique id
        
            let userEntry = PictureModel.init(createdAt: PhotoHelpers.time(), imageData: imageSave, description: PostText.text, id: id)
            PhotoHelpers.appening(type:userEntry)
            
            
        }
    }
    private func showImageSelect (){
        present(imageSelecter, animated: true, completion: nil)
    }
    @IBAction func Dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SavePost(_ sender: UIBarButtonItem) {
        
        
        
        if !isEditingPictureModel/*savepostoutlet.tag == 0*/{
        savePost(image: Picture.image ?? UIImage.init(contentsOfFile: "placeholder")!, text: PostText?.text ?? "" , date: PhotoHelpers.time())
        dismiss(animated: true, completion: nil)

    }
        else{
            guard let updatedDescription = PostText.text else {
                print("text is nil")
                return
            }
            let updatedPhoto = PictureModel.init(createdAt: PhotoHelpers.time(), imageData: photo.imageData, description: updatedDescription, id: photo.id)
            PhotoHelpers.replacing(post: updatedPhoto)
            dismiss(animated: true, completion: nil)
            

        }
        
        
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
