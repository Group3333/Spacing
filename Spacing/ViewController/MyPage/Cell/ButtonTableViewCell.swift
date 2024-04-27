//
//  ButtonTableViewCell.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import UIKit

protocol LogoutDelegate{
    func logoutButtonClicked()
}
class ButtonTableViewCell: UITableViewCell {
    
    static let identifier = "ButtonTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "ButtonTableViewCell", bundle: nil)
    }
    var delegate : LogoutDelegate?
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        self.delegate?.logoutButtonClicked()
    }
    
    @IBOutlet weak var logoutButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(){
        logoutButton.titleLabel?.text = "로그아웃"
        logoutButton.titleLabel?.textColor = .red
        logoutButton.backgroundColor = .spacingLightGray
        logoutButton.clipsToBounds = false
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2 - 10
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
    }
}
