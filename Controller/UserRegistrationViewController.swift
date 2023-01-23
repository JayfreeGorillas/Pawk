//
//  UserRegistrationViewController.swift
//  Pawk
//
//  Created by Josfry Barillas on 1/8/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore


class UserRegistrationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var data = [Int]()
    var numOfDogs = 0
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    // registers the users account on firebase while catching any entry errors/mistakes and passing to ->  dogFormVC
    @IBAction func registerAccount(_ sender: Any) {
        //create a user
        //handle errors in textFields/selections
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let user = User(username: username, email: email, icon: nil, dog: [])
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            print(authResult, error?.localizedDescription)
                   
            
         
            
            guard authResult != nil else {
                let alertController = UIAlertController(title:"Something Went Wrong" , message: error?.localizedDescription, preferredStyle: .alert)
                let doneAction = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(doneAction)
                self.present(alertController, animated: true)
                return
            }
            if let dogFormVC = self.storyboard?.instantiateViewController(withIdentifier: "dogFormSB") as? DogFormViewController {
                dogFormVC.email = email
                dogFormVC.username = username
                dogFormVC.password = password
                self.navigationController?.pushViewController(dogFormVC, animated: true)
            }
           

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
extension UserRegistrationViewController {
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}
