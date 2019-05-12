//
//  Movies.swift
//  Cine SKY
//
//  Created by Bruno Lopes de Mello on 12/05/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import Foundation

typealias Movies = [Movie]

struct Movie: Codable {
    let title, overview, duration, releaseYear: String?
    let coverURL: String?
    let backdropsURL: [String]?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case title, overview, duration
        case releaseYear = "release_year"
        case coverURL = "cover_url"
        case backdropsURL = "backdrops_url"
        case id
    }
}

