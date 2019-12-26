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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Commands that close the keyboard tapping anywhere outside the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    


    
    /**
     Method that checks if the textfield pf the id is empty and if it is create an alert dialog
        This can be done by checking the name of the segue
     */
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let id = insertId.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        //Name of the segue
        if identifier == "guestSearchSegue" {
            if id == "" || id == nil{
                let alertController = UIAlertController(
                    title: "Alert",
                    message: "Id must not be empty",
                    preferredStyle: .alert
                    )
                alertController.addAction(UIAlertAction(title: "Cancel",style: .cancel))

                present(alertController, animated: true, completion: nil)
                return false
            }
        
        }

        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
    }
 */

}
