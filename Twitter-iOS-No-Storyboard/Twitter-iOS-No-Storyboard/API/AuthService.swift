//
//  AuthService.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 9.07.2022.
//

import UIKit
import Foundation
import FirebaseAuth
import Firebase


struct AuthService {
    static let shared = AuthService()
    
    func register(profileImage: UIImage,
                  email: String,
                  password: String,
                  username: String,
                  fullname: String,
                  completion: @escaping (Error?, DatabaseReference?) -> Void
    ) {
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        storageRef.putData(imageData) { meta, error in
            storageRef.downloadURL { url, error in
                if let error = error {
                    // FIXME: - Handle error
                    return
                }
                guard let profileURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        // FIXME: - Handle error
                        return
                    }
                    guard let result = result else { return }
                    
                    let uid = result.user.uid
                    let values = ["email": email,
                                  "username": username,
                                  "fullname": fullname,
                                  "progileImageURL": profileURL]
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
            
        }
    }
    
    
}
