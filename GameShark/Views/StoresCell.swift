//
//  StoresCell.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL?, placeholder: UIImage? = nil) {
        self.image = placeholder
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
            }
        }.resume()
    }

}

extension StoreImages {
    var fullLogoURL: URL? {
        guard let logo = logo else { return nil }
        return URL(string: "https://www.cheapshark.com" + logo)
    }
}


class StoresCell: UITableViewCell {

    @IBOutlet weak var storeLogo: UIImageView!
    
    @IBOutlet weak var storeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        storeLogo.layer.cornerRadius = 8
        storeLogo.clipsToBounds = true
    }

    func configure(with store: Store) {
        storeName.text = store.storeName
        storeLogo.loadImage(from: store.images.fullLogoURL)
    }
    
    private func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
        task.resume()
    }
}
