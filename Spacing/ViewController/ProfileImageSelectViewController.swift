//
//  ProfileImageSelectViewController.swift
//  Spacing
//
//  Created by Sam.Lee on 4/26/24.
//

import UIKit

protocol ProfileImageDelegate{
    func profileImageChanged(image : UIImage)
}
class ProfileImageSelectViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var profileImageCollectionView: UICollectionView!
    
    var delegate : ProfileImageDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        view.backgroundColor = .spacingBeige
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .spacingOrange
    }

    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func configure(){
        
        self.profileImageCollectionView.dataSource = self
        self.profileImageCollectionView.delegate = self
        self.profileImageCollectionView.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        let space = (profileImageCollectionView.frame.size.width - profileImageCollectionView.frame.size.height) / 2
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: Int(profileImageCollectionView.frame.size.height), height: Int(profileImageCollectionView.frame.size.height))
        profileImageCollectionView.collectionViewLayout = flowLayout
        profileImageCollectionView.allowsMultipleSelection = false
        profileImageCollectionView.backgroundColor = .spacingBeige
        confirmButton.layer.cornerRadius = confirmButton.layer.bounds.height / 2
        
    }
}

extension ProfileImageSelectViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return User.profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.configure(image: User.profileImageList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.profileImageChanged(image: User.profileImageList[indexPath.row])
    }
    
    
}
