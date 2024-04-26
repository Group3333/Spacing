//
//  BottomCollectionViewCell.swift
//  Spacing
//
//  Created by 최진문 on 2024/04/26.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var descriptions: UILabel!
    
    static let identifier = "BottomCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "BottomCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(title: String, description: String, image: UIImage){
        self.title.text = title
        self.descriptions.text = description
        self.imageView.image = image
    }

}
