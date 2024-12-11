//
//  GamesLookupViewController.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import UIKit
import CoreData

class GamesLookupViewController: UIViewController {

    @IBOutlet weak var gameThumb: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var addToFavBtn: UIButton!
    @IBOutlet weak var favLabel: UILabel!
    
    var gameID: String?
    private var gameDetail: GameLookup?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let gameID = gameID {
            fetchGameDetails(gameID: gameID)
        }
    }

    private func fetchGameDetails(gameID: String) {
        NetworkManager.shared.fetchGameDetails(gameID: gameID) { [weak self] result in
            switch result {
            case .success(let gameDetail):
                DispatchQueue.main.async {
                    self?.gameTitle.text = gameDetail.info.title
                    if let thumbURLString = gameDetail.info.thumb, let thumbURL = URL(string: thumbURLString) {
                        self?.gameThumb.loadImage(from: thumbURL, placeholder: UIImage(named: "placeholder"))
                    }
                    
                    let isFavorite = CoreDataManager.shared.fetchAllGames()?.contains(where: { $0.gameID == gameID }) ?? false
                    
                    self?.updateFavoriteButton(isFavorite: isFavorite)

                    self?.addToFavBtn.addTarget(self, action: #selector(self?.addToFavorites), for: .touchUpInside)
                }

                self?.gameDetail = gameDetail

            case .failure(let error):
                print("Error fetching game details: \(error)")
            }
        }
    }

    private func updateFavoriteButton(isFavorite: Bool) {
        let buttonImage = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
        addToFavBtn.setImage(buttonImage, for: .normal)
    }

    @objc private func addToFavorites() {
        guard let gameDetail = gameDetail else { return }
        
        let title = gameDetail.info.title
        let gameID = gameDetail.info.steamAppID ?? ""
        let thumbURL = gameDetail.info.thumb ?? ""
        
        if CoreDataManager.shared.fetchAllGames()?.contains(where: { $0.gameID == gameID }) ?? false {
            let alert = UIAlertController(title: "Already Favorite", message: "This game is already in your favorites.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        CoreDataManager.shared.saveGameToCoreData(title: title, gameID: gameID, thumbURL: thumbURL)
        
        updateFavoriteButton(isFavorite: true)
        
        let alert = UIAlertController(title: "Success", message: "Game added to favorites!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

}
