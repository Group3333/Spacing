//
//  ImageCollectionViewCell.swift
//  Spacing
//
//  Created by 서혜림 on 4/24/24.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedImage: UIImageView!
    
    static let identifier = "ImageCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    
    override func prepareForReuse() {
        selectedImage.image = UIImage()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configure(image : UIImage){
        selectedImage.image = image
        selectedImage.layer.cornerRadius = 10
        selectedImage.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        selectedImage.layer.borderWidth = 3
    }
}
