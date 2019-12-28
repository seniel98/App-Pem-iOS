//
//  ViewController.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 23/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                self.goToProfile()
            }
        }
            
        
        // Do any additional setup after loading the view.
    }
    
    func goToProfile(){
        navigationController?.pushViewController((storyboard?.instantiateViewController(withIdentifier: "userProfile"))!, animated: true)
    }


}

