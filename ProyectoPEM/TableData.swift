//
//  TableData.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 28/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import Foundation

class TableData {
    
    var id_expList: [String]!
    var cell_lineList: [String]!
    var gi50List: [String]!
    var idSample: String?
    var notes: String?
    var smiles: String?
    var soluble: String?
    
    
    
    init(id_expList: [String],cell_lineList: [String],gi50List: [String],idSample: String,notes: String, smiles: String, soluble: String ) {

        self.id_expList = id_expList
        self.cell_lineList = cell_lineList
        self.gi50List = gi50List
        self.idSample = idSample
        self.notes = notes
        self.smiles = smiles
        self.soluble = soluble
        
    }
    
    func getIdExpList()->[String]{
        return id_expList
    }
    
    func getCellLineList()->[String]{
        return cell_lineList
       }
    
    func getGi50List()->[String]{
        return gi50List
       }
    
    func getIdSample()->String{
        return idSample!
    }
    
    func getNotes()->String{
        return notes!
       }
    
    func getSmiles()->String{
        return smiles!
       }
    
    func getSoluble()->String{
        return soluble!
    }
    
    
    
}
