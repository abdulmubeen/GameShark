//
//  Store.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import Foundation

struct Store: Codable {
    let storeID: String?
    let storeName: String?
    var images: StoreImages
}

struct StoreImages: Codable {
    let banner: String?
    let logo: String?
    let icon: String?
}

