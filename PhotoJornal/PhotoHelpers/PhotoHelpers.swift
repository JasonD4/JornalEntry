//
//  File.swift
//  PhotoJornal
//
//  Created by Jason on 1/14/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import Foundation

final class PhotoHelpers{
    
    private static let storePost = "AllUserEntries.plist"
    private static var picturePost = [PictureModel]()
    private init() {}
    
    static func time() -> String{
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        return formatter.string(from: currentDateTime)
    }
    
    static func removing(index:Int){
        picturePost.remove(at: index)
        saveTheEntry()
    }
    static func appening(type : PictureModel){
        picturePost.append(type)
        saveTheEntry()
    }
    static func replacing(post:PictureModel){        
        let index = picturePost.firstIndex { $0.id == post.id }
        if let foundIndex = index {
            picturePost[foundIndex] = post
        } else {
            print("index not found")
        }
        saveTheEntry()
    }
    static func saveTheEntry(){

        let pathToSaveTo = DataPersistenceHelper.filepathToDocumentDirectory(filename: storePost)
        do{
            let photoData = try PropertyListEncoder().encode(picturePost)
            try photoData.write(to: pathToSaveTo, options: Data.WritingOptions.atomic)
        }catch{
            print("error in the static function saveTheEntry: \(error)")
        }
    }
    static func loadTheEntry() -> [PictureModel]{
        
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
    
//    public func dateObtainer() -> String{
//        var dateReturner = String()
//        
//        public var dateFormattedString: String {
//            let isoDateFormatter = ISO8601DateFormatter()
//            var formattedDate = createdAt
//            if let date = isoDateFormatter.date(from: createdAt) {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
//                formattedDate = dateFormatter.string(from: date)
//            }
//            return formattedDate
//        }
//        public var date: Date {
//            let isoDateFormatter = ISO8601DateFormatter()
//            var formattedDate = Date()
//            if let date = isoDateFormatter.date(from: createdAt) {
//                formattedDate = date
//            }
//            return formattedDate
//        }
//        return dateReturner
//    }

}
