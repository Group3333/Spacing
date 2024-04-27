//
//  TimeSelectionVC.swift
//  Spacing
//
//  Created by 서혜림 on 4/23/24.
//

import UIKit

protocol TimeSelectionDelegate: AnyObject {
    func timeSelected(_ hours: Int)
}

class TimeSelectionVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Properties
    
    weak var delegate: TimeSelectionDelegate?
    let hours = Array(1...24)
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var timeList: UIPickerView!
    @IBOutlet weak var selectBtn: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func selectBtnClicked(_ sender: Any) {
        guard let selectedRow = timeList?.selectedRow(inComponent: 0), selectedRow != -1 else {
            return
        }
        
        let selectedHour = hours[selectedRow]
        delegate?.timeSelected(selectedHour)
        dismiss(animated: true) // 화면 닫기
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeList.dataSource = self
        timeList.delegate = self
        
        timeList.selectRow(0, inComponent: 0, animated: false)
        
        selectBtn.setTitle("확인", for: .normal)
        selectBtn.setTitleColor(.white, for: .normal)
        selectBtn.backgroundColor = .spacingOrange
        selectBtn.layer.cornerRadius = 10
        selectBtn.layer.masksToBounds = true
    }
    
    // MARK: - Methods
    
    // UIPickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
    
    // UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(hours[row]) 시간"
    }
}
