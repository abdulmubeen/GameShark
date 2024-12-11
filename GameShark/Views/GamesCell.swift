//
//  GamesCell.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import UIKit

class GamesCell: UITableViewCell {

    @IBOutlet weak var gameThumb: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gameThumb.layer.cornerRadius = 8
        gameThumb.clipsToBounds = true
    }
    
    func configure(with game: Game) {
        gameTitle.text = game.external
        
        if let thumbURLString = game.thumb, let thumbURL = URL(string: thumbURLString) {
            gameThumb.loadImage(from: thumbURL, placeholder: UIImage(named: "placeholder"))
        }
    }
}
