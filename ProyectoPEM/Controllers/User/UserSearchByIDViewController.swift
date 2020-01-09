//
//  UserSearchByIDViewController.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 30/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import UIKit

class UserSearchByIDViewController: UIViewController {
    
    var model = UserSearchModel()
    var data: TableData?
    
    @IBOutlet weak var idTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search by ID"
        // Do any additional setup after loading the view.
         //Commands that close the keyboard tapping anywhere outside the keyboard
               
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
               
    }
    
    
    @IBAction func searchPressed(_ sender: Any) {
           let id = idTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
             
             if id == "" || id == nil{
                 let alertController = UIAlertController(
                         title: "Alert",
                         message: "Id must not be empty",
                         preferredStyle: .alert
                         )
                 alertController.addAction(UIAlertAction(title: "Cancel",style: .cancel))
                 
                 present(alertController, animated: true, completion: nil)
                                
              }else{
                 model.getUserId(){(error,msg) in
                     if error{
                         let alertController = UIAlertController(
                                 title: "Error",
                                 message: msg,
                                 preferredStyle: .alert
                                 )
                         alertController.addAction(UIAlertAction(title: "OK",style: .cancel))
                     
                         self.present(alertController, animated: true, completion: nil)
                         self.idTextField.text = ""
                     }else{
                         self.model.search(id: id!){ (error) in
                             if error{
                                 let alertController = UIAlertController(
                                         title: nil,
                                         message: "No data found for that id",
                                         preferredStyle: .alert
                                         )
                                 alertController.addAction(UIAlertAction(title: "Ok",style: .cancel))

                                 self.present(alertController, animated: true, completion: nil)
                                 self.idTextField.text = ""
                             }else{
                                 self.data = self.model.getData()
                                 //print(self.data?.getIdSample())
                                 self.performSegue(withIdentifier: "userSearchByIdSegue", sender: Any?.self)
                                 self.idTextField.text = ""
                             }
                         }
                     }
                 }
             }
    }
    
    
    //Method that prevents from executing the segue if we don´t implicitly call it to execute
     
     override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
         //Name of the segue
         if identifier == "userSearchByIdSegue" {
             return false
         }

         return false
     }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "userSearchByIdSegue"{
            if let destinationVC = segue.destination as? UserViewController {
                destinationVC.data = self.data
            }
        }
    }
    

}
