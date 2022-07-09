//
//  Constants.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 9.07.2022.
//

import Firebase
import FirebaseStorage

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
