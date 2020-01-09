//
//  UserProfileViewController.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 23/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet weak var helloLabel: UILabel!
    
    var model = UserSearchModel()
    var data: TableData?
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        navigationItem.title = "User Profile"
        navigationItem.hidesBackButton = true
        helloLabel.text = "Hello," + getEmail() + "!"

        // Do any additional setup after loading the view.
    }
    
    //Method that prevents from executing the segue if we don´t implicitly call it to execute
    /*
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //Name of the segue
        if identifier == "userSearchSegue" {
            return false
        }

        return false
    }
 */
    
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        model.logout()
        //Go back to Home view
        navigationController?.popToRootViewController(animated: true)
       
      
    }
    
    func getEmail()->String{
        return model.getUserEmail(){ (emailError) in
            if !emailError{
                return
            }else{
                return
            }}
        
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
