//
//  ViewController.swift
//  Movies
//
//  Created by sambath on 11/05/23.
//

import UIKit

class ViewController: UIViewController {

    private var apiService = ApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadPopularMoviesData()
    }
    
    private func loadPopularMoviesData() {
        
        apiService.getPopularMoviesData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                CoreData.sharedInstance.saveDataOf(movies: listOf.movies)
                self?.perform(#selector(self?.mainScreen))
            case .failure(let error):
                self?.showAlertWith(title: "Could Not Connect!", message: "Please check your internet connection \n or try again later")
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func mainScreen() {
        performSegue(withIdentifier: "moviesList", sender: self)    
    }

}

