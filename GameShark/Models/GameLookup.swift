//
//  GameLookup.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import Foundation

struct GameLookup: Codable {
    let info: GameInfo
    let cheapestPriceEver: CheapestPriceEver
    let deals: [GameLookupDeal]
}

struct GameInfo: Codable {
    let title: String
    let steamAppID: String?
    let thumb: String?
}

struct CheapestPriceEver: Codable {
    let price: String?
    let date: TimeInterval?
}

struct GameLookupDeal: Codable {
    let storeID: String?
    let dealID: String?
    let price: String?
    let retailPrice: String?
    let savings: String?
}
