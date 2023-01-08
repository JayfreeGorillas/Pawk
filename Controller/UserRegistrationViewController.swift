//
//  UserRegistrationViewController.swift
//  Pawk
//
//  Created by Josfry Barillas on 1/8/23.
//

import UIKit

class UserRegistrationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var data = [Int]()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        data.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(data[row])"
    }
    

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var numberOfDogs: UIPickerView!
    @IBOutlet var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfDogs.delegate = self
        numberOfDogs.dataSource = self
         data = setupPickerData()
        
        

    }
 

    func setupPickerData() -> [Int] {
        var pickerData = [Int]()
        for num in 1...50 {
            pickerData.append(num)
        }
        

    // numberOfComponents(in: <#T##UIPickerView#>)

        return pickerData
        
    }
    
   
}
