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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
      
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

}
