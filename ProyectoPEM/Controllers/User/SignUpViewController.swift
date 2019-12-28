//
//  SignUpViewController.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 23/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var repPwdTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sign Up"
        
        //Commands that close the keyboard tapping anywhere outside the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        

        // Do any additional setup after loading the view.
    }
    
    /**
    Method that checks if the form is correctly done and if it is not create an alert dialog
    This is done when the sign up button is pressed
    */
    
    @IBAction func signUpPressed(_ sender: Any) {
        let model = RegisterModel()
        var registerOk = true
        let email = emailTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = pwdTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let repPassword = repPwdTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            //Check if the fields are empty
            if fieldsEmpty(email: email!, password: password!, repPassword: repPassword!) {
                let alertController = UIAlertController(
                        title: nil,
                        message: "Fields must not be empty",
                        preferredStyle: .alert
                        )
                alertController.addAction(UIAlertAction(title: "OK",style: .cancel))
                
                present(alertController, animated: true, completion: nil)
                registerOk = false
            //Check if the email format is valid
            }else if !isEmailValid(email: email!){
                let alertController = UIAlertController(
                        title: nil,
                        message: "Email format not valid",
                        preferredStyle: .alert
                        )
                alertController.addAction(UIAlertAction(title: "OK",style: .cancel))

                present(alertController, animated: true, completion: nil)
                registerOk = false
            //Check if the password is valid
            }else if !isPasswordValid(password: password!){
                let alertController = UIAlertController(
                        title: nil,
                        message: "Passoword format not valid. Should contain at least one uppercase letter,one digit, one lowercase letter and 8 characters long",
                        preferredStyle: .alert
                        )
                alertController.addAction(UIAlertAction(title: "OK",style: .cancel))

                present(alertController, animated: true, completion: nil)
                registerOk = false
            //Check if the passwords match
            }else if password! != repPassword!{
                let alertController = UIAlertController(
                        title: nil,
                        message: "Passwords don't match",
                        preferredStyle: .alert
                        )
                alertController.addAction(UIAlertAction(title: "OK",style: .cancel))

                present(alertController, animated: true, completion: nil)
                registerOk = false
            }
        //If the form is correctly filled it is redirected to the previous view (Login)
        if registerOk{
             // Model call
            model.register(email: email!, password: password!) { (error) in
                if error {
                    let alertController = UIAlertController(
                            title: nil,
                            message: "Regisitration error",
                            preferredStyle: .alert
                            )
                    alertController.addAction(UIAlertAction(title: "OK",style: .cancel))
                    self.present(alertController, animated: true, completion: nil)
                    //Clear the inputs
                    self.emailTxtField.text = ""
                    self.pwdTxtField.text = ""
                    self.repPwdTxtField.text = ""
                    
                }else{
                    //Go back to sign in view
                    _ = self.navigationController?.popViewController(animated: true)
                    //Clear the inputs
                    self.emailTxtField.text = ""
                    self.pwdTxtField.text = ""
                    self.repPwdTxtField.text = ""
                    }
            }
        }
    }
    
    /**
     Method that checks if the fields of the signUp form are empty
     */
    
    func fieldsEmpty(email: String, password: String, repPassword: String)->Bool{
        
        if email == nil || password == nil || repPassword == nil ||
            email == "" || password == "" || repPassword == ""{
            return true
        }
        return false
    }
    
    
    /**
     Method that checks if the email format is valid
     */
    func isEmailValid(email: String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /**
     Method that checks if the password format is valid:
     At least one uppercase letter,one digit, one lowercase letter and 8 characters long
     */
    
    func isPasswordValid(password: String)->Bool{
        /**
         ^                        Start anchor
         (?=.*[A-Z])       Ensure string has one uppercase letter.
         (?=.*\\d)              Ensure string has one digit.
         (?=.*[a-z])        Ensure string has one lowercase letter.
         .{8}                      Ensure string is of length 8.
         $                         End anchor.
         */
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d\\S]{8,}$"
        
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
        
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
