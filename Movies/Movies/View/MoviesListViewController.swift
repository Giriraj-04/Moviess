//
//  MoviesListViewController.swift
//  Movies
//
//  Created by sambath on 11/05/23.
//

import UIKit

class MoviesListViewController: UIViewController, UpdateViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = MoviesListViewModel()

//    lazy var collectionViews: UICollectionView = {
//            let layout = PagingCollectionViewLayout()
//            layout.sectionInset = .init(top: 0, left: self.spacing, bottom: 0, right: self.spacing)
//            layout.minimumLineSpacing = self.cellSpacing
//            layout.itemSize = .init(width: self.cellWidth, height: self.cellWidth)
//            layout.scrollDirection = .vertical
//
//            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//            collectionView.translatesAutoresizingMaskIntoConstraints = false
//            collectionView.showsHorizontalScrollIndicator = false
//            collectionView.decelerationRate = .fast
//            collectionView.dataSource = self
//            collectionView.backgroundColor = .white
//            collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: "MovieListCell")
//            return collectionView
//        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        self.viewModel.delegate = self
        loadData()
    }
    
    private func loadData() {
        viewModel.retrieveDataFromCoreData()
    }
    
    func reloadData(sender: MoviesListViewModel) {
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieSelected" {
            guard let detailsVC = segue.destination as? MovieDetailsViewController else {return}
            guard let selectedMovieCell = sender as? UICollectionViewCell else {return}
            if let indexPath = collectionView.indexPath(for: selectedMovieCell) {
                let selectedMovie = viewModel.object(indexPath: indexPath)
                detailsVC.viewModel = MovieDetailsViewModel(movieDetails: selectedMovie)
            }
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = .black
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath)
        let object = viewModel.object(indexPath: indexPath)
        
        if let movieCell = cell as? MovieListCell {
            if let movie = object {
                movieCell.setCellWithValuesOf(movie)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/2)
    }
    
    
}

    
    
   
