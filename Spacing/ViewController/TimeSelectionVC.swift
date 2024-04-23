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
    
    
    @IBOutlet weak var timeList: UIPickerView!
    
    weak var delegate: TimeSelectionDelegate?
    let hours = Array(1...24) // 1부터 24까지의 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            timeList.dataSource = self
            timeList.delegate = self
        
        timeList.selectRow(0, inComponent: 0, animated: false)
    }
    
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
    
    
    @IBAction func selectBtn(_ sender: Any) {
        guard let selectedRow = timeList?.selectedRow(inComponent: 0), selectedRow != -1 else {
            // timeList가 nil이거나 선택한 행이 없는 경우
            // 오류 처리 또는 경고 메시지를 표시할 수 있습니다.
            return
        }
        
        let selectedHour = hours[selectedRow]
        delegate?.timeSelected(selectedHour) // 델리게이트로 선택한 시간 전달
        dismiss(animated: true) // 화면 닫기
    }
}
