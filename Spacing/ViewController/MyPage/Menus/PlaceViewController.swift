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
    @IBOutlet weak var placeTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var user = User.currentUser
    let categories: [Categories] = Categories.allCases
    var selectedCategory: Categories = .all
    var places : [Place] = []
    var filteredPlaces: [Place] = []
    var state : State?
    var searchController : UISearchController!
    var bookPlace: [BookPlace] = []
    var filteredBookPlaces: [BookPlace] = []
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.placeTableView.reloadData()
    }
    func configure(){
        configureNav()
        updateData()
        collectionViewConfigure()
        tableViewConfigure()
        searchBarConfigure()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.spacingDarkGray]
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
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "AddPlaceViewController") as! AddPlaceViewController
        destinationViewController.delegate = self
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
        self.placeTableView.dataSource = self
        self.placeTableView.delegate = self
        self.placeTableView.register(PlaceTableViewCell.nib(), forCellReuseIdentifier: PlaceTableViewCell.identifier)
        self.placeTableView.showsVerticalScrollIndicator = false
        self.placeTableView.showsHorizontalScrollIndicator = false
    }
    
    func updateData(){
        switch state{
        case .Host:
            places = User.currentUser.hostPlace
        case .Favorite:
            places = User.currentUser.favorite
        case .Uses:
            bookPlace = User.currentUser.bookPlace
            filteredBookPlaces = {
                if selectedCategory == .all{
                    return bookPlace
                }else{
                    return bookPlace.filter { $0.place.categories == selectedCategory }
                }
            }()
        default:
            places = Place.data
        }
        if state == .Main && searchText != "" {
            filteredPlaces = {
                return places.filter { $0.position.contains(self.searchText) || $0.title.contains(self.searchText) || $0.position.contains(self.searchText) }
            }()
            self.searchText = ""
        }else{
            filteredPlaces = {
                if selectedCategory == .all{
                    return places
                }else{
                    return places.filter { $0.categories == selectedCategory }
                }
            }()
        }
        setupEmptyView()
    }
    
    func searchBarConfigure(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "이름, 주소 등"
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.automaticallyShowsCancelButton = true
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.enablesReturnKeyAutomatically = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupEmptyView() {
        if filteredPlaces.count == 0 && filteredBookPlaces.count == 0{
            let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: placeTableView.bounds.size.width, height: placeTableView.bounds.size.height))
            let emptyImageView = UIImageView()
            emptyImageView.image = UIImage(named: "empty")
            emptyImageView.contentMode = .scaleAspectFit
            
            let emptyLabel = UILabel()
            emptyLabel.text = "아무것도 없습니다!"
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
            placeTableView.backgroundView = emptyView
        }else{
            placeTableView.backgroundView = nil
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
        self.placeTableView.reloadData()
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
        cell.layer.borderColor = UIColor.spacingOrange.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
}

extension PlaceViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if state == .Uses{
            return filteredBookPlaces.count
        }else{
            return filteredPlaces.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else{
            return UITableViewCell()
        }
        
        if state == .Uses{
            cell.configureBookView(bookPlace: filteredBookPlaces[indexPath.row])
        }else{
            cell.configure(place: filteredPlaces[indexPath.row])
        }
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
        if state == .Uses{
            destinationViewController.selectedPlaces = bookPlace[indexPath.row].place
        }else{
            destinationViewController.selectedPlaces = places[indexPath.row]
        }
        destinationViewController.delegate = self
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if state == .Host{
            let modify = UIContextualAction(style: .normal, title: "수정하기", handler: {(action, view, completionHandler) in
                let storyboard = UIStoryboard(name: "AddPlaceViewController", bundle: nil)
                let destinationViewController = storyboard.instantiateViewController(withIdentifier: "AddPlaceViewController") as! AddPlaceViewController
                destinationViewController.place = self.filteredPlaces[indexPath.row]
                destinationViewController.edit = true
                self.navigationController?.pushViewController(destinationViewController, animated: true)
                completionHandler(true)
            })
            modify.image = UIImage(systemName: "pencil")
            return UISwipeActionsConfiguration(actions: [modify])
        }else{
            return nil
        }
    }
}

extension PlaceViewController : UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text == ""{
            return
        }
        if state == .Uses{
            self.filteredBookPlaces = bookPlace.filter {
                $0.place.position.contains(text) || $0.place.title.contains(text)
            }
        }else{
            self.filteredPlaces = places.filter {
                $0.position.contains(text) || $0.title.contains(text) || $0.position.contains(text)
            }
        }
        setupEmptyView()
        placeTableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setupEmptyView()
        self.searchController.isActive = false
        placeTableView.reloadData()
    }
}

extension PlaceViewController : NewPlaceDelegate , FavoritieDelegate{
    func favChanged() {
        updateData()
        self.placeTableView.reloadData()
    }
    
    func addNewPlace() {
        updateData()
        self.placeTableView.reloadData()
    }
}
