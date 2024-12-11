//
//  Game.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import Foundation

struct Game: Codable {
    let gameID: String
    let steamAppID: String?
    let cheapest: String?
    let cheapestDealID: String?
    let external: String
    let internalName: String?
    let thumb: String?
}
