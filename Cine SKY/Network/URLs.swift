//
//  URLs.swift
//  Movs
//
//  Created by Bruno Lopes de Mello on 28/04/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import Foundation

enum URLs {
    static let baseUrl = "https://api.themoviedb.org/3/movie"
    static let baseImagesUrl = "https://image.tmdb.org/t/p/w500/"
    static let ApiKey = "3f767426720c364fcf885cdb5d079d5f"
    
    static var apiEndPoint : String {
        get {
            let value = "\(URLs.baseUrl)"
            return value
        }
    }
    
    //Now playing
    static let getNowPlaying = "\(apiEndPoint)/now_playing"
    static let getTopRated = "\(apiEndPoint)/top_rated"
    static let getPopular = "\(apiEndPoint)/popular"
}

