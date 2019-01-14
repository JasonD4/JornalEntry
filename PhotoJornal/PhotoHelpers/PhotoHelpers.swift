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
    private init() {}
    
    static func saveTheEntry(typeOfFileSaving: PictureModel){
        
        let pathToSaveTo = DataPersistenceHelper.filepathToDocumentDirectory(filename: storePost)
    }
}
