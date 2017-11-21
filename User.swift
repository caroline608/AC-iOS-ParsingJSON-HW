//
//  User.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Keshawn Swanston on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ResultsWrapper: Codable {
    let results: [Contact]
}

struct Contact: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
    let picture: PictureWrapper
    
    
}

struct NameWrapper: Codable {
    let title: String
    let first: String
    let last: String
    var fullName: String {
        return "\(first) \(last)"
    }
    var sectionName: (letter: String, number: Int) {
        let abcDict: [String: Int] = ["a": 1, "b": 2, "c": 3, "d": 4, "e":5, "f":6, "g":7, "h":8, "i": 9, "j":10, "k": 11, "l":12, "m": 13, "n":14, "o":15, "p":16, "q":17, "r":18, "s":19, "t":20, "u":21, "v":22, "w":23, "x":24, "y":25, "z":26]
        let letter = first.characters.first!.description
        return ("\(letter.capitalized)",abcDict[letter]!)
    }
}

struct LocationWrapper: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}

struct PictureWrapper: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

