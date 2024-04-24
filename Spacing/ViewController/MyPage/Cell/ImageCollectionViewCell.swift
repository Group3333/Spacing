//
//  ImageCollectionViewCell.swift
//  Spacing
//
//  Created by Sam.Lee on 4/24/24.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "ImageCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(image : UIImage){
        imageView.image = image
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        imageView.layer.borderWidth = 3
    }
}