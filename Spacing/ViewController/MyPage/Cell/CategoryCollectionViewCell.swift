//
//  CategoryCollectionViewCell.swift
//  Spacing
//
//  Created by Sam.Lee on 4/23/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    static let identifier = "CategoryCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryLabel.textColor = .spacingGray
    }

    func configure(text: String){
        categoryLabel.text = text
        categoryLabel.textColor = .spacingOrange
        categoryLabel.backgroundColor = .white
        categoryLabel.layer.cornerRadius = categoryLabel.layer.bounds.width / 2
        categoryLabel.layer.borderWidth = 1
        categoryLabel.layer.borderColor = UIColor.spacingOrange.cgColor
    }
}
