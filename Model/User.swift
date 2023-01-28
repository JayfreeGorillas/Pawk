//
//  User.swift
//  Pawk
//
//  Created by Josfry Barillas on 1/5/23.
//

import Foundation

struct User {
    let username: String?
    let email: String?
    let icon: URL?
    let dog: [Dog]
}

struct Dog {
    let dogGender: String?
    let dogName: String?
    let dogAge: Int?
    let dogBreed: String?
    let weight: Int?
    let dateOfBirth: Date?
}

