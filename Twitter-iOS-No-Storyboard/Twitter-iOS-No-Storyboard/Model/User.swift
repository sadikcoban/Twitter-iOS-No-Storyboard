//
//  User.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 10.07.2022.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let username: String
    let profileImageURL: String
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]){
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageURL = dictionary["progileImageURL"] as? String ?? ""
        self.uid = uid
    }
}
