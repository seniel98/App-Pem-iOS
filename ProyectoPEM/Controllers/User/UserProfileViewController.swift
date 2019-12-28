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
    @IBOutlet weak var idTextField: UITextField!
    var model: UserProfileModel!
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        navigationItem.title = "User Profile"
        navigationItem.hidesBackButton = true
        helloLabel.text = "Hello," + getEmail() + "!"
        //Commands that close the keyboard tapping anywhere outside the keyboard
        
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        

        // Do any additional setup after loading the view.
    }
    
   
    
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        model = UserProfileModel()
        model.logout()
        //Go back to Home view
        navigationController?.popToRootViewController(animated: true)
       
      
    }
    
    func getEmail()->String{
        model = UserProfileModel()
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
