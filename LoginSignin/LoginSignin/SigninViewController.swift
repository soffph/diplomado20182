//
//  SigninViewController.swift
//  LoginSignin
//
//  Created by d182_sofia_d on 20/04/18. & jorge antonio mr

//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var psswdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signinBtn(_ sender: UIButton) {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let psswd = psswdTextField.text!
        
        if !name.isEmpty && !psswd.isEmpty && !email.isEmpty{
            makeSignin(name: name, email: email, pswd: psswd)
        }
    }
    func makeSignin(name: String, email: String, pswd: String){
        let userBody = ["name":name,"email":email,"password":pswd]
        let body = ["user":userBody]
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ioslab.herokuapp.com"
        components.path = "/sign_up"
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print("Error en el request: ",error)
                return
            }
            if let data = data, let response = response as? HTTPURLResponse{
                switch response.statusCode{
                case 201: //201 usuario creado
                    do {
                        let json_ = try JSONSerialization.jsonObject(with: data, options: [])
                        if let  json = json_ as? [String:Any]{
                            let token = json["token"]
                            let id = json["id"]
                            print("TOKEN:",token)
                            print("id",id)
                        }
                    }catch(let err){
                        print(err)
                    }
                default:
                    print("default",response)
                }
            }else{
                print("no hay internet")
            }
        }.resume()
    }

}
