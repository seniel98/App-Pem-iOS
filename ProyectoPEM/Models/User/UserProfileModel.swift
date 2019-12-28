//
//  UserSearchModel.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 26/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import Foundation
import Firebase

class UserProfileModel{
    
    func getUserEmail(completion: @escaping (Bool) -> Void)->String{
        let user = Auth.auth().currentUser
        print(Auth.auth().currentUser?.email)
        var email:String?
        if user != nil {
            email = Auth.auth().currentUser?.email
            completion(false)
        }else{
            email = "Error getting email"
            completion(true)
        }
        return email!
    }
    
    func logout(){
        let user = Auth.auth().currentUser
        if user != nil {
            try! Auth.auth().signOut()
            print("Logout sucessful")
        }
        
    }
    
    
}
