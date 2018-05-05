//
//  LoginUIViewController.swift
//  elChorrito
//
//  Created by d182_sofia_d on 05/05/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "salir", style: .plain, target: self, action: #selector(logoutUser))
        
    }
    @objc func logoutUser(){
        do{
            try Auth.auth().signOut()
            self.navigationController?.popViewController(animated: true)
        }catch _ {
            print("Pues error")
        }
    }

 
    

 

}
