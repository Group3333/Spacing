//
//  favoriteViewController.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import UIKit
import SnapKit

class PlaceViewController: UIViewController{
    @IBOutlet weak var categoryTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var user = User.currentUser
    let categories: [Categories] = Categories.allCases
    var selectedCategory: Categories = .all
    var places : [Place] = []
    var filteredPlaces: [Place] = []
    var state : State?
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        configureNav()
        updateData()
        collectionViewConfigure()
        tableViewConfigure()
        searchBarConfigure()
    }
    
    func configureNav(){
        self.navigationItem.title = state?.rawValue
        if state == .Host{
            let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(PresentAddPlaceVC))
            addButton.tintColor = .red
            self.navigationItem.rightBarButtonItem = addButton
            
        }
    }
    
    @objc func PresentAddPlaceVC (){
        let storyboard = UIStoryboard(name: "AddPlaceViewController", bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "AddPlaceViewController")
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    func collectionViewConfigure(){
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        categoryCollectionView.collectionViewLayout = flowLayout
        categoryCollectionView.allowsMultipleSelection = false
    }
    
    func tableViewConfigure(){
        self.favoriteTableView.dataSource = self
        self.favoriteTableView.delegate = self
        self.favoriteTableView.register(PlaceTableViewCell.nib(), forCellReuseIdentifier: PlaceTableViewCell.identifier)
    }
    
    func updateData(){
        filteredPlaces = {
            if selectedCategory == .all{
                return places
            }else{
                return places.filter { $0.categories == selectedCategory }
            }
        }()
        setupEmptyView()
    }
    
    func searchBarConfigure(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "이름, 주소 등"
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.automaticallyShowsCancelButton = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupEmptyView() {
        if filteredPlaces.count == 0{
            let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: favoriteTableView.bounds.size.width, height: favoriteTableView.bounds.size.height))
            let emptyImageView = UIImageView()
            emptyImageView.image = UIImage(named: "empty")
            emptyImageView.contentMode = .scaleAspectFit
            
            let emptyLabel = UILabel()
            emptyLabel.text = "즐겨찾기 되어 있는 공간이 없습니다!"
            emptyLabel.textAlignment = .center
            emptyLabel.textColor = .secondaryLabel
            
            emptyView.addSubview(emptyImageView)
            emptyView.addSubview(emptyLabel)
            
            emptyImageView.snp.makeConstraints{make in
                make.centerX.equalTo(emptyView)
                make.centerY.equalTo(emptyView).offset(-50)
            }
            emptyLabel.snp.makeConstraints{make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(emptyImageView.snp.bottom).offset(20)
            }
            favoriteTableView.backgroundView = emptyView
        }else{
            favoriteTableView.backgroundView = nil
        }
    }
}

extension PlaceViewController : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = categories[indexPath.row].rawValue
        label.sizeToFit()
        let cellWidth = label.frame.width + 20
        let cellHeight = label.frame.height + 5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        updateData()
        guard let previousSelectedIndexPath = collectionView.indexPathsForSelectedItems?.first else {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.backgroundColor = UIColor.lightGray
            }
            return
        }
        if let previousCell = collectionView.cellForItem(at: previousSelectedIndexPath) {
            previousCell.contentView.backgroundColor = UIColor.clear
        }
        if let newCell = collectionView.cellForItem(at: indexPath) {
            newCell.contentView.backgroundColor = UIColor.lightGray
        }
        self.favoriteTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.clear
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.configure(text: categories[indexPath.row].rawValue)
        cell.layer.cornerRadius = cell.layer.bounds.height / 2
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
}

extension PlaceViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(place: filteredPlaces[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // TableView의 스크롤 방향을 확인하여 CollectionView를 숨기거나 나타나게 합니다.
        
        UIView.animate(withDuration: 0.2) {
            if scrollView.contentOffset.y > 0 { // TableView가 아래로 스크롤될 때
                self.categoryTopConstraint.constant = -50
            } else {
                self.categoryTopConstraint.constant = 0
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        destinationViewController.selectedPlaces = places[indexPath.row]
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension PlaceViewController : UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print(type(of: searchController.searchBar.text))
        
        guard let text = searchController.searchBar.text else { return }
        self.filteredPlaces = places.filter {
            $0.position.contains(text) || $0.title.contains(text)
        }
        dump(text)
        favoriteTableView.reloadData()
    }
}
