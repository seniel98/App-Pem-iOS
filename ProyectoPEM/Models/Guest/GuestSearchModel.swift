//
//  GuestSearchModel.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 26/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import Foundation
import FirebaseDatabase

class GuestSearchModel{
    
    var data:TableData?
    var id_expList: [String] = []
    var cell_lineList: [String] = []
    var gi50List: [String] = []
    var idSample: String?
    var notes: String?
    var smiles: String?
    var soluble: String?
    
    
    
    func search(id: String, completion: @escaping (Bool) -> Void)->Void{
        Database.database().reference().child("products/STD/"+id).observeSingleEvent(of: .value, with: { (snapshot) in
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
                self.data = TableData(id_expList: self.id_expList, cell_lineList: self.cell_lineList, gi50List: self.gi50List, idSample: self.idSample!, notes: self.notes!, smiles: self.smiles!, soluble: self.soluble!)
                completion(false)
            }else{
                completion(true)
            }
        }) { (error) in
            print(error.localizedDescription)
            completion(true)
        }
    }
    
    func getData()->TableData{
        return data!
    }
}
