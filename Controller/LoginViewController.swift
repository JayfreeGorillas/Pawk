//
//  LoginViewController.swift
//  Pawk
//
//  Created by Josfry Barillas on 1/5/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    var ref: DatabaseReference!
    var testList = [Dog]()
    
    
    var testDog = Dog(dogGender: "F", dogName: "Mochi", dogAge: 1, dogBreed: "Pug", weight: 10, dateOfBirth: nil)

    @IBOutlet var usernameLabel: UITextField!
    
    @IBOutlet var passwordLabel: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = usernameLabel.text else { return }
        guard let password = passwordLabel.text else { return }
        
        guard !email.isEmpty else { return }
        guard password.count > 6 else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            print(authResult)
            guard authResult != nil else {
                let alertController = UIAlertController(title:"Something Went Wrong" , message: error?.localizedDescription, preferredStyle: .alert)
                let doneAction = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(doneAction)
                self!.present(alertController, animated: true)
                return
            }
            if let dogMapVC = self?.storyboard?.instantiateViewController(withIdentifier: "mapVC") as? ViewController {
                self?.navigationController?.pushViewController(dogMapVC, animated: true)
            }
            //print(email, password)
            
            print(authResult?.user.email)
        }
    
        

    }
    
    @IBAction func registerButton(_ sender: Any) {

    }
    @IBAction func skipLoginButton(_ sender: Any) {
        
        performSegue(withIdentifier: "skipToMap", sender: sender)
//        if let mapVC = storyboard?.instantiateViewController(withIdentifier: "mapVC") as? ViewController {
//            self.navigationController?.pushViewController(mapVC, animated: true)
//        }
           }
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference()
        testList.append(testDog)
        // Do any additional setup after loading the view.
        //var user = User(username: "yaboi", icon: nil, dog: testList)
    }
    
    func createUser(dogs: [Dog]) -> User {
//        let user = User(username: "Josfry", icon: nil, dog: dogs)
        let user = User(username: "Jori", email: "jori@jori.com", icon: nil, dog: dogs)
        
        return user
    }
}

extension LoginViewController {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setNeedsLayout()

    }
}

extension LoginViewController {
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}
