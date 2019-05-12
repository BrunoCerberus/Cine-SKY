//
//  URLs.swift
//  Movs
//
//  Created by Bruno Lopes de Mello on 28/04/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import Foundation

enum URLs {
    static let baseUrl = "https://sky-exercise.herokuapp.com/api/"
    
    static var apiEndPoint : String {
        get {
            let value = "\(URLs.baseUrl)"
            return value
        }
    }
    
    //Now playing
    static let getNowPlaying = "\(apiEndPoint)/Movies"
}

