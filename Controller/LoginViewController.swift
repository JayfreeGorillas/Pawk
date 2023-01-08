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
            //print(email, password)
            print(authResult?.user.email)
        }
        let testUser = createUser(dogs: testList)
        let nsarray = NSArray(array: testUser.dog)
        //self.ref.child("users").child("emailofsomething").setValue(["username": email])
        self.ref.child("users").child(testUser.username).setValue([
            "dogName": testUser.dog[0].dogName,
            "dogAge": testUser.dog[0].dogAge,
            "dogGender": testUser.dog[0].dogGender,
            "dogBreed": testUser.dog[0].dogBreed,
            "dogWeight": testUser.dog[0].weight
        ]
        )

    }
    
    @IBAction func registerButton(_ sender: Any) {
//        guard let email = usernameLabel.text else { return } // make sure its not empty
//        guard let password = passwordLabel.text else { return } // count more than 6
//
//        guard !email.isEmpty else { return }
//        guard password.count > 6 else { return } // if less than 6 show alert
//
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            print(email, password)
//          }
//        self.ref.child("users").child("emailofsomething").setValue(["username": email])
//        //self.ref.child("users").child(user.uid).setValue(["username": username])
    }
    @IBAction func skipLoginButton(_ sender: Any) {
        if let mapVC = storyboard?.instantiateViewController(withIdentifier: "mapVC") as? ViewController {
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
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


