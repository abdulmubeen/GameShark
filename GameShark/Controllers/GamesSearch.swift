//
//  GamesSearch.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import UIKit

class GamesSearch: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var gamesTable: UITableView!
    
    var games: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        gamesTable.register(UINib(nibName: "GamesCell", bundle: nil), forCellReuseIdentifier: "GamesCell")
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 4 {
            fetchGames(gameTitle: searchText)
        } else {
            games = []
            gamesTable.reloadData()
        }
    }
    
    private func fetchGames(gameTitle: String) {
        NetworkManager.shared.fetchGame(gameTitle: gameTitle) { [weak self] result in
            switch result {
            case .success(let games):
                self?.games = games
                DispatchQueue.main.async {
                    self?.gamesTable.reloadData()
                }
            case .failure(let error):
                print("Error fetching games: \(error)")
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GamesCell", for: indexPath) as? GamesCell else {
            return UITableViewCell()
        }
        
        let game = games[indexPath.row]
        cell.configure(with: game)
        return cell
    }
    
    // MARK: - Navigation (when a game is selected)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = games[indexPath.row]
        performSegue(withIdentifier: "showGameDetails", sender: selectedGame)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameDetails", let game = sender as? Game {
            if let destinationVC = segue.destination as? GamesLookupViewController {
                destinationVC.gameID = game.gameID
            }
        }
    }
}

