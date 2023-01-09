//
//  UserRegistrationViewController.swift
//  Pawk
//
//  Created by Josfry Barillas on 1/8/23.
//

import UIKit

class UserRegistrationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var data = [Int]()
    var numOfDogs = 0
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        //let picker = pickerView(numberOfDogs, didSelectRow: , inComponent: <#T##Int#>)
        
        if segue.identifier == "goToDogForm" {
            let vc = segue.destination as? DogFormViewController
            vc?.username = username
            vc?.email = email
            vc?.password = password
            vc?.numOfUsersDogs = numOfDogs
            
           // vc?.numOfUsersDogs =
        }
    }
    
    func passData() {
//        guard let email = emailTextField.text else { return }
//        guard let username = usernameTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
        
        
        
        //pickerView(numberOfDogs, didSelectRow: data[], inComponent: 1)
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        data.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(data[row])"
    }
    
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedRow = data[row]
        print(selectedRow)
       numOfDogs = selectedRow
       print(numberOfDogs)
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
extension ViewController {
 
}
