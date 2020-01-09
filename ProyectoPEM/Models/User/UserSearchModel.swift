//
//  UserSearchModel.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 26/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import Foundation
import Firebase

class UserSearchModel{
    
    var data: TableData?
    var id_expList: [String] = []
    var cell_lineList: [String] = []
    var gi50List: [String] = []
    var idSample: String?
    var notes: String?
    var smiles: String?
    var soluble: String?
    
    var userId:String?
    
    
    
    func getUserId(completion: @escaping (Bool,String)->Void)->Void{
        let user = Auth.auth().currentUser
        if user != nil{
            Database.database().reference().child("users/" + (user?.uid)!).observeSingleEvent(of: .value, with:{ (snapshot) in
                // Retrieve whole data and store it in a dictionary constant
                let value = snapshot.value as? NSDictionary
                // Store id value in a String
                self.userId = value?["id"] as? String
                
                if self.userId == nil || self.userId == ""{
                    completion(true,"User don't have an id. Please contact jmpadron@ull.edu.es")
                    return
                }else{
                    completion(false,"OK")
                    return
                }
                    
                })
        }
      
    }
    
    
   func search(id: String, completion: @escaping (Bool) -> Void)->Void{
    Database.database().reference().child("products/" + userId! + "/" + id).observeSingleEvent(of: .value, with: { (snapshot) in
           // Retrieve whole data and store it in a dictionary constant
           let value = snapshot.value as? NSDictionary
           //print(value)
           if value != nil{
               var x = 1
               self.idSample = value?["id_sample"] as? String ?? ""
               self.notes = value?["notes"] as? String ?? ""
               self.smiles = value?["smiles"] as? String ?? ""
               self.soluble = value?["soluble"] as? String ?? ""
               while true{
                   var gi50 = value?["gL50_" + x.description] as? String
                   var cellLine = value?["cell_line_" + x.description] as? String
                   var idExp = value?["id_exp_" + x.description] as? String
                   if gi50 != nil{
                       //Here we retrieve data and store it in lists
                       self.gi50List.append(gi50!)
                       self.cell_lineList.append(cellLine!)
                       self.id_expList.append(idExp!)
                   }else{
                       break
                   }
                   x+=1
               }
               //When everything is added we create an object of the class TableData
            self.data = TableData(userid: self.userId!,idSearch: id,id_expList: self.id_expList, cell_lineList: self.cell_lineList, gi50List: self.gi50List, idSample: self.idSample!, notes: self.notes!, smiles: self.smiles!, soluble: self.soluble!)
               completion(false)
           }else{
               completion(true)
           }
       })
   }
   
   func getData()->TableData{
       return data!
   }
    
    
    
    
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
