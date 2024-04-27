//
//  AddPlaceViewController.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import UIKit
import PhotosUI
import Alamofire

protocol NewPlaceDelegate {
    func addNewPlace()
}

class AddPlaceViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var detailAddressTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var categoriesTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var spaceNamelabel: UILabel!
    @IBOutlet weak var spaceAddressLabel: UILabel!
    @IBOutlet weak var spaceCategLabel: UILabel!
    @IBOutlet weak var spacePriceLabel: UILabel!
    @IBOutlet weak var spaceDescriptionLabel: UILabel!
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if checkEdit().1 {
            let alertController = UIAlertController(title: "경고", message: "아직 입력하지 않는 칸이 있습니다!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { _ in
                self.dismiss(animated: true)
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "확인", message: "제출하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                let temp = GeoCoder()
                temp.delegate = self
                temp.getAlamofire(address: self.addressTextField.text!)
                self.dismiss(animated: true)
                self.navigationController?.popViewController(animated: true)
                
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func kakaoPostCodeSearch(_ sender: Any) {
        showKakaoPostCodeVC()
    }
    var images : [UIImage] = []
    var address : String = ""
    var configuarion = PHPickerConfiguration()
    var index : Int = 0
    let categories: [Categories] = Categories.allCases
    var row : Int = 0
    var delegate : NewPlaceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        createPickerView()
        dismissPickerView()
        configureCollectionView()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.spacingDarkGray]
        
        view.backgroundColor = .white
        [spaceNamelabel, spaceAddressLabel, spaceCategLabel, spacePriceLabel, spaceDescriptionLabel].forEach {
            $0?.textColor = .spacingDarkGray
        }
        [titleTextField, detailAddressTextField,addressTextField, categoriesTextField,priceTextField, descriptionTextView].forEach {
            $0?.backgroundColor = .spacingBeige
        }
        // Do any additional setup after loading the view.
    }
    
    func configure(){
        self.navigationItem.title = "새로운 place 등록"
        navigationItem.setHidesBackButton(true, animated: false)
        let customButton = UIBarButtonItem(title: "X", image: UIImage(systemName: "xmark"), target: self, action: #selector(customButtonTapped))
        customButton.tintColor = .red
        navigationItem.leftBarButtonItem = customButton
        self.hideKeyboardWhenTappedAround()
        pageControl.numberOfPages = 5
        pageControl.pageIndicatorTintColor = UIColor.systemGray
        pageControl.currentPageIndicatorTintColor = UIColor.label
        [searchButton!,submitButton!].forEach{
            $0.backgroundColor = .spacingOrange
            $0.layer.cornerRadius = 10
            //            $0.layer.borderWidth = 2
            $0.setTitleColor(.white, for: .normal)
            //            $0.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        }
        categoriesTextField.tintColor = .clear
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        descriptionTextView.layer.borderWidth = 1
    }
    @objc func customButtonTapped() {
        let edit = checkEdit().0
        
        if edit {
            showAlert()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    func checkEdit() -> (Bool,Bool){
        var edit = false
        var empty = false
        [detailAddressTextField,titleTextField,addressTextField,categoriesTextField].forEach{
            if $0?.text?.isEmpty == false{
                edit = true
            }else{
                empty = true
            }
        }
        if descriptionTextView.hasText {
            edit = true
        }
        return (edit,empty)
    }
    func showAlert() {
        let alertController = UIAlertController(title: "저장되지 않는 데이터가 있습니다", message: "편집을 그만하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    func configureCollectionView(){
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        self.imageCollectionView.register(AddImageCollectionViewCell.nib(), forCellWithReuseIdentifier: AddImageCollectionViewCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: Int(imageCollectionView.frame.size.width), height: Int(imageCollectionView.frame.size.height))
        imageCollectionView.collectionViewLayout = flowLayout
        imageCollectionView.allowsMultipleSelection = false
    }
    
    func showKakaoPostCodeVC() {
        let vc = KakaoPostCodeViewController()
        vc.addressDelegate = self
        let destinationViewController = UINavigationController(rootViewController: vc)
        self.present(destinationViewController, animated: true)
    }
}

extension AddPlaceViewController: AddressDelegate{
    func dataReceived(address: String) {
        self.addressTextField.text = address
    }
}

extension AddPlaceViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in // 4
                
                DispatchQueue.main.async {
                    if let image = object as? UIImage {
                        if self.index >= self.images.count {
                            self.images.append(image)
                        }else{
                            self.images[self.index] = image
                        }
                    }
                    self.imageCollectionView.reloadData()
                }
            }
        }
    }
    
    func showPHPicker(){
        configuarion.selectionLimit = 1
        configuarion.filter = .images
        let picker = PHPickerViewController(configuration: configuarion)
        picker.delegate = self
        self.present(picker,animated: true,completion:nil)
    }
}

extension AddPlaceViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageCollectionViewCell.identifier, for: indexPath) as? AddImageCollectionViewCell else{
            return UICollectionViewCell()
        }
        if indexPath.item < images.count {
            let item = images[indexPath.item]
            cell.configure(image: item)
        }else{
            cell.configure(image: UIImage(named: "emptyAddImage")!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row
        showPHPicker()
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.imageCollectionView.frame.width)
        self.pageControl.currentPage = page
    }
}

extension AddPlaceViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        categoriesTextField.inputView = pickerView
    }
    
    func dismissPickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonTapped))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        categoriesTextField.inputAccessoryView = toolBar
    }
    @objc func selectButtonTapped() {
        categoriesTextField.resignFirstResponder()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoriesTextField.text = categories[row].rawValue
        self.row = row
    }
    
}

extension AddPlaceViewController : CoordinateDelegate {
    func coordinateReceived(lng: String, lat: String) {
        let newPlace = Place(title: self.titleTextField.text!, categories: categories[row], position: "\(self.addressTextField.text!) \(self.detailAddressTextField.text!)", images: self.images, description: self.descriptionTextView.text!, isBooked: false, rating: 3.5, price: Int(self.priceTextField.text!)!, lng: Double(lng) ?? 0.0, lat: Double(lat) ?? 0.0)
        Place.data.append(newPlace)
        User.currentUser.hostPlace.append(newPlace)
        self.delegate?.addNewPlace()
    }
}

