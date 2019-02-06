//
//  FavoritesViewController.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: BaseViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    var movies: Results<Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        movies = realm.objects(Movie.self).filter("isFavorite == true")
        favoritesTableView.reloadData()
    }
}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        cell.movie = movies[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            try! realm.write {
                
                movies[indexPath.row].isFavorite = false
                
            }
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
