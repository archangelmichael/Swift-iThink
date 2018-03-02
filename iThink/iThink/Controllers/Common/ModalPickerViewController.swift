//
//  ModalPickerViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 28.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

protocol ModalPickerDelegate {
    func didSelectPickerItemId(item: PickerItem?) -> Void
}

class ModalPickerViewController: UIViewController {

    @IBOutlet weak var pvItems: UIPickerView!
    
    public static func getInstance(items: [PickerItem],
                                   selectedItem: PickerItem?,
                                   delegate: ModalPickerDelegate?) -> ModalPickerViewController? {
        let storyboard = UIStoryboard.init(name: StoryboardName.Common.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: self.defaultStoryboardIdentifier) as? ModalPickerViewController {
            vc.pickerItems = items
            vc.pickerDelegate = delegate
            vc.selectedItem = selectedItem
            return vc
        }

        return nil
    }
    
    var pickerDelegate: ModalPickerDelegate?
    var pickerItems : [PickerItem] = []
    var selectedItem : PickerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pvItems.dataSource = self
        self.pvItems.delegate = self
        
        if self.selectedItem == nil && self.pickerItems.count > 0 {
            self.selectedItem = self.pickerItems[0]
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func onDone(_ sender: Any) {
        self.pickerDelegate?.didSelectPickerItemId(item: self.selectedItem)
        self.goBack()
    }
}

extension ModalPickerViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerItems[row].name
    }
}

extension ModalPickerViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedItem = self.pickerItems[row]
    }
}


