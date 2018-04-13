//
//  fish.swift
//  PlasticFishesGood
//
//  Created by d182_sofia_d on 06/04/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import Foundation
struct Fish: Decodable{
    let id: String
    let name: String
    let text: String
    let apiUrl: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey{
        case apiUrl = "api_url"
        case imageUrl = "image_url"
        case id, name, text
    }
}
