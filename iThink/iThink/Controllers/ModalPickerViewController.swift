//
//  ModalPickerViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 28.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ModalPickerViewController: UIViewController {

    @IBOutlet weak var pvItems: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func onDone(_ sender: Any) {
        self.goBack()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
