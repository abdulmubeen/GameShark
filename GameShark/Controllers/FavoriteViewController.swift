//
//  FavoriteViewController.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var favoriteGames: [GameEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "GamesCell", bundle: nil), forCellReuseIdentifier: "GamesCell")
        
        tableView.delegate = self
        tableView.dataSource = self

        fetchFavoriteGames()
    }
    
    private func fetchFavoriteGames() {
        if let games = CoreDataManager.shared.fetchAllGames() {
            favoriteGames = games
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GamesCell", for: indexPath) as? GamesCell else {
            fatalError("Unable to dequeue GamesCell")
        }
        
        let game = favoriteGames[indexPath.row]
        
        let temporaryGameModel = Game(
            gameID: game.gameID ?? "", steamAppID: "", cheapest: "", cheapestDealID: "", external: game.title ?? "", internalName: "", thumb: game.thumbURL
        )
        
        cell.configure(with: temporaryGameModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
