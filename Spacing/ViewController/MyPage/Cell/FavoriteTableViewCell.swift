//
//  FavoriteTableViewCell.swift
//  Spacing
//
//  Created by Sam.Lee on 4/23/24.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var hourPriceLabel: UILabel!
    @IBOutlet weak var discountHourPriceLabel: UILabel!
    @IBOutlet weak var eventPriceLabel: UILabel!
    @IBOutlet weak var eventDiscountPriceLabel: UILabel!
    @IBOutlet weak var spaceImageView: UIImageView!
    
    static let identifier = "FavoriteTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "FavoriteTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        [categoryLabel,titleLabel,rateLabel,hourPriceLabel,discountHourPriceLabel,eventDiscountPriceLabel, eventPriceLabel,addressLabel].forEach{
            $0?.text = ""
        }
        spaceImageView.image = UIImage()
    }
    
    func configure(place : Place){
        categoryLabel.text = place.categories.rawValue
        titleLabel.text = place.title
        rateLabel.attributedText = makeStarLabel(rating: place.rating)
        addressLabel.text = place.position
        hourPriceLabel.text = Int.addCommas(to: place.price) + "원"
        eventPriceLabel.text = Int.addCommas(to: place.price * 3) + "원"
        [hourPriceLabel,eventPriceLabel].forEach{
            $0?.attributedText = $0?.text?.strikeThrough()
        }
        discountHourPriceLabel.text = Int.addCommas(to: place.price - Place.hourDiscount) + "원"
        eventDiscountPriceLabel.text = Int.addCommas(to: place.price * 3 - Place.eventDiscount)+"원"
        spaceImageView.image = place.images[0]
        spaceImageView.clipsToBounds = true
        spaceImageView.layer.cornerRadius = 10
        spaceImageView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05).cgColor
        spaceImageView.layer.borderWidth = 2
    }
    func makeStarLabel(rating : Double) -> NSMutableAttributedString{
        let attributeString = NSMutableAttributedString(string: "")
        
        // 별 이미지를 추가합니다.
        let fullStarCount = Int(rating)
        for _ in 0..<fullStarCount {
            let imageAttachment = NSTextAttachment(image: UIImage(systemName: "star.fill")!)
            imageAttachment.bounds = .init(x: 0, y: -2, width: 14, height: 14)
            attributeString.append(NSAttributedString(attachment: imageAttachment))
        }
        
        // 소수점 이하의 값을 반올림하여 추가합니다.
        let remainingRating = rating - Double(fullStarCount)
        if remainingRating > 0 {
            let imageAttachment = NSTextAttachment(image: UIImage(systemName: "star.leadinghalf.fill")!)
            imageAttachment.bounds = .init(x: 0, y: -2, width: 14, height: 14)
            attributeString.append(NSAttributedString(attachment: imageAttachment))
        }
        
        // 나머지 빈 별을 추가합니다.
        let emptyStarCount = 5 - fullStarCount - (remainingRating > 0 ? 1 : 0)
        for _ in 0..<emptyStarCount {
            let imageAttachment = NSTextAttachment(image: UIImage(systemName: "star")!)
            imageAttachment.bounds = .init(x: 0, y: -2, width: 14, height: 14)
            attributeString.append(NSAttributedString(attachment: imageAttachment))
        }
        attributeString.append(NSAttributedString(string: " \(rating)"))
        return attributeString
    }
}
