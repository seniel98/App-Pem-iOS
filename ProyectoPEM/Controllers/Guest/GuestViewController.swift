//
//  GuestViewController.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 23/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import UIKit

class GuestViewController: UIViewController {
    
    var data: TableData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        print(data?.getIdSample())
        
        navigationItem.title = "Guest Viewer"

        // Do any additional setup after loading the view.
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
