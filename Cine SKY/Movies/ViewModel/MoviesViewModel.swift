//
//  MoviesViewModel.swift
//  Cine SKY
//
//  Created by Bruno Lopes de Mello on 12/05/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import Foundation

protocol MoviesViewModelProtocol: class {
    func getNowPlayingMovies(onSuccess: @escaping ([Movie]) -> Void,
                             onFail: @escaping (_ msg: String) -> Void)
}

class MoviesViewModel: MoviesViewModelProtocol {
    
    
    /// Retrieve the first page of Now Playing movies to set into carousel
    ///
    /// - Parameters:
    ///   - onSuccess: onSuccess description
    ///   - onFail: onFail description
    func getNowPlayingMovies(onSuccess: @escaping ([Movie]) -> Void, onFail: @escaping (String) -> Void) {
        let paremeters: [String: Any] = [:]
        
        Api().requestCodable(metodo: .wGET, url: URLs.getNowPlaying,
                             objeto: Movies.self, parametros: paremeters,
                             onSuccess: { (response, result) in
                                
                                if result.count == 0 {
                                    onFail("Not possible to load any movies")
                                    return
                                }
                                
                                onSuccess(result)
                                
        }) { (response, error) in
            onFail(error)
        }
    }
}
