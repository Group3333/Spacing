//
//  UserTableViewCell.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    static let identifier = "UserTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "UserTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        nameLabel.textColor = .spacingGray
        emailLabel.textColor = .spacingDarkGray
    }
    
    func configure(user : User){
        profileImageView.image = user.profileImage
        profileImageView.layer.cornerRadius = profileImageView.layer.bounds.width / 2
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05).cgColor
        emailLabel.text = user.email
        nameLabel.text = user.name
        self.selectionStyle = .none
    }
    
}
