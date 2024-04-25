//
//  BottomCollectionViewCell.swift
//  Spacing
//
//  Created by 최진문 on 2024/04/25.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {

    let backView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    let bottomText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backView.backgroundColor = UIColor.black
                bottomText.textColor = .red
            }
            else {
                backView.backgroundColor = UIColor.blue
                bottomText.textColor = .black
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backView)
        backView.addSubview(bottomText)
        
        NSLayoutConstraint.activate([
                  backView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                  backView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                  backView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                  backView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
              ])
              
              NSLayoutConstraint.activate([
                  bottomText.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
                  bottomText.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
              ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
