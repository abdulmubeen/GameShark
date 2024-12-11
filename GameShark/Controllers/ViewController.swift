//
//  ViewController.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-06.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var storeTableView: UITableView!
    @IBOutlet weak var dealsTableView: UITableView!
    
    @IBOutlet weak var dealsText: UILabel!
    
    var stores: [Store] = []
    var deals: [Deal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeTableView.delegate = self
        storeTableView.dataSource = self
        storeTableView.register(UINib(nibName: "StoresCell", bundle: nil), forCellReuseIdentifier: "StoresCell")
        
        dealsTableView.delegate = self
        dealsTableView.dataSource = self
        dealsTableView.register(UINib(nibName: "DealsCell", bundle: nil), forCellReuseIdentifier: "DealsCell")
        
        storeTableView.rowHeight = UITableView.automaticDimension
        storeTableView.estimatedRowHeight = 100

        dealsTableView.rowHeight = UITableView.automaticDimension
        dealsTableView.estimatedRowHeight = 100
        
        fetchStores()
    }
    
    private func fetchStores() {
        NetworkManager.shared.fetchAllStores { [weak self] result in
            switch result {
            case .success(let stores):
                self?.stores = stores
                DispatchQueue.main.async {
                    self?.storeTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching stores: \(error)")
            }
        }
    }
    
    private func fetchDeals(storeId: String) {
        NetworkManager.shared.fetchStoreDeals(storeId: storeId) { [weak self] result in
            switch result {
            case .success(let deals):
                self?.deals = deals
                DispatchQueue.main.async {
                    self?.dealsTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching deals: \(error)")
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == storeTableView {
            return stores.count
        } else if tableView == dealsTableView {
            return deals.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == storeTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoresCell", for: indexPath) as? StoresCell else {
                return UITableViewCell()
            }
            let store = stores[indexPath.row]
            cell.configure(with: store)
            return cell
        } else if tableView == dealsTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DealsCell", for: indexPath) as? DealsCell else {
                return UITableViewCell()
            }
            let deal = deals[indexPath.row]
            cell.configure(with: deal)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == storeTableView {
            return 50
        } else if tableView == dealsTableView {
            return 110
        }
        return 44
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == storeTableView {
            let selectedStore = stores[indexPath.row]
            dealsText.text = "\(selectedStore.storeName ?? "") Deals Today"
            if let storeId = selectedStore.storeID {
                fetchDeals(storeId: storeId)
            }
        }
    }
}
