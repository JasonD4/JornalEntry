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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func savePost(image: UIImage, text: UITextField, date: Date){
        if let imageSave = image.jpegData(compressionQuality: 0.5){
            let userEntry = PictureModel.init(createdAt: "\(date)", imageData: imageSave, description: "\(text)")
        }
    }
    
    @IBAction func Dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SavePost(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func PhotoAlbum(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func CameraButton(_ sender: UIBarButtonItem) {
    }
    
    
    
}
