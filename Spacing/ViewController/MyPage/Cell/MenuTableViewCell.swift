//
//  MenuTableViewCell.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuIconImageView: UIImageView!
    @IBOutlet weak var buttonImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "MenuTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MenuTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    func configure(menu : MyPageMenu){
        menuIconImageView.image = menu.menuIcon
        buttonImageView.image = menu.touchIcon
        titleLabel.text = menu.title
        self.selectionStyle = .none
    }
    
}
