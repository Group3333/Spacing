//
//  TopCategoryCollectionViewCell.swift
//  Spacing
//
//  Created by 최진문 on 2024/04/25.
//

import UIKit

class TopCategoryCollectionViewCell: UICollectionViewCell {

    let backView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemBlue
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    let categoryText: UILabel = {
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
                categoryText.textColor = .red
            }
            else {
                backView.backgroundColor = UIColor.blue
                categoryText.textColor = .black
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backView)
        backView.addSubview(categoryText)
        
        NSLayoutConstraint.activate([
                  backView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                  backView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                  backView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                  backView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
              ])
              
              NSLayoutConstraint.activate([
                  categoryText.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
                  categoryText.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
              ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

