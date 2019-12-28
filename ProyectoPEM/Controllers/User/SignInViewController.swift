//
//  SignInViewController.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 23/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    
    var doSegue = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sign In"
        
        //Commands that close the keyboard tapping anywhere outside the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    /**
     Method that ensure us to do the login correctly asynchronus
     */
   
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
          //Name of the segue
          if identifier == "userProfileSegue" {
            return false
          }
        return false
      }
    
    
    
    @IBAction func loginPressed(_ sender: Any) {
        let model = LoginModel()
        var loginOk = true
        let email = emailTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = pwdTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if fieldsEmpty(email: email!, password: password!){
            let alertController = UIAlertController(
                    title: nil,
                    message: "Fields must not be empty",
                    preferredStyle: .alert
                    )
            alertController.addAction(UIAlertAction(title: "OK",style: .cancel))
                          
            present(alertController, animated: true, completion: nil)
            loginOk = false
        }else if !isEmailValid(email: email!){
            let alertController = UIAlertController(
                title: nil,
                message: "Email format not valid",
                preferredStyle: .alert
                )
            alertController.addAction(UIAlertAction(title: "OK",style: .cancel))

            present(alertController, animated: true, completion: nil)
            loginOk = false
        }
        
        //If the inputs are correctly filled it is redirected to the next view (UserProfile)
        if loginOk{
            // Model call
            model.login(email: email!, password: password!){(result,error) in
                if result{
                    let alertController = UIAlertController(
                        title: nil,
                        message: error?.localizedDescription,
                        preferredStyle: .alert
                        )
                    alertController.addAction(UIAlertAction(title: "OK",style: .cancel))
                    self.present(alertController, animated: true, completion: nil)
                    //Clear the inputs
                    self.emailTxtField.text = ""
                    self.pwdTxtField.text = ""
                }else{
                    //Login ok
                    //self.doSegue = true
                    self.performSegue(withIdentifier: "userProfileSegue", sender: Any?.self)
                    //self.shouldPerformSegue(withIdentifier: "userProfileSegue", sender: Any?.self)
                }
            }
        }
        self.emailTxtField.text = ""
        self.pwdTxtField.text = ""
    }
 
    @IBAction func signUpPressed(_ sender: Any) {
        performSegue(withIdentifier: "signUpSegue", sender: Any?.self)
    }
    
    /**
     Method that checks if the fields of the signUp form are empty
     */
    
    func fieldsEmpty(email: String, password: String)->Bool{
        
        if email == nil || password == nil ||
            email == "" || password == "" {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "userProfileSegue" {
            if let nextViewController = segue.destination as? UserProfileViewController {
                nextViewController.helloLabel.text = "Hello, " + emailTxtField.text! + "!"  //Or pass any values
            }
        }
    }
 */
    
}
