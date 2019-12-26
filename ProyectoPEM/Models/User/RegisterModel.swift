//
//  RegisterModel.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 26/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase

class RegisterModel{
    

    
    func register(email:String,password:String,completion: @escaping (Bool) -> Void){
        let ref = Database.database().reference()
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
           //If user was created
            if let user = authResult?.user{
                //Add user to users in database and set as a value the email
                //ref.child("users").child(user.uid).setValue(["email": email])
                completion(false)
        
            }else{
                //Error creating the user
                completion(true)
                
            }
            
        }
    }
    
}
