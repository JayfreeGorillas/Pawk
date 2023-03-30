//
//  AccountViewController.swift
//  Pawk
//
//  Created by Josfry Barillas on 1/24/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore



class AccountViewController: UIViewController {
    var ref: DatabaseReference!
    var currentUser = Auth.auth().currentUser

    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var weightLAbel: UILabel!
    @IBOutlet var breedLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    override func viewDidLoad()  {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        let fireBaseDogReference = ref.child("Users").child(currentUser!.uid).getData { error, snapshot in
            //print(snapshot?.value)
            let value = snapshot?.value as? NSDictionary
            print(value)
            let dogs = value?["dogs"] as? NSDictionary
            print(dogs)
          
            let name    = dogs?["dogName"] as? String ?? ""
            let gender  = dogs?["dogGender"] as? String ?? ""
            let breed   = dogs?["dogBreed"] as? String ?? ""
            let weight  = dogs?["dogWeight"] as? Int ?? 0
            let age     = dogs?["dogAge"] as? Int ?? 0
            
            let userDog = Dog(dogGender: gender, dogName: name, dogAge: age, dogBreed: breed, weight: weight, dateOfBirth: nil)
            dump(userDog)
            //let dog = Do
           // guard let m = snapshot?.valueInExportFormat() else { return }
            
            print(userDog.dogName)
            print(value)
            
            
            
            guard let dogName = userDog.dogName else { return }
            guard let dogGender = userDog.dogGender else { return }
            guard let dogBreed = userDog.dogBreed else { return }
            guard let dogAge = userDog.dogAge else { return }
            guard let dogWeight = userDog.weight else { return }
            
            //var doggy = snapshot?.value(UserDog.Type)
           // print(snapshot?.value(forKey: "dogName"))
            print(self.currentUser?.email, self.currentUser?.uid)
            //print(snapshot?.value)
            self.nameLabel.text = "Dog name: \(dogName)"
            self.genderLabel.text = "Gender: \(dogGender)"
            self.breedLabel.text = "Breed: \(dogBreed)"
            self.weightLAbel.text = "Weight \(dogWeight)"
            self.ageLabel.text = "Age: \(dogAge)"
        }
//            print(snapshot.value)
//            print(snapshot.childrenCount)
//            print(snapshot.ref.child("Users").child(user.).getData(completion: { Error, snapshot in
//                print(snapshot?.value)
//                print(snapshot?.childrenCount)
//            }))
        }
//        var printRefOnce = ref.child("Users").getData { error, snapshot in
//            guard error == nil else {
//                print(error?.localizedDescription)
//                return
//            }
//            print(self.ref.child("Users").getData(completion: { error, snapshot in
//                guard error == nil else {
//                    print(error?.localizedDescription)
//                    return
//                }
//            }))
//            let username = snapshot?.value as? String ?? "Unknown"
//            print(username)
//
//        }
    

        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    class UserDog {
        var name: String = ""
        var age: Int = 0
        
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
        
        func getName() {
            print(name)
        }
        
        func getAge() {
            print(age)
        }
    }
}
