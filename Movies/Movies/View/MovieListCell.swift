//
//  MovieListCell.swift
//  Movies
//
//  Created by sambath on 11/05/23.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieBackdrop: UIImageView!
    private var apiService = ApiService()
    private var urlString: String = ""
    
    func setCellWithValuesOf(_ movie:MovieEntity) {
        updateUI(title: movie.title, rate: movie.rate, overview: movie.overview, backdrop: movie.backdropImage)
    }
    
    private func updateUI(title:String?, rate:String?, overview:String?, backdrop:String?) {
        
        self.movieTitle.text = title
      
        guard let backdropString = backdrop else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + backdropString
        
        guard let backdropImageURL = URL(string: urlString) else {
            self.movieBackdrop.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.movieBackdrop.image = nil
        
        apiService.getImageDataFrom(url: backdropImageURL) { [weak self] (data: Data) in
            if let image = UIImage(data: data) {
                self?.movieBackdrop.image = image
            } else {
                self?.movieBackdrop.image = UIImage(named: "noImageAvailable")
            }
        }
        
        viewsAttributes()
    }
    
    private func viewsAttributes() {
        
        movieBackdrop.layer.cornerRadius = 20
        movieBackdrop.layer.borderWidth = 0.8
        movieBackdrop.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        movieBackdrop.contentMode = .scaleAspectFill
    }
}
