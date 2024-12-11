//
//  NetworkManager.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchAllStores(completion: @escaping (Result<[Store], Error>) -> Void) {
        guard let url = URL(string: "https://www.cheapshark.com/api/1.0/stores") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let stores = try JSONDecoder().decode([Store].self, from: data)
                completion(.success(stores))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchStoreDeals(storeId: String, completion: @escaping (Result<[Deal], Error>) -> Void) {
        guard let url = URL(string: "https://www.cheapshark.com/api/1.0/deals?storeID=\(storeId)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let deals = try JSONDecoder().decode([Deal].self, from: data)
                completion(.success(deals))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchGame(gameTitle: String, completion: @escaping (Result<[Game], Error>) -> Void) {
        guard let url = URL(string: "https://www.cheapshark.com/api/1.0/games?title=\(gameTitle)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let games = try JSONDecoder().decode([Game].self, from: data)
                completion(.success(games))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchGameDetails(gameID: String, completion: @escaping (Result<GameLookup, Error>) -> Void) {
        guard let url = URL(string: "https://www.cheapshark.com/api/1.0/games?id=\(gameID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let gameDetail = try JSONDecoder().decode(GameLookup.self, from: data)
                completion(.success(gameDetail))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
