//
//  TopCollectionViewCell.swift
//  Spacing
//
//  Created by Sam.Lee on 4/25/24.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "TopCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "TopCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String, image: UIImage){
        self.label.text = title
        self.imageView.image = image
    }

}
