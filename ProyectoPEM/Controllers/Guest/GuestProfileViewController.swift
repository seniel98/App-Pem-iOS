//
//  GuestProfileViewController.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 23/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import UIKit

class GuestProfileViewController: UIViewController {
    @IBOutlet weak var insertId: UITextField!
    
    var data: TableData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Guest Profile"
        
        //Commands that close the keyboard tapping anywhere outside the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    /**
        Method that checks if the textfield ff the id is empty and if it is create an alert dialog. If not, calls the model to look for results
        */

    @IBAction func searchPressed(_ sender: Any) {
        let model = GuestSearchModel()
        let id = insertId.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if id == "" || id == nil{
                       let alertController = UIAlertController(
                           title: "Alert",
                           message: "Id must not be empty",
                           preferredStyle: .alert
                           )
                       alertController.addAction(UIAlertAction(title: "Cancel",style: .cancel))

                       present(alertController, animated: true, completion: nil)
                    
        }else{
            model.search(id: id!){ (error) in
                if error{
                    let alertController = UIAlertController(
                        title: nil,
                        message: "No data found for that id",
                        preferredStyle: .alert
                        )
                    alertController.addAction(UIAlertAction(title: "Ok",style: .cancel))

                    self.present(alertController, animated: true, completion: nil)
                    self.insertId.text = ""
                }else{
                    self.data = model.getData()
                    //print(self.data?.getIdSample())
                    self.performSegue(withIdentifier: "guestSearchSegue", sender: Any?.self)
                    self.insertId.text = ""
                }
                
            }
        }
               
    }
    
   
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //Name of the segue
        if identifier == "guestSearchSegue" {
            return false
        }

        return false
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "guestSearchSegue"{
            if let destinationVC = segue.destination as? GuestViewController {
                destinationVC.data = self.data
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
    }
 

}
