//
//  ViewController.swift
//  PhotoJornal
//
//  Created by Jason on 1/14/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var post = [PictureModel](){
        didSet{
            self.PhotoJornalEntries.reloadData()
        }
    }
    
    
    @IBOutlet weak var NewLogOutput: UIBarButtonItem!
    

    @IBOutlet weak var PhotoJornalEntries: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoJornalEntries.dataSource = self
        PhotoJornalEntries.delegate = self
        post = PhotoHelpers.loadTheEntry() ?? [PictureModel]()

    }

    @IBAction func NewLog(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "PhotoDetail") as? PhotoDetailViewController else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present( vc, animated: true)

    }
    
}



extension PhotoViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCells", for: indexPath) as? PhotoCells else{return UICollectionViewCell()}
        
        cell.JornalEntry.text = post[indexPath.row].description
        cell.DateOfEntry.text = post[indexPath.row].createdAt
        
        
//        cell.PersonPicture.image =
        
        
        return cell
    }
    
    
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 300)
    }
}
