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
        
        guard !email.isEmpty else { print("bad email"); return } // handle errors
        guard password.count > 6 else { print("bad password"); return } // handle errors
        
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
            self?.performSegue(withIdentifier: "loginToMapVC", sender: sender)

            print(authResult?.user.email)
            //TODO: GRAB THIS DATA TO PASS ON
            if let user = authResult?.user {
              // The user's ID, unique to the Firebase project.
              // Do NOT use this value to authenticate with your backend server,
              // if you have one. Use getTokenWithCompletion:completion: instead.
              let uid = user.uid
              let email = user.email
              let photoURL = user.photoURL
              var multiFactorString = "MultiFactor: "
              for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
                print(multiFactorString)
              }
                print(user.email, user.displayName)
              // ...
            }
        }
    
        

    }
    
    @IBAction func registerButton(_ sender: Any) {

    }
    @IBAction func skipLoginButton(_ sender: Any) {

           }
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference()
        testList.append(testDog)
        // Do any additional setup after loading the view.
    }
    

}

extension LoginViewController {
    override func viewWillAppear(_ animated: Bool) {
        var handle = Auth.auth().addStateDidChangeListener { auth, user in
            print(auth.currentUser?.email)
            //handle if user is already signed in
//            if auth.currentUser != nil {
//                self.performSegue(withIdentifier: "loginToMapVC", sender: Any?.self)
//            }
        }
        navigationController?.navigationBar.setNeedsLayout()
    }
}

extension LoginViewController {
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}
