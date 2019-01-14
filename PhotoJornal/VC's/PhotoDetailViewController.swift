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
    
    @IBAction func Dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)3
    }
    
    @IBAction func SavePost(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func PhotoAlbum(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func CameraButton(_ sender: UIBarButtonItem) {
    }
    
    
    
}
