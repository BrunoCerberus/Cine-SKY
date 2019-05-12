//
//  ListMoviesViewController.swift
//  Cine SKY
//
//  Created by Bruno Lopes de Mello on 12/05/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListMoviesViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var viewModel: MoviesViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = MoviesViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SVProgressHUD.show()
        viewModel?.getNowPlayingMovies(onSuccess: { [unowned self] movs in
            SVProgressHUD.dismiss()
            self.movies = movs
            }, onFail: { (msg) in
                SVProgressHUD.dismiss()
                GlobalAlert(with: self, msg: msg).show()
        })
    }
}

extension ListMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath)
            as? MovieCollectionViewCell else {return UICollectionViewCell()}
        guard let movie = movies?[indexPath.row] else {return UICollectionViewCell()}
        cell.fillCell(movie: movie)
        return cell
    }
}
