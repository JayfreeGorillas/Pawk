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

class DogFormViewController: UIViewController, ModalViewControllerDelegate {
    var ref: DatabaseReference!
    
    func passValue(value: String) {
        print(value)
        dogBreedChoiceLabel.text = value
    }
    
   
    //@IBOutlet var dogNameTextField: UITextField!
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var numOfUsersDogs: Int = 0
    var dogBreed: String = ""
// MARK: connect dog entries
    @IBOutlet var dogGender: UISegmentedControl!
    
   
    @IBOutlet var dogWeightTextLabel: UITextField!
    @IBOutlet var dogAgeTextField: UITextField!
    @IBOutlet var dogBreedChoiceLabel: UILabel!
    @IBAction func showDogBreedList(_ sender: Any) {
        
        performSegue(withIdentifier: "dogBreedList", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToMapVC" {
            let vc = segue.destination as? ViewController
        } else {
            guard let dogBreedVC = segue.destination as? DogBreedChoiceViewController else { return }
            dogBreedVC.delegate = self
        }
       
    }
    // @IBOutlet var dogBreedSelectionButton: UIButton!// TODO: change to action
   // @IBOutlet var dogWeight: UITextField!
    @IBOutlet var dogAge: UITextField!
    @IBOutlet var dogNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        

       // print(username,email,password,numOfUsersDogs)
      //  printStuffAfterStuff()

    }
    @IBAction func registerAccountAndDogs(_ sender: Any) {
        //TODO:  setup creation of account
        print(dogBreed)
        print(dogBreedChoiceLabel.text)
        //var selection = dogGender.selectedSegmentIndex
        let choice = genderChoice()
        let dog = createUsersDogs()
        // TODO: ADD ERROR HANDLING - ints only for age and weight
        print(dog)
        print(choice)
        let user = User(username: username, email: email, icon: nil, dog: dog)
//        print(user.username,user.email,user.dog[0].dogName)
        let nsarray = NSArray(array: user.dog)
        // TODO
        self.ref.child("Users").child(username).child("email").setValue(email)
        self.ref.child("Users").child(username).child("dogs").setValue([
            "dogName": user.dog[0].dogName,
            "dogAge": user.dog[0].dogAge,
            "dogGender": user.dog[0].dogGender,
            "dogBreed": user.dog[0].dogBreed,
            "dogWeight": user.dog[0].weight
        ])
//        self.ref.child("Users").child(username).setValue([
//
//        ])
//        if let dogMapVC = storyboard?.instantiateViewController(withIdentifier: "mapVC") as? ViewController {
//            self.navigationController?.pushViewController(dogMapVC, animated: true)
//        }
        
    }
    func genderChoice() -> String {
        let selection = dogGender.selectedSegmentIndex
        if selection == 0 {
            return "Male"
        } else {
            return "Female"
        }
    }
    
    func registerAccount() {
       // let user = User
        print(username,email,password,numOfUsersDogs,dogBreed,dogAge.text,dogNameTextField.text,dogAgeTextField.text )
    }
  
   
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    func createUsersDogs() -> [Dog]  {
        var dogs = [Dog]()
        if let dogName = dogNameTextField.text,
            let dogAge = dogAgeTextField.text,
            let dogWeight = dogWeightTextLabel.text,
            let dogBreedChoice = dogBreedChoiceLabel.text,
            let doggyWeight = Int(dogWeight),
            let doggyAge = Int(dogAge) {
                let userDogs = Dog(dogGender: genderChoice(), dogName: dogName, dogAge: doggyAge, dogBreed: dogBreedChoice, weight: doggyWeight, dateOfBirth: nil)
                    dogs.append(userDogs)
        }
        print(dogs)
        return dogs
    }
    
    
//TODO:  Come up with a method to create a user out of this information as well as their dogs information to be uploaded onto firebase
    
// MARK: Method to add a selected photo UIIMAGEPICKERSOMETHING
    
// MARK:  Present dog breed list modally in a table view
/*

     
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

