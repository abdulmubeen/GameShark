//
//  DealsCell.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import UIKit

class DealsCell: UITableViewCell {

    @IBOutlet weak var gameThumb: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var previousPrice: UILabel!
    @IBOutlet weak var dealPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialize UI elements
        gameThumb.layer.cornerRadius = 8
        gameThumb.clipsToBounds = true
        
        setupAccessibility()
    }
    
    func configure(with deal: Deal) {
            gameName.text = deal.title
            
            if let normalPrice = deal.normalPrice, !normalPrice.isEmpty {
                previousPrice.attributedText = formatStrikethroughPrice(normalPrice)
            } else {
                previousPrice.text = "N/A"
            }
            
            if let salePrice = deal.salePrice, !salePrice.isEmpty {
                dealPrice.text = formatPrice(salePrice)
                dealPrice.textColor = calculateSavingsColor(deal.savings)
            } else {
                dealPrice.text = "N/A"
            }
            
        if let thumbURL = URL(string: deal.thumb!) {
                gameThumb.loadImage(from: thumbURL, placeholder: UIImage(named: "placeholder"))
            }
        }
    
    // MARK: - Helper Methods
    
    private func formatPrice(_ price: String) -> String {
        guard let priceValue = Double(price) else { return price }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: priceValue)) ?? price
    }
    
    private func formatStrikethroughPrice(_ price: String) -> NSAttributedString {
        let formattedPrice = formatPrice(price)
        let attributedString = NSMutableAttributedString(string: formattedPrice)
        attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    private func calculateSavingsColor(_ savings: String?) -> UIColor {
        guard let savingsValue = Double(savings ?? ""), savingsValue > 0 else {
            return .label
        }
        return savingsValue > 50 ? .systemRed : .label
    }
    
    private func setupAccessibility() {
        gameName.isAccessibilityElement = true
        gameName.accessibilityLabel = "Game Title"
        
        previousPrice.isAccessibilityElement = true
        previousPrice.accessibilityLabel = "Original Price"
        
        dealPrice.isAccessibilityElement = true
        dealPrice.accessibilityLabel = "Deal Price"
        
        gameThumb.isAccessibilityElement = true
        gameThumb.accessibilityLabel = "Game Thumbnail"
    }
}
