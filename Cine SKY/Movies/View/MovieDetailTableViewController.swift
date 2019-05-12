//
//  MovieDetailTableViewController.swift
//  Cine SKY
//
//  Created by Bruno Lopes de Mello on 12/05/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import iCarousel
import SDWebImage

class MovieDetailTableViewController: UITableViewController, Storyboarded {

    @IBOutlet weak var carouselView: iCarousel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = movie?.backdropsURL?.count ?? 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movieLabel.text = movie?.title
        detailLabel.text = movie?.overview
        durationLabel.text = movie?.duration
        releaseLabel.text = movie?.releaseYear
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}


// MARK: - <#iCarouselDataSource, iCarouselDelegate#>
extension MovieDetailTableViewController: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return movie?.backdropsURL?.count ?? 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        //create the UIView
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: carouselView.bounds.width, height: 200))
        
        //crate a UIImageView
        let frame = CGRect(x: 0, y: 0, width: carouselView.bounds.width, height: 200)
        let imageView = UIImageView()
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFill
        
        //set the images to the imageview and add it to the tempView
        imageView.sd_setImage(with: URL(string: movie?.backdropsURL?[index] ?? "")) { [unowned self]
            (image, error, cache, url) in
            if error == nil {
                DispatchQueue.main.async {
                    self.loaderIndicator.stopAnimating()
                    imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.loaderIndicator.stopAnimating()
                    imageView.image = UIImage(named: "imagenotfound")
                    imageView.contentMode = .scaleAspectFill
                }
            }
        }
        tempView.addSubview(imageView)
        
        return tempView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        self.pageControl.currentPage = carousel.currentItemIndex
    }
}
