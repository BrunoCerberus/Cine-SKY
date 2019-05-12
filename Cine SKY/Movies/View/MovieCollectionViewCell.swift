//
//  MovieCollectionViewCell.swift
//  Cine SKY
//
//  Created by Bruno Lopes de Mello on 12/05/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func fillCell(movie: Movie) {
        movieImage.sd_setImage(with: URL(string: movie.coverURL ?? "")) { [unowned self]
            (image, error, cache, url) in
            if error == nil {
                DispatchQueue.main.async {
                    self.loaderIndicator.stopAnimating()
                    self.movieNameLabel.text = movie.title
                }
            } else {
                self.movieImage.image = UIImage(named: "imagenotfound")
                self.movieImage.contentMode = .scaleAspectFill
            }
        }
    }
}
