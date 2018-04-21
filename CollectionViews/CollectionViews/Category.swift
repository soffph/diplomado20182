//
//  Category.swift
//  CollectionViews
//
//  Created by d182_sofia_d on 21/04/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit
class Category: NSObject {
    var name: String?
    var albums : [Album]?
    
    static func samples() -> [Category]{
        let bestNewAlbums = Category()
        bestNewAlbums.name = "Los mejores"
        
        var albums = [Album]()
        let album = Album()
        album.category  = "Rock"
        album.name = "queen"
        album.image = "cover1"
        albums.append(album)
        
        return [bestNewAlbums]
    }
    
}

class Album: NSObject {
    var name: String?
    var category: String?
    var image: String?
    
}
