//
//  LoginModel.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 26/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginModel{
    
    
    func login(email: String, password:String, completion: @escaping (Bool, Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) {(authResult,error) in
            if(error != nil){
                //Login fails
                
                completion(true,error)
            }else{
                print("Login succesful")
                print(Auth.auth().currentUser?.email)
                completion(false,error)
            }
        }
    }
}
