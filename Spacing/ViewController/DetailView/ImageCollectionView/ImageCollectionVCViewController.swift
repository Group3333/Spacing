//
//  ImageCollectionVCViewController.swift
//  Spacing
//
//  Created by 서혜림 on 4/24/24.
//

import UIKit


class MyViewController: DetailViewController {
    
    // UICollectionView를 IBOutlet으로 연결합니다.
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 데이터 모델을 정의합니다.
    var data: [String] = ["Item 1", "Item 2", "Item 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UICollectionView에 대한 설정을 수행합니다.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // UICollectionView의 레이아웃을 설정합니다.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - UICollectionViewDataSource

extension MyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCollectionViewCell
        cell.textLabel.text = data[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 선택한 아이템에 대한 동작을 수행합니다.
    }
}
