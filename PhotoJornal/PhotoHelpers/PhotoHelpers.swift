//
//  File.swift
//  PhotoJornal
//
//  Created by Jason on 1/14/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import Foundation

final class PhotoHelpers{
    
    private static let storePost = "AllUserEntries"
    private static var picturePost: [PictureModel]?
    private init() {}
    
    static func saveTheEntry(typeOfFileSaving: [PictureModel]){
        
        let pathToSaveTo = DataPersistenceHelper.filepathToDocumentDirectory(filename: storePost)
        do{
            let photoData = try PropertyListEncoder().encode(picturePost)
            try photoData.write(to: pathToSaveTo, options: Data.WritingOptions.atomic)
        }catch{
            print("error in the static function saveTheEntry: \(error)")
        }
    }
    static func loadTheEntry() -> [PictureModel]?{
        
        let path = DataPersistenceHelper.filepathToDocumentDirectory(filename: storePost).path
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path){
                do{// [phototJornal]
                    picturePost = try PropertyListDecoder().decode([PictureModel].self, from: data)
                }catch{
                    print(error)
                }
            }else{
                print("LoadtheEntry func data area is nil")
            }
        }
        else{
            print("\(storePost) does not exsist")
        }
        return picturePost
    }
    
}
