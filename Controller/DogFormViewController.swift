//
//  DogFormViewController.swift
//  Pawk
//
//  Created by Josfry Barillas on 1/8/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class DogFormViewController: UIViewController {
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var numOfUsersDogs: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print(username,email,password,numOfUsersDogs)
        printStuffAfterStuff()

    }
    
    
    func printStuffAfterStuff() {
        print(username,email,password,numOfUsersDogs)
    }
//TODO:  Come up with a method to create a user out of this information as well as their dogs information to be uploaded onto firebase
    
// MARK: Method to add a selected photo UIIMAGEPICKERSOMETHING
    
// MARK:  Present dog breed list modally in a table view
/*
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
     
     func createUser(dogs: [Dog]) -> User {
 //        let user = User(username: "Josfry", icon: nil, dog: dogs)
         let user = User(username: "Jori", email: "jori@jori.com", icon: nil, dog: dogs)
         
         return user
     }
     
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
    */

}
