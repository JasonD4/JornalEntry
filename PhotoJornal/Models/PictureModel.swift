//
//  Picture Model.swift
//  PhotoJornal
//
//  Created by Jason on 1/14/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import Foundation


struct PictureModel: Codable{
    let createdAt: String
    let imageData: Data
    let description: String
}
