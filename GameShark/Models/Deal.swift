//
//  Deal.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//
import Foundation

struct Deal: Codable {
    let internalName: String?
    let title: String?
    let metacriticLink: String?
    let dealID: String?
    let storeID: String?
    let gameID: String?
    let salePrice: String?
    let normalPrice: String?
    let isOnSale: String?
    let savings: String?
    let metacriticScore: String?
    let steamRatingText: String?
    let steamRatingPercent: String?
    let steamRatingCount: String?
    let steamAppID: String?
    let releaseDate: TimeInterval?
    let lastChange: TimeInterval?
    let dealRating: String?
    let thumb: String?
}
