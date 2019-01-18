//
//  ViewController.swift
//  PhotoJornal
//
//  Created by Jason on 1/14/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

//protocol indexpathHolder: AnyObject {
//    func option(alert: UIButton)
//
//}

class PhotoViewController: UIViewController {
    var post = PhotoHelpers.loadTheEntry(){
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
        post = PhotoHelpers.loadTheEntry()
        print(DataPersistenceHelper.documentsDirectory())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        post = PhotoHelpers.loadTheEntry()
        self.PhotoJornalEntries.reloadData()
    }
    
    @IBAction func NewLog(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "PhotoDetail") as? PhotoDetailViewController else {return}
        vc.modalPresentationStyle = .currentContext
        present( vc, animated: true){
        }
    }
    
    @IBAction func options(_ sender: UIButton) {
        let alert = UIAlertController(title: "Options", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "delete", style: .destructive){(deleter) in
            PhotoHelpers.removing(index: sender.tag)
            self.post = PhotoHelpers.loadTheEntry()
            self.PhotoJornalEntries.reloadData()
            })
        alert.addAction(UIAlertAction.init(title: "edit", style: .destructive) {(edit) in
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "PhotoDetail") as? PhotoDetailViewController else {return}
            vc.photo = self.post[sender.tag]
            vc.isEditingPictureModel = true
            self.present(vc, animated: true)
            //vc.savepostoutlet.tag = sender.tag
            })
        alert.addAction(UIAlertAction.init(title: "cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
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
        cell.PersonPicture.image = UIImage.init(data: post[indexPath.row].imageData)
        cell.Options.tag = indexPath.row
        
     return cell
    }
    

}

extension PhotoViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 500)
    }
}


